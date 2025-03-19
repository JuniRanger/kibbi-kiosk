import 'dart:async';
import 'package:kibbi_kiosk/src/core/di/dependency_manager.dart';
import 'package:kibbi_kiosk/src/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'shop_state.dart';
import 'package:kibbi_kiosk/src/models/data/order_data.dart';

class ShopNotifier extends StateNotifier<ShopState> {
  Timer? _searchProductsTimer;
  Timer? _searchCategoriesTimer;

  ShopNotifier() : super(const ShopState());

  setOrder(OrderData? order) {
    state = state.copyWith(selectedOrder: order);
  }

  fetchData({required BuildContext context}) {
    LocalStorage.deleteCartProducts();
    fetchProducts(context: context, isRefresh: true);
    fetchCategories(context: context);
  }

  Future<void> fetchProducts({
    required BuildContext context,
    bool? isRefresh,
  }) async {
    final connected = await AppConnectivity.connectivity();
    if (!connected) {
      AppHelpers.showSnackBar(context, 'Revisa tu conexión');
      return;
    }

    state = state.copyWith(isProductsLoading: true, products: []);

    try {
      final response = state.selectedCategory?.id != null
          ? await productsRepository.getProductsByCategoryId(
              categoryId: state.selectedCategory!.id!,
            )
          : await productsRepository.getProductsPaginate(
              query: state.query.isEmpty ? null : state.query,
            );

      response.when(
        success: (data) {
          final updatedAllProducts = [...state.allProducts];

          for (var product in data) {
            if (!updatedAllProducts.any((p) => p.id == product.id)) {
              updatedAllProducts.add(product);
            }
          }

          state = state.copyWith(
            products: data, // Productos de la categoría actual
            allProducts:
                updatedAllProducts, // Todos los productos sin duplicados
            isProductsLoading: false,
          );
        },
        failure: (failure, status) {
          state = state.copyWith(isProductsLoading: false);
          debugPrint('==> get products failure: $failure');
          AppHelpers.showSnackBar(context, failure);
        },
      );
    } catch (e) {
      state = state.copyWith(isProductsLoading: false);
      debugPrint('==> fetch products failure: $e');
      AppHelpers.showSnackBar(context, 'Error al cargar los productos');
    }
  }

  void setProductsQuery(BuildContext context, String query) {
    if (state.query == query) {
      return;
    }

    state = state.copyWith(query: query.trim());

    if (_searchProductsTimer?.isActive ?? false) {
      _searchProductsTimer?.cancel();
    }

    _searchProductsTimer = Timer(
      const Duration(milliseconds: 500),
      () async {
        // Obtener todos los productos y categorías
        final productResponse = await productsRepository.getProductsPaginate();
        final categoryResponse = await categoriesRepository.searchCategories();

        productResponse.when(
          success: (allProducts) {
            categoryResponse.when(
              success: (categoriesData) {
                // Crear un mapa {categoryId: categoryName}
                final categoryMap = {
                  for (var c in categoriesData) c.id: c.name!.toLowerCase()
                };

                // Filtrar productos por nombre o categoría
                final filteredProducts = allProducts.where((product) {
                  final matchesName = product.name!
                      .toLowerCase()
                      .contains(state.query.toLowerCase());
                  final matchesCategory = categoryMap[product.category]
                          ?.contains(state.query.toLowerCase()) ??
                      false;
                  return matchesName || matchesCategory;
                }).toList();

                state = state.copyWith(products: filteredProducts);
              },
              failure: (error, status) {
                debugPrint('Error al obtener categorías: $error');
              },
            );
          },
          failure: (error, status) {
            debugPrint('Error al obtener productos: $error');
          },
        );
      },
    );
  }

  Future<void> fetchCategories({required BuildContext context}) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(
        isCategoriesLoading: true,
        dropDownCategories: [],
        categories: [],
      );
      final response = await categoriesRepository.searchCategories();
      response.when(
        success: (data) {
          // data es una List<CategoryData>
          state = state.copyWith(
            isCategoriesLoading: false,
            categories: data, // Guardar la lista de categorías directamente
          );
        },
        failure: (failure, status) {
          state = state.copyWith(isCategoriesLoading: false);
          debugPrint('==> get categories failure: $failure');
        },
      );
    } else {
      AppHelpers.showSnackBar(
        context,
        'Revisa tu conexión',
      );
    }
  }

  void setCategoriesQuery(BuildContext context, String query) {
    debugPrint('===> set categories query: $query');
    if (state.categoryQuery == query) {
      return;
    }
    state = state.copyWith(categoryQuery: query.trim());
    if (_searchCategoriesTimer?.isActive ?? false) {
      _searchCategoriesTimer?.cancel();
    }
    _searchCategoriesTimer = Timer(
      const Duration(milliseconds: 500),
      () {
        state = state.copyWith(categories: [], dropDownCategories: []);
        fetchCategories(context: context);
      },
    );
  }

  void setSelectedCategory(BuildContext context, int index) {
    if (index == -1) {
      state = state.copyWith(selectedCategory: null);
    } else {
      final category = state.categories[index];
      if (category.id != state.selectedCategory?.id) {
        state = state.copyWith(selectedCategory: category);
      } else {
        state = state.copyWith(selectedCategory: null);
      }
    }

    fetchProducts(context: context);
    setCategoriesQuery(context, '');
  }

  void removeSelectedCategory(BuildContext context) {
    state = state.copyWith(selectedCategory: null);
    fetchProducts(context: context);
  }
}
