import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'right_side_notifier.dart';
import 'right_side_state.dart';

final rightSideProvider =
    StateNotifierProvider<RightSideNotifier, RightSideState>(
  (ref) => RightSideNotifier(),
);

// class RightSideNotifier extends StateNotifier<RightSideState> {
//   RightSideNotifier() : super(RightSideState());

//   void fetchCurrencies() {
//     // state = state.copyWith(isCurrenciesLoading: true);
//     // final response = await _apiService.fetchCurrencies();
//     // state = state.copyWith(isCurrenciesLoading: false, currencies: response);
//   }

//   void clearBag() {
//     state = state.copyWith(bags: []);
//   }

//   void addBag() {
//     // state = state.copyWith(isBagsLoading: true);
//     // final response = await _apiService.addBag();
//     // state = state.copyWith(isBagsLoading: false, bags: response);
//   }

//   void increaseProductCount() {
//     // state = state.copyWith(isProductCalculateLoading: true);
//     // final response = await _apiService.increaseProductCount();
//     // state = state.copyWith(isProductCalculateLoading: false, calculate: response);
//   }

//   void decreaseProductCount() {
//     // state = state.copyWith(isProductCalculateLoading: true);
//     // final response = await _apiService.decreaseProductCount();
//     // state = state.copyWith(isProductCalculateLoading: false, calculate: response);
//   }

//   void fetchPayments() {
//     // state = state.copyWith(isPaymentsLoading: true);
//     // final response = await _apiService.fetchPayments();
//     // state = state.copyWith(isPaymentsLoading: false, payments: response);
//   }


//   void deleteProductCount() {
//     // state = state.copyWith(isProductCalculateLoading: true);
//     // final response = await _apiService.deleteProductCount();
//     // state = state.copyWith(isProductCalculateLoading: false, calculate: response);
//   }

//   void setInitialBagData() {}


