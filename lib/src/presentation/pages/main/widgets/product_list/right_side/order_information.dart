// ignore_for_file: must_be_immutable

import 'package:flutter_svg/flutter_svg.dart';
import 'package:kiosk/src/core/constants/constants.dart';
import 'package:kiosk/src/core/utils/app_helpers.dart';
import 'package:kiosk/src/core/utils/app_validators.dart';
import 'package:kiosk/src/models/data/bag_data.dart';
import 'package:kiosk/src/presentation/components/components.dart';
import 'package:kiosk/src/presentation/pages/main/riverpod/main_provider.dart';
import 'package:kiosk/src/presentation/pages/main/widgets/product_list/riverpod/shop_provider.dart';
import 'package:kiosk/src/presentation/theme/theme.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:kiosk/src/riverpod/provider/app_provider.dart';

import 'riverpod/right_side_notifier.dart';
import 'riverpod/right_side_provider.dart';
import 'riverpod/right_side_state.dart';

class OrderInformation extends ConsumerWidget {
  OrderInformation({super.key});

  List listOfType = [
    TrKeys.pickup,
    TrKeys.dine,
  ];

  @override
  Widget build(BuildContext context, ref) {
    final notifier = ref.read(rightSideProvider.notifier);
    final state = ref.watch(rightSideProvider);
    final BagData bag =
        state.bags.isNotEmpty ? state.bags[state.selectedBagIndex] : BagData();
    return KeyboardDismisser(
      child: Container(
        width: MediaQuery.sizeOf(context).width / 2,
        padding: REdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: Style.white,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(
                    AppHelpers.getTranslation(TrKeys.order),
                    style: GoogleFonts.inter(
                        fontSize: 22.r, fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      context.popRoute();
                    },
                    icon: const Icon(FlutterRemix.close_line),
                  )
                ],
              ),
              16.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextField(
                          inputType: TextInputType.text,
                          validator: AppValidators.emptyCheck,
                          onChanged: notifier.setFirstName,
                          label: AppHelpers.getTranslation(TrKeys.firstname),
                        ),
                        Visibility(
                          visible: state.selectNameError != null,
                          child: Padding(
                            padding: EdgeInsets.only(top: 6.r, left: 4.r),
                            child: Text(
                              AppHelpers.getTranslation(
                                  state.selectNameError ?? ""),
                              style: GoogleFonts.inter(
                                  color: Style.red, fontSize: 14.sp),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  16.horizontalSpace,
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IntlPhoneField(
                        onChanged: (phoneNum) {
                          notifier.setPhone(phoneNum.completeNumber);
                        },
                        disableLengthCheck:
                            !AppConstants.isNumberLengthAlwaysSame,
                        validator: (s) {
                          if (AppConstants.isNumberLengthAlwaysSame &&
                              (AppValidators.isValidPhone(s?.completeNumber))) {
                            return AppHelpers.getTranslation(
                                TrKeys.phoneNumberIsNotValid);
                          }
                          return null;
                        },
                        showCountryFlag: AppConstants.showFlag,
                        showDropdownIcon: AppConstants.showArrowIcon,
                        keyboardType: TextInputType.phone,
                        initialCountryCode: AppConstants.countryCodeISO,
                        invalidNumberMessage: AppHelpers.getTranslation(
                            TrKeys.phoneNumberIsNotValid),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        autovalidateMode: AppConstants.isNumberLengthAlwaysSame
                            ? AutovalidateMode.onUserInteraction
                            : AutovalidateMode.disabled,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: const InputDecoration(counterText: ''),
                      ),
                      Visibility(
                        visible: state.selectPhoneError != null,
                        child: Padding(
                          padding: EdgeInsets.only(top: 6.r, left: 4.r),
                          child: Text(
                            AppHelpers.getTranslation(
                                state.selectPhoneError ?? ""),
                            style: GoogleFonts.inter(
                                color: Style.red, fontSize: 14.sp),
                          ),
                        ),
                      ),
                    ],
                  )),
                ],
              ),
              16.verticalSpace,
              if (state.orderType == TrKeys.dine)
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                color: Style.unselectedBottomBarBack,
                                width: 1.r,
                              ),
                            ),
                            alignment: Alignment.center,
                            height: 56.r,
                            padding: EdgeInsets.only(left: 16.r),
                            child: CustomDropdown(
                              hintText: AppHelpers.getTranslation(
                                  TrKeys.selectSection),
                              searchHintText:
                                  AppHelpers.getTranslation(TrKeys.search),
                              dropDownType: DropDownType.section,
                              onChanged: (value) =>
                                  notifier.setSectionQuery(context, value),
                              initialValue:
                                  bag.selectedSection?.translation?.title ?? '',
                            ),
                          ),
                          Visibility(
                            visible: state.selectSectionError != null,
                            child: Padding(
                              padding: EdgeInsets.only(top: 6.r, left: 4.r),
                              child: Text(
                                AppHelpers.getTranslation(
                                    state.selectSectionError ?? ""),
                                style: GoogleFonts.inter(
                                    color: Style.red, fontSize: 14.sp),
                              ),
                            ),
                          ),
                          16.verticalSpace,
                        ],
                      ),
                    ),
                    16.horizontalSpace,
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: Style.unselectedBottomBarBack,
                              width: 1.r,
                            ),
                          ),
                          alignment: Alignment.center,
                          height: 56.r,
                          padding: EdgeInsets.only(left: 16.r),
                          child: CustomDropdown(
                            hintText:
                                AppHelpers.getTranslation(TrKeys.selectTable),
                            searchHintText:
                                AppHelpers.getTranslation(TrKeys.search),
                            dropDownType: DropDownType.table,
                            onChanged: (value) =>
                                notifier.setTableQuery(context, value),
                            initialValue: bag.selectedTable?.name ?? '',
                          ),
                        ),
                        Visibility(
                          visible: state.selectTableError != null,
                          child: Padding(
                            padding: EdgeInsets.only(top: 6.r, left: 4.r),
                            child: Text(
                              AppHelpers.getTranslation(
                                  state.selectTableError ?? ""),
                              style: GoogleFonts.inter(
                                  color: Style.red, fontSize: 14.sp),
                            ),
                          ),
                        ),
                        16.verticalSpace,
                      ],
                    )),
                  ],
                ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PopupMenuButton<int>(
                          itemBuilder: (context) {
                            return state.currencies
                                .map(
                                  (currency) => PopupMenuItem<int>(
                                    value: currency.id,
                                    child: Text(
                                      '${currency.title ?? ''}(${currency.symbol ?? ''})',
                                      style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.sp,
                                        color: Style.black,
                                        letterSpacing: -14 * 0.02,
                                      ),
                                    ),
                                  ),
                                )
                                .toList();
                          },
                          onSelected: notifier.setSelectedCurrency,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          color: Style.white,
                          elevation: 10,
                          child: SelectFromButton(
                            title: state.selectedCurrency?.title ??
                                AppHelpers.getTranslation(
                                    TrKeys.selectCurrency),
                          ),
                        ),
                        Column(
                          children: [
                            Visibility(
                              visible: state.selectCurrencyError != null,
                              child: Padding(
                                padding: EdgeInsets.only(top: 6.r, left: 4.r),
                                child: Text(
                                  AppHelpers.getTranslation(
                                      state.selectCurrencyError ?? ""),
                                  style: GoogleFonts.inter(
                                      color: Style.red, fontSize: 14.sp),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  16.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PopupMenuButton<int>(
                          itemBuilder: (context) {
                            return state.payments
                                .map(
                                  (payment) => PopupMenuItem<int>(
                                    value: payment.id,
                                    child: Text(
                                      AppHelpers.getTranslation(
                                          payment.tag ?? ""),
                                      style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.sp,
                                        color: Style.black,
                                        letterSpacing: -14 * 0.02,
                                      ),
                                    ),
                                  ),
                                )
                                .toList();
                          },
                          onSelected: notifier.setSelectedPayment,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          color: Style.white,
                          elevation: 10,
                          child: SelectFromButton(
                            title: AppHelpers.getTranslation(
                                state.selectedPayment?.tag ??
                                    TrKeys.selectPayment),
                          ),
                        ),
                        Visibility(
                          visible: state.selectPaymentError != null,
                          child: Padding(
                            padding: EdgeInsets.only(top: 6.r, left: 4.r),
                            child: Text(
                              AppHelpers.getTranslation(
                                  state.selectPaymentError ?? ""),
                              style: GoogleFonts.inter(
                                  color: Style.red, fontSize: 14.sp),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              12.verticalSpace,
              const Divider(),
              12.verticalSpace,
              Row(
                children: [
                  ...listOfType.map((e) => Expanded(
                        child: InkWell(
                          onTap: () {
                            notifier.setSelectedOrderType(e);
                            if (state.orderType.toLowerCase() !=
                                e.toString().toLowerCase()) {
                              ref.read(rightSideProvider.notifier).fetchCarts(
                                  context: context, isNotLoading: true);
                            }
                          },
                          child: AnimationButtonEffect(
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 4.r),
                              decoration: BoxDecoration(
                                color: state.orderType.toLowerCase() ==
                                        e.toString().toLowerCase()
                                    ? Style.primary
                                    : Style.editProfileCircle,
                                borderRadius: BorderRadius.circular(6.r),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 10.r),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Style.transparent,
                                        shape: BoxShape.circle,
                                        border: Border.all(color: Style.black),
                                      ),
                                      padding: EdgeInsets.all(6.r),
                                      child: e == TrKeys.delivery
                                          ? Icon(
                                              FlutterRemix.takeaway_fill,
                                              size: 18.sp,
                                            )
                                          : e == TrKeys.pickup
                                              ? SvgPicture.asset(
                                                  "assets/svg/pickup.svg")
                                              : SvgPicture.asset(
                                                  "assets/svg/dine.svg"),
                                    ),
                                    8.horizontalSpace,
                                    Text(
                                      AppHelpers.getTranslation(e),
                                      style: GoogleFonts.inter(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      )),
                ],
              ),
              12.verticalSpace,
              const Divider(),
              24.verticalSpace,
              _priceInformation(
                state: state,
                notifier: notifier,
                bag: bag,
                context: context,
              ),
              20.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 186.w,
                    child: LoginButton(
                        isLoading: state.isOrderLoading,
                        title: AppHelpers.getTranslation(TrKeys.placeOrder),
                        onPressed: () {
                          notifier.placeOrder(
                              context: context,
                              shopId: ref.read(shopProvider).selectedShop?.id,
                              invalidateState: () {
                                ref.invalidate(shopProvider);
                                ref.invalidate(mainProvider);
                                ref.invalidate(rightSideProvider);
                                ref.invalidate(appProvider);
                              });
                        }),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppHelpers.getTranslation(TrKeys.totalPrice),
                        style: GoogleFonts.inter(
                          color: Style.black,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          letterSpacing: -0.4,
                        ),
                      ),
                      Text(
                        AppHelpers.numberFormat(
                          state.paginateResponse?.totalPrice,
                          symbol: bag.selectedCurrency?.symbol,
                        ),
                        style: GoogleFonts.inter(
                          color: Style.black,
                          fontSize: 30.sp,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.4,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _priceInformation(
      {required RightSideState state,
      required RightSideNotifier notifier,
      required BagData bag,
      required BuildContext context}) {
    return Column(
      children: [
        _priceItem(
          title: TrKeys.subtotal,
          price: state.paginateResponse?.price,
          symbol: bag.selectedCurrency?.symbol,
        ),
        _priceItem(
          title: TrKeys.tax,
          price: state.paginateResponse?.totalTax,
          symbol: bag.selectedCurrency?.symbol,
        ),
        _priceItem(
          title: TrKeys.serviceFee,
          price: state.paginateResponse?.serviceFee,
          symbol: bag.selectedCurrency?.symbol,
        ),
        _priceItem(
          title: TrKeys.discount,
          price: state.paginateResponse?.totalDiscount,
          symbol: bag.selectedCurrency?.symbol,
          isDiscount: true,
        ),
        _priceItem(
          title: TrKeys.promoCode,
          price: state.paginateResponse?.couponPrice,
          symbol: bag.selectedCurrency?.symbol,
          isDiscount: true,
        ),
        const Divider(),
      ],
    );
  }

  _priceItem({
    required String title,
    required num? price,
    required String? symbol,
    bool isDiscount = false,
  }) {
    return (price ?? 0) != 0
        ? Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppHelpers.getTranslation(title),
                    style: GoogleFonts.inter(
                      color: isDiscount ? Style.red : Style.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.4,
                    ),
                  ),
                  Text(
                    (isDiscount ? "-" : '') +
                        AppHelpers.numberFormat(price, symbol: symbol),
                    style: GoogleFonts.inter(
                      color: isDiscount ? Style.red : Style.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.4,
                    ),
                  ),
                ],
              ),
              12.verticalSpace,
            ],
          )
        : const SizedBox.shrink();
  }
}
