// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kibbi_kiosk/src/core/constants/constants.dart';
import 'package:kibbi_kiosk/src/core/di/dependency_manager.dart';
import 'package:kibbi_kiosk/src/core/routes/app_router.dart';
import 'package:kibbi_kiosk/src/core/utils/utils.dart';
import 'package:kibbi_kiosk/src/models/data/order_data.dart';
import 'package:kibbi_kiosk/src/models/models.dart';
import 'package:kibbi_kiosk/src/presentation/pages/main/widgets/printer/generate_check.dart';
import 'package:kibbi_kiosk/src/repository/orders.dart';
import 'package:kibbi_kiosk/src/models/models.dart';
import 'package:kibbi_kiosk/src/models/response/order_response.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kibbi_kiosk/src/models/models.dart';
import 'package:kibbi_kiosk/src/models/data/order_body_data.dart';
// import 'package:kibbi_kiosk/src/presentation/pages/main/widgets/printer/generate_check.dart';
import 'right_side_state.dart';

class RightSideNotifier extends StateNotifier<RightSideState> {
  static const int maxCartProducts = 30; // Maximum allowed products in the cart
  String? _name;
  Timer? timer;

  RightSideNotifier() : super(const RightSideState());

  // void Payment(String? paymentId) {
  //   final BagData? bag = LocalStorage.getBag();
  //   PaymentData? paymentData;
  //   for (final payment in state.payments) {
  //     if (paymentId == payment.id) {
  //       paymentData = payment;
  //       break;
  //     }
  //   }
  //   final BagData updatedBag = bag!.copyWith(
  //     selectedPayment: paymentData,
  //   );
  //   LocalStorage.setBag(updatedBag);
  //   state = state.copyWith(
  //       bag: updatedBag, selectedPayment: paymentData, selectPaymentError: null);
  // }

  void setSelectedOrderType(String? type) {
    debugPrint('===> Previous orderType: ${state.orderType}');
    state = state.copyWith(
      orderType: type ?? state.orderType,
    );
    debugPrint('===> Updated orderType: ${state.orderType}');
  }

  Future<void> fetchBag() async {
    state = state.copyWith(isBagsLoading: true);
    BagData? bag = LocalStorage.getBag();
    if (bag == null) {
      bag = BagData(bagProducts: []);
      LocalStorage.setBag(bag);
      debugPrint('===> New bag created and set: $bag');
    } else {
      debugPrint('===> Bag retrieved: $bag');
    }
    state = state.copyWith(
      bag: bag,
      isBagsLoading: false,
      isActive: bag.bagProducts!.isNotEmpty,
      comment: '',
    );

    debugPrint('===> Bag state updated: ${state.bag}');
  }

  Future<void> fetchCurrencies({VoidCallback? checkYourNetwork}) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(isCurrenciesLoading: true, currencies: []);

      // Crear una instancia de CurrencyData para MXN
      final mxnCurrency = CurrencyData();

      // Actualizar el estado con solo esta moneda
      state = state.copyWith(
        isCurrenciesLoading: false,
        currencies: [mxnCurrency],
      );

      // Establecer esta moneda como la seleccionada
      // Si tu método setSelectedCurrency requiere un ID, puedes manejarlo según sea necesario
      // Por ejemplo, si mxnCurrency tiene un ID predeterminado o si puedes pasar null
      _setSelectedCurrency(null); // Ajusta según sea necesario
    } else {
      checkYourNetwork?.call();
    }
  }

  void _setSelectedCurrency(String? currencyId) {
    final List<CurrencyData> currencies = List.from(state.currencies);
    final CurrencyData selectedCurrency = currencies.firstWhere(
      (currency) =>
          currency.title ==
          currencyId, // Assuming 'name' is a field in CurrencyData
      orElse: () => CurrencyData(),
    );
    state = state.copyWith(selectedCurrency: selectedCurrency);
  }

  void removeOrderedBag(BuildContext context) {
    BagData? bag = LocalStorage.getBag();
    bag = BagData(bagProducts: []);
    LocalStorage.setBag(bag);
    state = state.copyWith(
        bag: bag,
        selectedBagIndex: 0,
        selectedUser: null,
        // selectedPayment: null,
        orderType: 'Para llevar');
    setInitialBagData(context, bag);
  }

  Future<void> fetchCarts(
      {BuildContext? context, bool isNotLoading = false}) async {
    final connected = await AppConnectivity.connectivity();

    if (connected) {
      // Aquí se gestiona si la carga es con o sin indicador de carga
      if (isNotLoading) {
        state = state.copyWith(
          isButtonLoading: true,
        );
      } else {
        state = state.copyWith(
          isProductCalculateLoading: true,
          bag: LocalStorage.getBag(),
        );
      }

      // Obtener los productos del carrito desde el almacenamiento local
      final List<BagProductData> bagProducts =
          LocalStorage.getBag()?.bagProducts ?? [];
      debugPrint('===> Bag products retrieved: $bagProducts');

      if (bagProducts.isNotEmpty) {
        // Aquí realizamos los cálculos internamente en lugar de hacer una solicitud de red
        calculateCartTotal();

        // El estado ahora se actualiza con el resultado de los cálculos
        state = state.copyWith(
          isButtonLoading: false,
          isProductCalculateLoading: false,
        );
      } else {
        // Si no hay productos, establecer el total en 0.0
        PriceDate? data = state.paginateResponse;
        PriceDate? newData = data?.copyWith(totalPrice: 0.0);
        state = state.copyWith(paginateResponse: newData);
      }

      // Finalmente, deshabilitamos los indicadores de carga
      state = state.copyWith(
        isButtonLoading: false,
        isProductCalculateLoading: false,
      );
    } else {
      if (context?.mounted ?? false) {
        AppHelpers.showSnackBar(
          context!,
          'Revisa tu conexión',
        );
      }
    }
  }

  Future<void> calculateCartTotal() async {
    final List<BagProductData> bagProducts =
        List.from(LocalStorage.getBag()?.bagProducts ?? []);

    if (bagProducts.isEmpty) {
      // Mantener el valor anterior de cartTotal en lugar de resetearlo a 0
      state = state.copyWith(
        bag: state.bag?.copyWith(cartTotal: state.bag?.cartTotal),
      );
      return;
    }

    final result = await productsRepository.productsCalculateTotal(
        bagProducts: bagProducts);

    result.when(
      success: (total) {
        // Solo actualizar el total si la API responde correctamente
        state = state.copyWith(
          bag: state.bag?.copyWith(cartTotal: total),
        );
        debugPrint('Nuevo total del carrito: \$$total');
      },
      failure: (error, status) {
        debugPrint(
            'Error al calcular el total del carrito: $error, Status: $status');
      },
    );
  }

  Future<void> setDiscount(BuildContext context) async {
    final totalSale = state.bag?.cartTotal;
    final coupon = state.coupon;

    if (totalSale == null || coupon == null || coupon.isEmpty) {
      debugPrint(
          '==> No se puede aplicar descuento: totalSale o coupon es nulo');
      return;
    }

    final result = await productsRepository.fetchCouponAndDiscount(
      coupon: coupon,
      totalSale: totalSale,
    );

    result.when(
      success: (data) {
        // Extract coupon info and discount from the response
        final couponInfo = data['couponInfo'] as Map<String, dynamic>? ?? {};
        final discount = data['discount'] as num? ?? 0;

        // Get the coupon ID if it exists
        final couponId = couponInfo['_id']?.toString() ?? '';

        // Save in the state
        state = state.copyWith(
          discount: discount,
          couponId: couponId.isNotEmpty
              ? couponId
              : null, // Avoid saving an empty string
          errorMessage: null, // Clear any previous error
        );

        debugPrint('==> Descuento aplicado: \$$discount');
        debugPrint(
            '==> Coupon ID guardado: ${couponId.isNotEmpty ? couponId : "Ninguno"}');
      },
      failure: (error, status) {
        debugPrint('Error al aplicar descuento: $error, Status: $status');

        // Handle 400 error and extract the message
        String errorMessage = error.toString();
        // Save the error message in the state
        state = state.copyWith(errorMessage: errorMessage);
      },
    );
  }

  void setInitialBagData(BuildContext context, BagData bag) {
    state = state.copyWith(
        orderType: state.orderType.isEmpty ? 'Para llevar' : state.orderType);
    debugPrint('Order type set to: ${state.orderType}');
    fetchCarts(context: context);
  }

  void setFirstName(String value) {
    _name = value.trim();
    state = state.copyWith(customerName: _name); // Update customerName in state
    if (state.selectNameError != null) {
      state = state.copyWith(selectNameError: null);
    }
  }

  void clearBag({BuildContext? context}) {
    // Clear the bag in the state and LocalStorage
    BagData emptyBag = BagData(bagProducts: []);
    state = state.copyWith(bag: emptyBag);
    LocalStorage.setBag(emptyBag);

    if (context != null && context.mounted) {
      AppHelpers.showSnackBar(context, 'Carrito vaciado correctamente');
    }

    debugPrint('Carrito vaciado.');
  }

  void deleteProductFromBag(BuildContext context, BagProductData bagProduct) {
    final List<BagProductData> bagProducts =
        List.from(LocalStorage.getBag()?.bagProducts ?? []);
    int index = 0;
    for (int i = 0; i < bagProducts.length; i++) {
      if (bagProducts[i] == bagProduct) {
        index = i;
        break;
      }
    }
    bagProducts.removeAt(index);
    BagData? bag = LocalStorage.getBag();
    bag = bag!.copyWith(bagProducts: bagProducts);
    LocalStorage.setBag(bag);
    fetchCarts(context: context);
  }

  void deleteProductCount({required int productIndex}) {
    // Cancel any existing timer
    timer?.cancel();

    // Get the current bag and its products
    BagData? bag = LocalStorage.getBag();
    final List<BagProductData> bagProducts = List.from(bag?.bagProducts ?? []);

    // Validate the product index
    if (productIndex >= bagProducts.length) {
      debugPrint('Índice fuera de rango al intentar eliminar un producto.');
      return;
    }

    // Remove the product from the bag
    bagProducts.removeAt(productIndex);

    // Update the bag in LocalStorage
    bag = bag!.copyWith(bagProducts: bagProducts);
    LocalStorage.setBag(bag);

    // If the bag is empty, clear it completely
    if (bagProducts.isEmpty) {
      clearBag(context: null); // Call clearBag to handle the empty state
    } else {
      // Update the state with the new bag
      state = state.copyWith(
        bag: bag,
      );

      // Recalculate the cart total
      calculateCartTotal();
    }

    debugPrint('Producto eliminado del carrito. Nuevo estado: $state');
  }

  void increaseProductCount(
      {required int productIndex, required BuildContext context}) {
    // Cancel any existing timer
    timer?.cancel();

    // Get the current bag and its products
    BagData? bag = LocalStorage.getBag();
    final List<BagProductData> bagProducts = List.from(bag?.bagProducts ?? []);

    // Check if the total quantity exceeds the limit
    final totalQuantity = bagProducts.fold<int>(
      0,
      (sum, product) => sum + (product.quantity ?? 0),
    );

    if (totalQuantity >= maxCartProducts) {
      // Show popup if the limit is exceeded
      AppHelpers.showAlertDialog(
        context: context,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Límite alcanzado',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text('Solo puedes tener  en el carrito.'),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Aceptar'),
            ),
          ],
        ),
      );

      return;
    }

    // Get the current product
    ProductData? product = state.paginateResponse?.stocks?[productIndex];

    // Create a new product with incremented quantity
    ProductData? newProduct = product?.copyWith(
        quantity: ((product.quantity ?? 0) + 1), discount: product.discount);

    // Update the list of products
    List<ProductData> listOfProduct =
        List.from(state.paginateResponse?.stocks ?? []);
    if (productIndex < listOfProduct.length) {
      listOfProduct[productIndex] = newProduct ?? ProductData();
    }

    // Update the state with the new list
    PriceDate? data = state.paginateResponse;
    PriceDate? newData = data?.copyWith(stocks: listOfProduct);

    // Update the list of products in the cart
    if (productIndex < bagProducts.length) {
      BagProductData newProductData = bagProducts[productIndex]
          .copyWith(quantity: (bagProducts[productIndex].quantity ?? 0) + 1);
      bagProducts[productIndex] = newProductData;

      // Update the cart in LocalStorage
      bag = bag!.copyWith(bagProducts: bagProducts);
      LocalStorage.setBag(bag);

      // Update the state directly without waiting
      state = state.copyWith(
        paginateResponse: newData,
        bag: bag,
      );

      // Recalculate the total immediately
      calculateCartTotal();
    }
  }

  void decreaseProductCount({
    required int productIndex,
    required BuildContext context,
  }) async {
    // Cancelamos el timer existente si hay uno
    timer?.cancel();

    // Obtenemos la información del carrito y el producto
    BagData? bag = LocalStorage.getBag();
    final List<BagProductData> bagProducts = List.from(bag?.bagProducts ?? []);

    // Verificamos que el índice sea válido
    if (productIndex >= bagProducts.length) {
      return; // Índice fuera de rango, salimos de la función
    }

    // Obtenemos la cantidad actual del producto
    int currentQuantity = bagProducts[productIndex].quantity ?? 0;
    debugPrint(
        'Cantidad actual: $currentQuantity para producto en índice: $productIndex');

    // Si la cantidad es mayor a 1, simplemente decrementamos
    if (currentQuantity > 1) {
      // Actualizamos el producto en BagProducts
      BagProductData updatedBagProduct =
          bagProducts[productIndex].copyWith(quantity: currentQuantity - 1);
      bagProducts[productIndex] = updatedBagProduct;

      // Actualizamos también en la lista de stocks si existe
      List<ProductData> listOfProduct =
          List.from(state.paginateResponse?.stocks ?? []);
      if (productIndex < listOfProduct.length) {
        ProductData? updatedProduct =
            listOfProduct[productIndex].copyWith(quantity: currentQuantity - 1);
        listOfProduct[productIndex] = updatedProduct;
      }

      // Actualizamos el estado y LocalStorage
      bag = bag!.copyWith(bagProducts: bagProducts);
      LocalStorage.setBag(bag);

      PriceDate? data = state.paginateResponse;
      PriceDate? newData = data?.copyWith(stocks: listOfProduct);

      state = state.copyWith(
        paginateResponse: newData,
        bag: bag,
      );

      // Calculamos el total inmediatamente
      calculateCartTotal();

      debugPrint('Cantidad decrementada a: ${currentQuantity - 1}');
    }
    // Si la cantidad es 1 o menos, eliminamos el producto
    else {
      debugPrint(
          'Eliminando producto del carrito porque cantidad = $currentQuantity');

      // Eliminamos de BagProducts
      bagProducts.removeAt(productIndex);

      // Eliminamos de stocks si existe
      List<ProductData> listOfProduct =
          List.from(state.paginateResponse?.stocks ?? []);
      if (productIndex < listOfProduct.length) {
        listOfProduct.removeAt(productIndex);
      }

      // Si el carrito queda vacío, lo limpiamos completamente
      if (bagProducts.isEmpty) {
        clearBag();
      } else {
        // Actualizamos el estado y LocalStorage
        bag = bag!.copyWith(bagProducts: bagProducts);
        LocalStorage.setBag(bag);

        PriceDate? data = state.paginateResponse;
        PriceDate? newData = data?.copyWith(stocks: listOfProduct);

        state = state.copyWith(
          paginateResponse: newData,
          bag: bag,
        );

        // Calculamos el total inmediatamente
        calculateCartTotal();
      }
    }
  }

  Future<void> placeOrder({
    required BuildContext context,
    required VoidCallback invalidateState,
  }) async {
    bool active = true;
    if (_name?.isEmpty ?? true) {
      state = state.copyWith(selectNameError: 'Nombre vacío');
      active = false;
    }
    if (state.selectedCurrency == null) {
      state = state.copyWith(selectCurrencyError: 'Moneda no seleccionada');
      active = false;
    }
    if (state.paymentMethod.isEmpty) {
      state =
          state.copyWith(selectPaymentError: 'Método de pago no seleccionado');
      active = false;
    }

    if (active) {
      // Generate the order number
      OrderNumberGenerator.generateOrderNumber().then((numOrder) {
        // Create the order using OrderBodyData
        final orderBodyData = OrderBodyData(
          customerName: state.customerName,
          numOrder: numOrder, // Generated order number
          orderType: state.orderType,
          paymentMethod:
              state.paymentMethod.toLowerCase(), // Convert to lowercase
          bagData: state.bag ?? BagData(),
          notes: state.comment,
          coupon: state.coupon,
        );

        createOrder(
          context,
          orderBodyData,
          onSuccess: (orderResponse) {
            fetchBag();
            context.maybePop();
            showDialog(
              context: context,
              builder: (context) {
                return LayoutBuilder(builder: (context, constraints) {
                  return AlertDialog(
                    content: SizedBox(
                      width: 300.r,
                      child: GenerateCheckPage(orderResponse: orderResponse!),
                    ),
                  );
                });
              },
            );
          },
        );
      });
    }
  }

  Future<void> createOrder(
    BuildContext context,
    OrderBodyData data, {
    ValueChanged<OrderResponse?>? onSuccess,
    VoidCallback? onFailure,
  }) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(isOrderLoading: true);
      final response = await ordersRepository.createOrder(data);
      response.when(
        success: (order) async {
          removeOrderedBag(context);
          state = state.copyWith(isOrderLoading: false);
          onSuccess?.call(order); // Pass OrderResponse instead of OrderBodyData
        },
        failure: (failure, status) {
          state = state.copyWith(isOrderLoading: false);
          if (context.mounted) {
            AppHelpers.showSnackBar(
              context,
              'Error al procesar la solicitud',
            );
          }
          onFailure?.call();
        },
      );
    } else {
      if (context.mounted) {
        AppHelpers.showSnackBar(context, 'Sin conexión a internet');
      }
    }
  }

  void setNote(String note) {
    state = state.copyWith(comment: note);
  }

  void setPaymentMethod(String paymentMethod) {
    debugPrint('=== > Actualizando método de pago: $paymentMethod');

    // Validar que el método de pago no sea nulo o vacío
    if (paymentMethod.isEmpty) {
      debugPrint('=== > El método de pago no puede estar vacío');
      return;
    }

    // Actualizar el estado con el nuevo método de pago
    state = state.copyWith(paymentMethod: paymentMethod);

    debugPrint('=== > Método de pago actualizado: ${state.paymentMethod}');
  }

  void setCoupon(String coupon) {
    state = state.copyWith(coupon: coupon);
  }
}
