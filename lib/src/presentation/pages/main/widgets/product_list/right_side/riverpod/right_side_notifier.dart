// // ignore_for_file: use_build_context_synchronously

// import 'dart:async';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:kibbi_kiosk/src/core/constants/constants.dart';
// import 'package:kibbi_kiosk/src/core/di/dependency_manager.dart';
// import 'package:kibbi_kiosk/src/core/routes/app_router.dart';
// import 'package:kibbi_kiosk/src/core/utils/utils.dart';
// import 'package:kibbi_kiosk/src/models/data/order_data.dart';
// import 'package:auto_route/auto_route.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:kibbi_kiosk/src/models/models.dart';
// // import 'package:kibbi_kiosk/src/presentation/pages/main/widgets/printer/generate_check.dart';
// import 'right_side_state.dart';

// class RightSideNotifier extends StateNotifier<RightSideState> {
//   String? _phone;
//   String? _name;
//   Timer? timer;
//   Timer? _searchSectionTimer;
//   Timer? _searchTableTimer;

//   RightSideNotifier() : super(const RightSideState());

//   void setSelectedOrderType(String? type) {
//     PaymentData? selectedPayment = state.selectedPayment;
//     if (state.selectedPayment?.tag != 'cash') {
//       final List<PaymentData> payments = List.from(state.payments);
//       selectedPayment = payments.firstWhere((e) => e.tag == 'cash',
//           orElse: () => PaymentData());
//       setSelectedPayment(selectedPayment.id);
//     }
//     state = state.copyWith(
//       orderType: type ?? state.orderType,
//       selectPaymentError: null,
//       selectCurrencyError: null,
//       selectTableError: null,
//       selectSectionError: null,
//     );
//   }

//   setCalculate(String item) {
//     if (item == "-1" && state.calculate.isNotEmpty) {
//       state = state.copyWith(
//           calculate: state.calculate.substring(0, state.calculate.length - 1));
//       return;
//     } else if (state.calculate.length > 25) {
//       return;
//     } else if (item == "." && state.calculate.isEmpty) {
//       state = state.copyWith(calculate: "${state.calculate}0$item");
//       return;
//     } else if (item == "." && state.calculate.contains(".")) {
//       return;
//     } else if (item != "-1") {
//       state = state.copyWith(calculate: state.calculate + item);
//       return;
//     }
//   }

//   Future<void> fetchBags(String? shopId) async {
//     state = state.copyWith(isBagsLoading: true, bags: []);
//     List<BagData> bags = [];
//     final BagData firstBag = BagData(index: 0, bagProducts: [], shopId: shopId);
//     LocalStorage.setBags([firstBag]);
//     bags = [firstBag];
//     state = state.copyWith(
//       bags: bags,
//       isBagsLoading: false,
//       selectedUser: bags.first.selectedUser,
//       isActive: false,
//       isPromoCodeLoading: false,
//       coupon: null,
//       comment: '',
//     );
//   }

//   void addANewBag() {
//     List<BagData> newBags = List.from(state.bags);
//     newBags.add(BagData(index: newBags.length, bagProducts: []));
//     LocalStorage.setBags(newBags);
//     state = state.copyWith(bags: newBags);
//   }

//   void setSelectedBagIndex(int index) {
//     state = state.copyWith(
//       selectedBagIndex: index,
//       selectedUser: state.bags[index].selectedUser,
//     );
//   }

//   void removeBag(int index) {
//     List<BagData> bags = List.from(state.bags);
//     List<BagData> newBags = [];
//     bags.removeAt(index);
//     for (int i = 0; i < bags.length; i++) {
//       newBags.add(BagData(index: i, bagProducts: bags[i].bagProducts));
//     }
//     LocalStorage.setBags(newBags);
//     final int selectedIndex =
//         state.selectedBagIndex == index ? 0 : state.selectedBagIndex;
//     state = state.copyWith(bags: newBags, selectedBagIndex: selectedIndex);
//   }

//   void removeOrderedBag(BuildContext context) {
//     List<BagData> bags = List.from(state.bags);
//     List<BagData> newBags = LocalStorage.getBags();
//     bags.removeAt(state.selectedBagIndex);
//     if (bags.isEmpty) {
//       final BagData firstBag = BagData(index: 0, bagProducts: []);
//       newBags = [firstBag];
//     } else {
//       for (int i = 0; i < bags.length; i++) {
//         newBags.add(BagData(index: i, bagProducts: bags[i].bagProducts));
//       }
//     }
//     LocalStorage.setBags(newBags);
//     state = state.copyWith(
//         bags: newBags,
//         selectedBagIndex: 0,
//         selectedUser: null,
//         selectedAddress: null,
//         selectedCurrency: null,
//         selectedPayment: null,
//         orderType: TrKeys.pickup);
//     setInitialBagData(context, newBags[0]);
//   }

//   void setInitialBagData(BuildContext context, BagData bag) {
//     state = state.copyWith(
//         selectedAddress: bag.selectedAddress,
//         selectedUser: bag.selectedUser,
//         selectedCurrency: bag.selectedCurrency,
//         selectedPayment: bag.selectedPayment,
//         orderType: state.orderType.isEmpty ? TrKeys.pickup : state.orderType);
//     fetchCarts(context: context);
//   }

//   void setFirstName(String value) {
//     _name = value.trim();
//     if (state.selectNameError != null) {
//       state = state.copyWith(selectNameError: null);
//     }
//   }

//   // Future<void> fetchPayments({VoidCallback? checkYourNetwork}) async {
//   //   final connected = await AppConnectivity.connectivity();
//   //   if (connected) {
//   //     state = state.copyWith(isPaymentsLoading: true, payments: []);
//   //     final response = await paymentsRepository.getPayments();
//   //     response.when(
//   //       success: (data) async {
//   //         final List<PaymentData> payments = data.data ?? [];
//   //         List<PaymentData> filteredPayments = [];
//   //         for (final payment in payments) {
//   //           if (payment.tag != 'wallet') {
//   //             filteredPayments.add(payment);
//   //           }
//   //         }
//   //         state = state.copyWith(
//   //           isPaymentsLoading: false,
//   //           payments: filteredPayments,
//   //         );
//   //         for (final payment in payments) {
//   //           if (payment.tag == 'cash') {
//   //             setSelectedPayment(payment.id);
//   //           }
//   //         }
//   //       },
//   //       failure: (failure, status) {
//   //         state = state.copyWith(isPaymentsLoading: false);
//   //         debugPrint('==> get payments failure: $failure');
//   //       },
//   //     );
//   //   } else {
//   //     checkYourNetwork?.call();
//   //   }
//   // }

//   // void setSelectedPayment(String? paymentId) {
//   //   final List<BagData> bags = List.from(LocalStorage.getBags());
//   //   final user = bags[state.selectedBagIndex].selectedUser;
//   //   final address = bags[state.selectedBagIndex].selectedAddress;
//   //   PaymentData? paymentData;
//   //   for (final payment in state.payments) {
//   //     if (paymentId == payment.id) {
//   //       paymentData = payment;
//   //       break;
//   //     }
//   //   }
//   //   final BagData bag = bags[state.selectedBagIndex].copyWith(
//   //     selectedAddress: address,
//   //     selectedUser: user,
//   //     selectedPayment: paymentData,
//   //   );
//   //   bags[state.selectedBagIndex] = bag;
//   //   LocalStorage.setBags(bags);
//   //   state = state.copyWith(
//   //       bags: bags, selectedPayment: paymentData, selectPaymentError: null);
//   // }

//   // Future<void> fetchCarts(
//   //     {BuildContext? context, bool isNotLoading = false}) async {
//   //   final connected = await AppConnectivity.connectivity();

//   //   if (connected) {
//   //     if (isNotLoading) {
//   //       state = state.copyWith(
//   //         isButtonLoading: true,
//   //       );
//   //     } else {
//   //       state = state.copyWith(
//   //         isProductCalculateLoading: true,
//   //         paginateResponse: null,
//   //         bags: LocalStorage.getBags(),
//   //       );
//   //     }

//   //     final List<BagProductData> bagProducts =
//   //         LocalStorage.getBags()[state.selectedBagIndex].bagProducts ?? [];
//   //     if (bagProducts.isNotEmpty) {
//   //       final response = await productsRepository.getAllCalculations(
//   //           bagProducts, state.orderType, LocalStorage.getBags().first.shopId,
//   //           coupon: state.coupon);
//   //       response.when(
//   //         success: (data) async {
//   //           state = state.copyWith(
//   //             isButtonLoading: false,
//   //             isProductCalculateLoading: false,
//   //             paginateResponse: data.data?.data,
//   //           );
//   //         },
//   //         failure: (failure, status) {
//   //           state = state.copyWith(
//   //             isProductCalculateLoading: false,
//   //             isButtonLoading: false,
//   //           );
//   //           debugPrint('==> get product calculate failure: $failure');
//   //         },
//   //       );
//   //     }
//   //     state = state.copyWith(
//   //       isButtonLoading: false,
//   //       isProductCalculateLoading: false,
//   //     );
//   //   } else {
//   //     if (context?.mounted ?? false) {
//   //       AppHelpers.showSnackBar(
//   //         context!,
//   //         AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
//   //       );
//   //     }
//   //   }
//   // }

//   void clearBag(BuildContext context) {
//     var newPagination = state.paginateResponse?.copyWith(stocks: []);
//     state = state.copyWith(paginateResponse: newPagination);
//     List<BagData> bags = List.from(LocalStorage.getBags());
//     bags[state.selectedBagIndex] =
//         bags[state.selectedBagIndex].copyWith(bagProducts: []);
//     LocalStorage.setBags(bags);
//   }

//   void deleteProductFromBag(BuildContext context, BagProductData bagProduct) {
//     final List<BagProductData> bagProducts = List.from(
//         LocalStorage.getBags()[state.selectedBagIndex].bagProducts ?? []);
//     int index = 0;
//     for (int i = 0; i < bagProducts.length; i++) {
//       if (bagProducts[i].stockId == bagProduct.stockId) {
//         index = i;
//         break;
//       }
//     }
//     bagProducts.removeAt(index);
//     List<BagData> bags = List.from(LocalStorage.getBags());
//     bags[state.selectedBagIndex] =
//         bags[state.selectedBagIndex].copyWith(bagProducts: bagProducts);
//     LocalStorage.setBags(bags);
//     fetchCarts(context: context);
//   }

//   void deleteProductCount({required int productIndex}) {
//     List<ProductData> listOfProduct =
//         List.from(state.paginateResponse?.stocks ?? []);
//     listOfProduct.removeAt(productIndex);
//     PriceDate? data = state.paginateResponse;
//     PriceDate? newData = data?.copyWith(stocks: listOfProduct);
//     state = state.copyWith(paginateResponse: newData);
//     List<BagData> bags = List.from(LocalStorage.getBags());

//     List<BagProductData>? bagProducts =
//         bags[state.selectedBagIndex].bagProducts;
//     bagProducts?.removeAt(productIndex);
//     bags[state.selectedBagIndex] =
//         bags[state.selectedBagIndex].copyWith(bagProducts: bagProducts);
//     LocalStorage.setBags(bags);

//     fetchCarts(isNotLoading: true);
//   }

//   Future<void> decreaseProductCount({
//     required int productIndex,
//     required BuildContext context,
//   }) async {
//     timer?.cancel();
//     ProductData? product = state.paginateResponse?.stocks?[productIndex];
//     List<BagData> bags = LocalStorage.getBags();
//     if ((product?.quantity ?? 1) > 1) {
//       ProductData? newProduct = product?.copyWith(
//         quantity: ((product.quantity ?? 0) - 1),
//       );
//       List<ProductData> listOfProduct =
//           List.from(state.paginateResponse?.stocks ?? []);
//       listOfProduct[productIndex] = newProduct ?? ProductData();
//       PriceDate? data = state.paginateResponse;
//       PriceDate? newData = data?.copyWith(stocks: listOfProduct);
//       state = state.copyWith(paginateResponse: newData);
//       final List<BagProductData> bagProducts =
//           bags[state.selectedBagIndex].bagProducts ?? [];
//       BagProductData newProductData = bagProducts[productIndex]
//           .copyWith(quantity: (bagProducts[productIndex].quantity ?? 0) - 1);
//       bagProducts[productIndex] = newProductData;
//       bags[state.selectedBagIndex] =
//           bags[state.selectedBagIndex].copyWith(bagProducts: bagProducts);
//       LocalStorage.setBags(bags);
//     } else {
//       List<ProductData> listOfProduct =
//           List.from(state.paginateResponse?.stocks ?? []);
//       listOfProduct.removeAt(productIndex);
//       PriceDate? data = state.paginateResponse;
//       PriceDate? newData = data?.copyWith(stocks: listOfProduct);
//       state = state.copyWith(paginateResponse: newData);
//       final List<BagProductData> bagProducts =
//           bags[state.selectedBagIndex].bagProducts ?? [];
//       if (bagProducts.isNotEmpty) bagProducts.removeAt(productIndex);
//       if (bagProducts.isEmpty) {
//         clearBag(context);
//       }
//       bags[state.selectedBagIndex] =
//           bags[state.selectedBagIndex].copyWith(bagProducts: bagProducts);
//       LocalStorage.setBags(bags);
//     }
//     timer = Timer(
//       const Duration(milliseconds: 600),
//       () => fetchCarts(isNotLoading: true),
//     );
//   }

//   void increaseProductCount({required int productIndex}) {
//     timer?.cancel();
//     ProductData? product = state.paginateResponse?.stocks?[productIndex];
//     ProductData? newProduct = product?.copyWith(
//         quantity: ((product.quantity ?? 0) + 1), discount: product.discount);
//     List<ProductData>? listOfProduct = state.paginateResponse?.stocks;
//     listOfProduct?.removeAt(productIndex);
//     listOfProduct?.insert(productIndex, newProduct ?? ProductData());
//     PriceDate? data = state.paginateResponse;
//     PriceDate? newData = data?.copyWith(stocks: listOfProduct);
//     state = state.copyWith(paginateResponse: newData);
//     final List<BagProductData> bagProducts =
//         LocalStorage.getBags()[state.selectedBagIndex].bagProducts ?? [];

//     BagProductData newProductData = bagProducts[productIndex]
//         .copyWith(quantity: (bagProducts[productIndex].quantity ?? 0) + 1);
//     bagProducts.removeAt(productIndex);
//     bagProducts.insert(productIndex, newProductData);
//     List<BagData> bags = List.from(LocalStorage.getBags());
//     bags[state.selectedBagIndex] =
//         bags[state.selectedBagIndex].copyWith(bagProducts: bagProducts);
//     LocalStorage.setBags(bags);
//     timer = Timer(
//       const Duration(milliseconds: 500),
//       () => fetchCarts(isNotLoading: true),
//     );
//   }

//   Future<void> placeOrder(
//       {required BuildContext context,
//       String? shopId,
//       required VoidCallback invalidateState}) async {
//     bool active = true;
//     // if (_name?.isEmpty ?? true) {
//     //   state = state.copyWith(selectNameError: TrKeys.selectName);
//     //   active = false;
//     // }
//     // if (_phone?.isEmpty ?? true) {
//     //   state = state.copyWith(selectPhoneError: TrKeys.phoneNumberIsNotValid);
//     //   active = false;
//     // }
//     if (state.selectedSection == null && state.orderType == TrKeys.dine) {
//       state = state.copyWith(selectSectionError: TrKeys.selectSection);
//       active = false;
//     }
//     if (state.selectedTable == null && state.orderType == TrKeys.dine) {
//       state = state.copyWith(selectTableError: TrKeys.selectTable);
//       active = false;
//     }
//     if (state.selectedCurrency == null) {
//       state = state.copyWith(selectCurrencyError: TrKeys.selectCurrency);
//       active = false;
//     }
//     if (state.selectedPayment == null) {
//       state = state.copyWith(selectPaymentError: TrKeys.selectPayment);
//       active = false;
//     }

//     if (active) {
//       state =
//           state.copyWith(selectedUser: KioskData(name: _name, phone: _phone));
//       createOrder(
//           context,
//           OrderBodyData(
//             currencyId: state.selectedCurrency?.id,
//             rate: state.selectedCurrency?.rate,
//             bagData: state.bags[state.selectedBagIndex],
//             user: state.selectedUser,
//             deliveryType: state.orderType,
//             coupon: state.coupon,
//             note: state.comment,
//             tableId: state.selectedTable?.id,
//           ), onSuccess: (o) {
//         fetchBags(shopId);
//         context.maybePop();
//         showDialog(
//             context: context,
//             builder: (context) {
//               return LayoutBuilder(builder: (context, constraints) {
//                 return AlertDialog(
//                   content: SizedBox(
//                     // height: constraints.maxHeight
//                     // *
//                     // ((o?.details?.length ?? 0) > 3
//                     //     ? 0.95
//                     //     : (o?.details?.length ?? 0) > 2
//                     //         ? 0.84
//                     //         : 0.75)
//                     // ,
//                     width: 300.r,
//                     child: GenerateCheckPage(orderData: o),
//                   ),
//                 );
//               });
//             }).whenComplete(() {
//           context.router.popUntilRoot();
//           context.replaceRoute(const MainRoute());
//           invalidateState.call();
//         });
//       });
//     }
//   }

//   setNote(String note) {
//     state = state.copyWith(comment: note);
//   }

//   Future createOrder(
//     BuildContext context,
//     OrderBodyData data, {
//     ValueChanged<OrderData?>? onSuccess,
//     VoidCallback? onFailure,
//   }) async {
//     final connected = await AppConnectivity.connectivity();
//     if (connected) {
//       state = state.copyWith(isOrderLoading: true);
//       final response = await ordersRepository.createOrder(data);
//       response.when(
//         success: (order) async {
//           removeOrderedBag(context);
//           switch (data.bagData.selectedPayment?.tag) {
//             case 'cash':
//               paymentsRepository.createTransaction(
//                 orderId: order.data!.id,
//                 paymentId: data.bagData.selectedPayment?.id,
//               );
//               state = state.copyWith(isOrderLoading: false);
//               onSuccess?.call(order.data);
//               break;
//             default:
//               final res = await ordersRepository.process(
//                 orderId: order.data!.id,
//                 name: data.bagData.selectedPayment?.tag,
//               );
//               res.when(success: (url) async {
//                 state = state.copyWith(isOrderLoading: false);
//                 await context.pushRoute(WebViewRoute(url: url));
//                 onSuccess?.call(order.data);
//               }, failure: (failure, status) {
//                 state = state.copyWith(isOrderLoading: false);
//               });
//               break;
//           }
//         },
//         failure: (failure, status) {
//           state = state.copyWith(isOrderLoading: false);
//           if (mounted) {
//             AppHelpers.showSnackBar(
//               context,
//               AppHelpers.getTranslation(500.toString()),
//             );
//           }
//         },
//       );
//     } else {
//       if (context.mounted) {
//         AppHelpers.showSnackBar(
//             context, AppHelpers.getTranslation(TrKeys.noInternetConnection));
//       }
//     }
//   }

// }
