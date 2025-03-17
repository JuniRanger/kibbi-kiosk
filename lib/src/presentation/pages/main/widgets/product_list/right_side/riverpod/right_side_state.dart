
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kibbi_kiosk/src/models/models.dart';
part 'right_side_state.freezed.dart';

@freezed
class RightSideState with _$RightSideState {
  const factory RightSideState({
    @Default(false) bool isBagsLoading,
    @Default(false) bool isCurrenciesLoading,
    @Default(false) bool isPaymentsLoading,
    @Default(false) bool isProductCalculateLoading,
    @Default(false) bool isButtonLoading,
    @Default(false) bool isActive,
    @Default(false) bool isOrderLoading,
    @Default(null) BagData? bag,
    @Default([]) List<CurrencyData> currencies,
    @Default([]) List<PaymentData> payments,
    @Default(0) int selectedBagIndex,
    @Default('') String orderType,
    @Default('') String comment,
    @Default('') String calculate,
    @Default(null) String? selectNameError,
    @Default(null) String? selectPhoneError,
    @Default(null) String? selectCurrencyError,
    @Default(null) String? selectPaymentError,
    @Default(null) String? selectSectionError,
    @Default(null) String? selectTableError,
    @Default(null) String? coupon,
    @Default(null) KioskData? selectedUser,
    @Default('') String paymentMethod,
    CurrencyData? selectedCurrency,
    PaymentData? selectedPayment,
    PriceDate? paginateResponse,
  }) = _RightSideState;

  const RightSideState._();
}
