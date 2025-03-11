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

  void setSelectedPayment(String? paymentId) {
    final List<BagData> bags = List.from(LocalStorage.getBags());
    PaymentData? paymentData;
    for (final payment in state.payments) {
      if (paymentId == payment.id) {
        paymentData = payment;
        break;
      }
    }
    final BagData bag = bags[state.selectedBagIndex].copyWith(
      selectedPayment: paymentData,
    );
    bags[state.selectedBagIndex] = bag;
    LocalStorage.setBags(bags);
    state = state.copyWith(
        bags: bags, selectedPayment: paymentData, selectPaymentError: null);
  }

  void setSelectedOrderType(String? type) {
    PaymentData? selectedPayment = state.selectedPayment;
    if (state.selectedPayment?.tag != 'cash') {
      final List<PaymentData> payments = List.from(state.payments);
      selectedPayment = payments.firstWhere((e) => e.tag == 'cash',
          orElse: () => PaymentData());
      setSelectedPayment(selectedPayment.id);
    }
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

  Future<void> fetchBags(String? shopId) async {
    state = state.copyWith(isBagsLoading: true, bags: []);
    List<BagData> bags = [];
    final BagData firstBag = BagData(index: 0, bagProducts: []);
    LocalStorage.setBags([firstBag]);
    bags = [firstBag];
    state = state.copyWith(
      bags: bags,
      isBagsLoading: false,
      isActive: false,
      isPromoCodeLoading: false,
      comment: '',
    );
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
    final CurrencyData? selectedCurrency = currencies.firstWhere(
      (currency) => currency.title == currencyId, // Assuming 'name' is a field in CurrencyData
      orElse: () => CurrencyData(),
    );
    state = state.copyWith(selectedCurrency: selectedCurrency);
  }

  void setSelectedBagIndex(int index) {
    state = state.copyWith(
      selectedBagIndex: index
    );
  }

  void removeOrderedBag(BuildContext context) {
    List<BagData> bags = List.from(state.bags);
    List<BagData> newBags = LocalStorage.getBags();
    bags.removeAt(state.selectedBagIndex);
    if (bags.isEmpty) {
      final BagData firstBag = BagData(index: 0, bagProducts: []);
      newBags = [firstBag];
    } else {
      for (int i = 0; i < bags.length; i++) {
        newBags.add(BagData(index: i, bagProducts: bags[i].bagProducts));
      }
    }
    LocalStorage.setBags(newBags);
    state = state.copyWith(
        bags: newBags,
        selectedBagIndex: 0,
        selectedUser: null,
        // selectedPayment: null,
        orderType: 'Para llevar');
    setInitialBagData(context, newBags[0]);
  }


  Future<void> fetchCarts({BuildContext? context, bool isNotLoading = false}) async {
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
        bags: LocalStorage.getBags(),
      );
    }

    // Obtener los productos del carrito desde el almacenamiento local
    final List<BagProductData> bagProducts =
        LocalStorage.getBags()[state.selectedBagIndex].bagProducts ?? [];
    
    if (bagProducts.isNotEmpty) {
      // Aquí realizamos los cálculos internamente en lugar de hacer una solicitud de red
      _calculateCartTotal(bagProducts);

      // El estado ahora se actualiza con el resultado de los cálculos
      state = state.copyWith(
        isButtonLoading: false,
        isProductCalculateLoading: false,
      );
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

// Método interno para realizar los cálculos de los productos en el carrito
void _calculateCartTotal(List<BagProductData> bagProducts) {
  // double total = 0.0;
  
  // for (var product in bagProducts) {
  //   // Lógica para calcular el precio total de cada producto
  //   // Esto puede involucrar descuento, impuestos, o cualquier otra regla
  //   double price = product.price?? 0.0;

  //   // Aquí deberías agregar lógica si hay descuentos o cualquier otro ajuste

  //   total += price;
  // }

  // // Aquí puedes actualizar el estado con el total calculado
  // state = state.copyWith(totalPrice: total);
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
    var newPagination = state.paginateResponse?.copyWith(stocks: []);
    state = state.copyWith(paginateResponse: newPagination);
    List<BagData> bags = List.from(LocalStorage.getBags());
    bags[state.selectedBagIndex] =
        bags[state.selectedBagIndex].copyWith(bagProducts: []);
    LocalStorage.setBags(bags);
  }

  void deleteProductFromBag(BuildContext context, BagProductData bagProduct) {
    final List<BagProductData> bagProducts = List.from(
        LocalStorage.getBags()[state.selectedBagIndex].bagProducts ?? []);
    int index = 0;
    for (int i = 0; i < bagProducts.length; i++) {
      if (bagProducts[i] == bagProduct) {
        index = i;
        break;
      }
    }
    bagProducts.removeAt(index);
    List<BagData> bags = List.from(LocalStorage.getBags());
    bags[state.selectedBagIndex] =
        bags[state.selectedBagIndex].copyWith(bagProducts: bagProducts);
    LocalStorage.setBags(bags);
    fetchCarts(context: context);
  }

  void deleteProductCount({required int productIndex}) {
    List<ProductData> listOfProduct =
        List.from(state.paginateResponse?.stocks ?? []);
    listOfProduct.removeAt(productIndex);
    PriceDate? data = state.paginateResponse;
    PriceDate? newData = data?.copyWith(stocks: listOfProduct);
    state = state.copyWith(paginateResponse: newData);
    List<BagData> bags = List.from(LocalStorage.getBags());

    List<BagProductData>? bagProducts =
        bags[state.selectedBagIndex].bagProducts;
    bagProducts?.removeAt(productIndex);
    bags[state.selectedBagIndex] =
        bags[state.selectedBagIndex].copyWith(bagProducts: bagProducts);
    LocalStorage.setBags(bags);

    fetchCarts(isNotLoading: true);
  }

  Future<void> decreaseProductCount({
    required int productIndex,
    required BuildContext context,
  }) async {
    timer?.cancel();
    ProductData? product = state.paginateResponse?.stocks?[productIndex];
    List<BagData> bags = LocalStorage.getBags();
    if ((product?.quantity ?? 1) > 1) {
      ProductData? newProduct = product?.copyWith(
        quantity: ((product.quantity ?? 0) - 1),
      );
      List<ProductData> listOfProduct =
          List.from(state.paginateResponse?.stocks ?? []);
      listOfProduct[productIndex] = newProduct ?? ProductData();
      PriceDate? data = state.paginateResponse;
      PriceDate? newData = data?.copyWith(stocks: listOfProduct);
      state = state.copyWith(paginateResponse: newData);
      final List<BagProductData> bagProducts =
          bags[state.selectedBagIndex].bagProducts ?? [];
      BagProductData newProductData = bagProducts[productIndex]
          .copyWith(quantity: (bagProducts[productIndex].quantity ?? 0) - 1);
      bagProducts[productIndex] = newProductData;
      bags[state.selectedBagIndex] =
          bags[state.selectedBagIndex].copyWith(bagProducts: bagProducts);
      LocalStorage.setBags(bags);
    } else {
      List<ProductData> listOfProduct =
          List.from(state.paginateResponse?.stocks ?? []);
      listOfProduct.removeAt(productIndex);
      PriceDate? data = state.paginateResponse;
      PriceDate? newData = data?.copyWith(stocks: listOfProduct);
      state = state.copyWith(paginateResponse: newData);
      final List<BagProductData> bagProducts =
          bags[state.selectedBagIndex].bagProducts ?? [];
      if (bagProducts.isNotEmpty) bagProducts.removeAt(productIndex);
      if (bagProducts.isEmpty) {
        clearBag(context);
      }
      bags[state.selectedBagIndex] =
          bags[state.selectedBagIndex].copyWith(bagProducts: bagProducts);
      LocalStorage.setBags(bags);
    }
    timer = Timer(
      const Duration(milliseconds: 600),
      () => fetchCarts(isNotLoading: true),
    );
  }

  void increaseProductCount({required int productIndex}) {
    timer?.cancel();
    ProductData? product = state.paginateResponse?.stocks?[productIndex];
    ProductData? newProduct = product?.copyWith(
        quantity: ((product.quantity ?? 0) + 1), discount: product.discount);
    List<ProductData>? listOfProduct = state.paginateResponse?.stocks;
    listOfProduct?.removeAt(productIndex);
    listOfProduct?.insert(productIndex, newProduct ?? ProductData());
    PriceDate? data = state.paginateResponse;
    PriceDate? newData = data?.copyWith(stocks: listOfProduct);
    state = state.copyWith(paginateResponse: newData);
    final List<BagProductData> bagProducts =
        LocalStorage.getBags()[state.selectedBagIndex].bagProducts ?? [];

    BagProductData newProductData = bagProducts[productIndex]
        .copyWith(quantity: (bagProducts[productIndex].quantity ?? 0) + 1);
    bagProducts.removeAt(productIndex);
    bagProducts.insert(productIndex, newProductData);
    List<BagData> bags = List.from(LocalStorage.getBags());
    bags[state.selectedBagIndex] =
        bags[state.selectedBagIndex].copyWith(bagProducts: bagProducts);
    LocalStorage.setBags(bags);
    timer = Timer(
      const Duration(milliseconds: 500),
      () => fetchCarts(isNotLoading: true),
    );
  }

  Future<void> placeOrder(
      {required BuildContext context,
      String? shopId,
      required VoidCallback invalidateState}) async {
    bool active = true;
    // if (_name?.isEmpty ?? true) {
    //   state = state.copyWith(selectNameError: TrKeys.selectName);
    //   active = false;
    // }
    // if (_phone?.isEmpty ?? true) {
    //   state = state.copyWith(selectPhoneError: TrKeys.phoneNumberIsNotValid);
    //   active = false;
    // }
    // if (state.selectedCurrency == null) {
    //   state = state.copyWith(selectCurrencyError: 'Moneda no seleccionada');
    //   active = false;
    // }
    if (state.selectedPayment == null) {
      state = state.copyWith(selectPaymentError: 'Pago no seleccionado');
      active = false;
    }

    if (active) {
      state =
          state.copyWith(selectedUser: KioskData(name: _name, phone: _phone));
      createOrder(
          context,
          OrderBodyData(
            bagData: state.bags[state.selectedBagIndex],
            note: state.comment,
          ), onSuccess: (o) {
        fetchBags(shopId);
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
          AppHelpers.showSnackBar(
              context, 'Sin conexión a internet');
        }
      }
    }
}