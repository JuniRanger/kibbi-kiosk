import 'dart:async';
import 'package:kiosk/src/core/constants/constants.dart';
import 'package:kiosk/src/core/di/dependency_manager.dart';
import 'package:kiosk/src/core/utils/utils.dart';
import 'package:kiosk/src/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'shop_state.dart';
import 'package:kiosk/src/models/data/order_data.dart';

class ShopNotifier extends StateNotifier<ShopState> {
  Timer? _searchProductsTimer;
  Timer? _searchCategoriesTimer;
  Timer? _searchBrandsTimer;
  int _page = 0;

  ShopNotifier() : super(const ShopState());

  setOrder(OrderData? order) {
    state = state.copyWith(selectedOrder: order);
  }

  // setShop({required RestaurantData? shop, required BuildContext context}) {
  //   LocalStorage.deleteCartProducts();
  //   state = state.copyWith(selectedShop: shop);
  //   fetchProducts(context: context, isRefresh: true);
  //   fetchCategories(context: context);
  // }

  fetchData({required BuildContext context}) {
    // Eliminar productos del carrito (si es necesario, aunque no tiene que ver con 'shop')
    LocalStorage.deleteCartProducts();
    
    // Realizar los fetcheos de productos y categorías sin necesidad de usar 'shop'
    fetchProducts(context: context, isRefresh: true);
    fetchCategories(context: context);
  }

  

  Future<void> fetchProducts({
    required BuildContext context,
    bool? isRefresh,
  }) async {
    if (isRefresh ?? false) {
      _page = 0;
    } else if (!state.hasMore) {
      return;
    }
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      if (_page == 0) {
        state = state.copyWith(isProductsLoading: true, products: []);
        final response = await productsRepository.getProductsPaginate(
          page: ++_page,
          query: state.query.isEmpty ? null : state.query,
          shopId: state.selectedShop?.id,
          categoryId: state.selectedCategory?.id,
          brandId: state.selectedBrand?.id,
        );
        response.when(
          success: (data) {
            state = state.copyWith(
              products: data.data ?? [],
              isProductsLoading: false,
            );
            if ((data.data?.length ?? 0) < 12) {
              state = state.copyWith(hasMore: false);
            }
          },
          failure: (failure, status) {
            state = state.copyWith(isProductsLoading: false);
            debugPrint('==> get products failure: $failure');
          },
        );
      } else {
        state = state.copyWith(isMoreProductsLoading: true);
        final response = await productsRepository.getProductsPaginate(
          page: ++_page,
          query: state.query.isEmpty ? null : state.query,
          shopId: state.selectedShop?.id,
          categoryId: state.selectedCategory?.id,
          brandId: state.selectedBrand?.id,
        );
        response.when(
          success: (data) async {
            final List<ProductData> newList = List.from(state.products);
            newList.addAll(data.data ?? []);
            state = state.copyWith(
              products: newList,
              isMoreProductsLoading: false,
            );
            if ((data.data?.length ?? 0) < 12) {
              state = state.copyWith(hasMore: false);
            }
          },
          failure: (failure, status) {
            state = state.copyWith(isMoreProductsLoading: false);
            debugPrint('==> get products more failure: $failure');
            AppHelpers.showSnackBar(context, failure);
          },
        );
      }
    } else {
      AppHelpers.showSnackBar(
        // ignore: use_build_context_synchronously
        context,
        AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
      );
    }
  }

  void setProductsQuery(BuildContext context, String query) {
    if (state.query == query) {
      return;
    }
    state = state.copyWith(query: query.trim());
    if (state.query.isNotEmpty) {
      if (_searchProductsTimer?.isActive ?? false) {
        _searchProductsTimer?.cancel();
      }
      _searchProductsTimer = Timer(
        const Duration(milliseconds: 500),
        () {
          state = state.copyWith(hasMore: true, products: []);
          _page = 0;
          fetchProducts(context: context);
        },
      );
    } else {
      if (_searchProductsTimer?.isActive ?? false) {
        _searchProductsTimer?.cancel();
      }
      _searchProductsTimer = Timer(
        const Duration(milliseconds: 500),
        () {
          state = state.copyWith(hasMore: true, products: []);
          _page = 0;
          fetchProducts(context: context);
        },
      );
    }
  }

  Future<void> fetchCategories({required BuildContext context}) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(
        isCategoriesLoading: true,
        dropDownCategories: [],
        categories: [],
      );
      final response = await categoriesRepository.searchCategories(
      );
      response.when(
        success: (data) async {
          final List<CategoryData> categories = data.data ?? [];
          state = state.copyWith(
            isCategoriesLoading: false,
            categories: categories,
          );
        },
        failure: (failure, status) {
          state = state.copyWith(isCategoriesLoading: false);
        },
      );
    } else {
      AppHelpers.showSnackBar(
        // ignore: use_build_context_synchronously
        context,
        AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
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
      state = state.copyWith(selectedCategory: null, hasMore: true);
    } else {
      final category = state.categories[index];
      if (category.id != state.selectedCategory?.id) {
        state = state.copyWith(selectedCategory: category, hasMore: true);
      } else {
        state = state.copyWith(selectedCategory: null, hasMore: true);
      }
    }

    _page = 0;
    fetchProducts(context: context);
    setCategoriesQuery(context, '');
  }

  void removeSelectedCategory(BuildContext context) {
    state = state.copyWith(selectedCategory: null, hasMore: true);
    _page = 0;
    fetchProducts(context: context);
  }

  Future<void> fetchBrands({VoidCallback? checkYourNetwork}) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(
        isBrandsLoading: true,
        dropDownBrands: [],
        brands: [],
      );
      final response = await brandsRepository
          .searchBrands(state.brandQuery.isEmpty ? null : state.brandQuery);
      response.when(
        success: (data) async {
          final List<BrandData> brands = data.data ?? [];
          List<DropDownItemData> dropdownBrands = [];
          for (int i = 0; i < brands.length; i++) {
            dropdownBrands.add(
              DropDownItemData(
                index: i,
                title: brands[i].title ?? 'No category title',
              ),
            );
          }
          state = state.copyWith(
            isBrandsLoading: false,
            brands: brands,
            dropDownBrands: dropdownBrands,
          );
        },
        failure: (failure, status) {
          state = state.copyWith(isBrandsLoading: false);
          debugPrint('==> get brands failure: $failure');
        },
      );
    } else {
      checkYourNetwork?.call();
    }
  }

  void setBrandsQuery(BuildContext context, String query) {
    if (state.brandQuery == query) {
      return;
    }
    state = state.copyWith(brandQuery: query.trim());
    if (_searchBrandsTimer?.isActive ?? false) {
      _searchBrandsTimer?.cancel();
    }
    _searchBrandsTimer = Timer(
      const Duration(milliseconds: 500),
      () {
        state = state.copyWith(brands: [], dropDownBrands: []);
        fetchBrands(
          checkYourNetwork: () {
            AppHelpers.showSnackBar(
              context,
              AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
            );
          },
        );
      },
    );
  }

  void setSelectedBrand(BuildContext context, int index) {
    final brand = state.brands[index];
    state = state.copyWith(selectedBrand: brand, hasMore: true);
    _page = 0;
    fetchProducts(context: context);
    setBrandsQuery(context, '');
  }

  void removeSelectedBrand(BuildContext context) {
    state = state.copyWith(selectedBrand: null, hasMore: true);
    _page = 0;
    fetchProducts(context: context);
  }
}
