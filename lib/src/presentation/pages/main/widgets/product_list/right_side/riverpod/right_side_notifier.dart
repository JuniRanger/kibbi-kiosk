// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kibbi_kiosk/src/core/constants/constants.dart';
import 'package:kibbi_kiosk/src/core/di/dependency_manager.dart';
import 'package:kibbi_kiosk/src/core/routes/app_router.dart';
import 'package:kibbi_kiosk/src/core/utils/utils.dart';
import 'package:kibbi_kiosk/src/models/data/order_data.dart';
import 'package:kibbi_kiosk/src/models/models.dart';
import 'package:kibbi_kiosk/src/repository/orders.dart';
import 'package:kibbi_kiosk/src/models/models.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kibbi_kiosk/src/models/models.dart';
import 'package:kibbi_kiosk/src/models/data/order_body_data.dart';
// import 'package:kibbi_kiosk/src/presentation/pages/main/widgets/printer/generate_check.dart';
import 'right_side_state.dart';

class RightSideNotifier extends StateNotifier<RightSideState> {
  String? _phone;
  String? _name;
  Timer? timer;
  Timer? _searchSectionTimer;
  Timer? _searchTableTimer;

  RightSideNotifier() : super(const RightSideState());

  // void setSelectedPayment(String? paymentId) {
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
    // PaymentData? selectedPayment = state.selectedPayment;
    // if (state.selectedPayment?.tag != 'cash') {
    //   final List<PaymentData> payments = List.from(state.payments);
    //   selectedPayment = payments.firstWhere((e) => e.tag == 'cash',
    //       orElse: () => PaymentData());
    //   setSelectedPayment(selectedPayment.id);
    // }
    state = state.copyWith(
      orderType: type ?? state.orderType,
      selectPaymentError: null,
    );
  }

  setCalculate(String item) {
    if (item == "-1" && state.calculate.isNotEmpty) {
      state = state.copyWith(
          calculate: state.calculate.substring(0, state.calculate.length - 1));
      return;
    } else if (state.calculate.length > 25) {
      return;
    } else if (item == "." && state.calculate.isEmpty) {
      state = state.copyWith(calculate: "${state.calculate}0$item");
      return;
    } else if (item == "." && state.calculate.contains(".")) {
      return;
    } else if (item != "-1") {
      state = state.copyWith(calculate: state.calculate + item);
      return;
    }
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
        _calculateCartTotal(bagProducts);

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

  void _calculateCartTotal(List<BagProductData> bagProducts) {
    // Obtener la lista de productos del estado
    final List<ProductData> products = state.paginateResponse?.stocks ?? [];
    debugPrint('Stocks: $products');

    // Calcular el total del carrito
    num total = 0.0;
    for (var bagProduct in bagProducts) {
      final salePrice = bagProduct.getProductSalePrice(products);
      final quantity = bagProduct.quantity ?? 1;

      if (quantity <= 0) {
        debugPrint('Cantidad inválida para productId: ${bagProduct.productId}');
      }

      final productTotal = salePrice * quantity;
      debugPrint(
          'Producto: ${bagProduct.productId}, Precio: $salePrice, Cantidad: $quantity, Subtotal: $productTotal');

      total += productTotal;
    }

    debugPrint('Total del carrito calculado: $total');

    // Actualizar el estado con el total calculado
    PriceDate? data = state.paginateResponse;
    PriceDate? newData = data?.copyWith(totalPrice: total);
    state = state.copyWith(paginateResponse: newData);
  }

  void setInitialBagData(BuildContext context, BagData bag) {
    state = state.copyWith(
        // selectedUser: bag.selectedUser,
        // selectedCurrency: bag.MXN,
        // selectedPayment: bag.selectedPayment,
        orderType: state.orderType.isEmpty ? 'Para llevar' : state.orderType);
    fetchCarts(context: context);
  }

  void setFirstName(String value) {
    _name = value.trim();
    if (state.selectNameError != null) {
      state = state.copyWith(selectNameError: null);
    }
  }

  void clearBag(BuildContext context) {
    // Limpiamos los productos de la bolsa en el estado
    BagData emptyBag = BagData(bagProducts: []);
    state = state.copyWith(bag: emptyBag);

    // También limpiamos paginateResponse por si acaso todavía se usa en alguna parte
    if (state.paginateResponse != null) {
      var newPagination = state.paginateResponse!.copyWith(stocks: []);
      state = state.copyWith(paginateResponse: newPagination);
    }

    // Obtenemos el objeto de la bolsa (bag) desde LocalStorage
    BagData? bag = LocalStorage.getBag();

    // Verificamos que la bolsa no sea nula antes de modificarla
    if (bag != null) {
      // Copiamos la bolsa y le asignamos una lista vacía de productos
      bag = bag.copyWith(bagProducts: []);

      // Guardamos la bolsa actualizada en el almacenamiento local
      LocalStorage.setBag(bag);

      debugPrint("Bolsa limpiada correctamente.");
    } else {
      // Si no hay datos en el almacenamiento local, creamos una bolsa vacía
      LocalStorage.setBag(emptyBag);
      debugPrint("No había datos en la bolsa. Se ha creado una bolsa vacía.");
    }

    // Notificar a la UI que la bolsa ha sido vaciada
    if (context.mounted) {
      AppHelpers.showSnackBar(context, 'Carrito vaciado correctamente');
    }
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
    List<ProductData> listOfProduct =
        List.from(state.paginateResponse?.stocks ?? []);
    listOfProduct.removeAt(productIndex);
    PriceDate? data = state.paginateResponse;
    PriceDate? newData = data?.copyWith(stocks: listOfProduct);
    state = state.copyWith(paginateResponse: newData);
    BagData? bag = LocalStorage.getBag();

    List<BagProductData>? bagProducts = bag?.bagProducts;
    bagProducts?.removeAt(productIndex);
    bag = bag!.copyWith(bagProducts: bagProducts);
    LocalStorage.setBag(bag);

    fetchCarts(isNotLoading: true);
  }

  void increaseProductCount({required int productIndex}) {
    // Cancelamos el timer existente si hay uno
    timer?.cancel();
    
    // Obtenemos el producto actual
    ProductData? product = state.paginateResponse?.stocks?[productIndex];
    
    // Creamos un nuevo producto con cantidad incrementada
    ProductData? newProduct = product?.copyWith(
        quantity: ((product.quantity ?? 0) + 1), discount: product.discount);
    
    // Actualizamos la lista de productos
    List<ProductData> listOfProduct = List.from(state.paginateResponse?.stocks ?? []);
    if (productIndex < listOfProduct.length) {
      listOfProduct[productIndex] = newProduct ?? ProductData();
    }
    
    // Actualizamos el estado con la nueva lista
    PriceDate? data = state.paginateResponse;
    PriceDate? newData = data?.copyWith(stocks: listOfProduct);
    
    // Actualizamos la lista de productos en el carrito
    final List<BagProductData> bagProducts = List.from(LocalStorage.getBag()?.bagProducts ?? []);
    if (productIndex < bagProducts.length) {
      BagProductData newProductData = bagProducts[productIndex]
          .copyWith(quantity: (bagProducts[productIndex].quantity ?? 0) + 1);
      bagProducts[productIndex] = newProductData;
      
      // Actualizamos el carrito en LocalStorage
      BagData? bag = LocalStorage.getBag();
      bag = bag!.copyWith(bagProducts: bagProducts);
      LocalStorage.setBag(bag);
      
      // Actualizamos el estado directamente sin esperar
      state = state.copyWith(
        paginateResponse: newData,
        bag: bag,
      );
      
      // Calculamos el total inmediatamente
      _calculateCartTotal(bagProducts);
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
    debugPrint('Cantidad actual: $currentQuantity para producto en índice: $productIndex');
    
    // Si la cantidad es mayor a 1, simplemente decrementamos
    if (currentQuantity > 1) {
      // Actualizamos el producto en BagProducts
      BagProductData updatedBagProduct = bagProducts[productIndex].copyWith(
        quantity: currentQuantity - 1
      );
      bagProducts[productIndex] = updatedBagProduct;
      
      // Actualizamos también en la lista de stocks si existe
      List<ProductData> listOfProduct = List.from(state.paginateResponse?.stocks ?? []);
      if (productIndex < listOfProduct.length) {
        ProductData? updatedProduct = listOfProduct[productIndex].copyWith(
          quantity: currentQuantity - 1
        );
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
      _calculateCartTotal(bagProducts);
      
      debugPrint('Cantidad decrementada a: ${currentQuantity - 1}');
    } 
    // Si la cantidad es 1 o menos, eliminamos el producto
    else {
      debugPrint('Eliminando producto del carrito porque cantidad = $currentQuantity');
      
      // Eliminamos de BagProducts
      bagProducts.removeAt(productIndex);
      
      // Eliminamos de stocks si existe
      List<ProductData> listOfProduct = List.from(state.paginateResponse?.stocks ?? []);
      if (productIndex < listOfProduct.length) {
        listOfProduct.removeAt(productIndex);
      }
      
      // Si el carrito queda vacío, lo limpiamos completamente
      if (bagProducts.isEmpty) {
        clearBag(context);
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
        _calculateCartTotal(bagProducts);
      }
    }
  }

  Future<void> placeOrder(
      {required BuildContext context,
      String? shopId,
      required VoidCallback invalidateState}) async {
    bool active = true;
    if (_name?.isEmpty ?? true) {
      state = state.copyWith(selectNameError: 'Nombre vacio');
      active = false;
    }
    if (state.selectedCurrency == null) {
      state = state.copyWith(selectCurrencyError: 'Moneda no seleccionada');
      active = false;
    }
    if (state.selectedPayment == null) {
      state =
          state.copyWith(selectPaymentError: 'Metodo de pago no seleccionado');
      active = false;
    }

    if (active) {
      createOrder(
          context,
          OrderBodyData(
            orderType: 'Para llevar',
            paymentMethod: 'tarjeta',
            bagData: state.bag ?? BagData(),
            note: state.comment,
          ), onSuccess: (o) {
        fetchBag();
        context.maybePop();
        showDialog(
            context: context,
            builder: (context) {
              return LayoutBuilder(builder: (context, constraints) {
                return AlertDialog(
                  content: SizedBox(
                    width: 300.r,
                    // child: GenerateCheckPage(orderData: o),
                  ),
                );
              });
            }).whenComplete(() {
          context.router.popUntilRoot();
          context.replaceRoute(const MainRoute());
          invalidateState.call();
        });
      });
    }
  }

  setNote(String note) {
    state = state.copyWith(comment: note);
  }

  Future createOrder(
    BuildContext context,
    OrderBodyData data, {
    ValueChanged<OrderData?>? onSuccess,
    VoidCallback? onFailure,
  }) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(isOrderLoading: true);
      final response = await ordersRepository.createOrder(data);
      response.when(
        success: (order) async {
          removeOrderedBag(context);
          switch (data.bagData.selectedPayment?.tag) {
            case 'cash':
              // paymentsRepository.createTransaction(
              //   orderId: order.data!.id,
              //   paymentId: data.bagData.selectedPayment?.id,
              // );
              state = state.copyWith(isOrderLoading: false);
              onSuccess?.call(order['data']);
              break;
            default:
              state = state.copyWith(isOrderLoading: false);
              onSuccess?.call(order['data']);
              break;
          }
        },
        failure: (failure, status) {
          state = state.copyWith(isOrderLoading: false);
          if (context.mounted) {
            AppHelpers.showSnackBar(
              context,
              'Error al procesar la solicitud',
            );
          }
        },
      );
    } else {
      if (context.mounted) {
        AppHelpers.showSnackBar(context, 'Sin conexión a internet');
      }
    }
  }
}
