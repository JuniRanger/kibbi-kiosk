// ignore_for_file: must_be_immutable, deprecated_member_use

import 'package:flutter_svg/flutter_svg.dart';
import 'package:kibbi_kiosk/src/core/constants/constants.dart';
import 'package:kibbi_kiosk/src/core/utils/app_helpers.dart';
import 'package:kibbi_kiosk/src/models/data/bag_data.dart';
import 'package:kibbi_kiosk/src/presentation/components/components.dart';
import 'package:kibbi_kiosk/src/presentation/pages/main/widgets/product_list/riverpod/shop_provider.dart';
import 'package:kibbi_kiosk/src/presentation/theme/theme.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kibbi_kiosk/src/core/utils/app_validators.dart';
import 'riverpod/right_side_notifier.dart';
import 'riverpod/right_side_provider.dart';
import 'riverpod/right_side_state.dart';

class OrderInformation extends ConsumerWidget {
  OrderInformation({super.key});

  List listOfType = [
    'Para llevar',
    'Comer Aquí',
  ];

  @override
  Widget build(BuildContext context, ref) {
    final notifier = ref.read(rightSideProvider.notifier);
    final state = ref.watch(rightSideProvider);
    final BagData? bag = state.bag;

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
                    'Orden',
                    style: GoogleFonts.inter(
                        fontSize: 22.r, fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      context.router.maybePop();
                    },
                    icon: const Icon(FlutterRemix.close_line),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 18,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextField(
                          inputType: TextInputType.text,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(15),
                          ],
                          validator: (value) {
                            final emptyCheck = AppValidators.emptyCheck(value);
                            if (emptyCheck != null) return emptyCheck;
                            return AppValidators.maxLengthCheck(value, 15);
                          },
                          onChanged: (value) {
                            notifier.setFirstName(value);
                          },
                          label: 'Nombre',
                        ),
                        4.verticalSpace,
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            '${state.customerName?.length ?? 0}/15',
                            style: GoogleFonts.inter(
                              fontSize: 12.sp,
                              color: Style.unselectedTab,
                            ),
                          ),
                        ),
                        Visibility(
                          visible: state.selectNameError != null,
                          child: Padding(
                            padding: EdgeInsets.only(top: 6.r, left: 4.r),
                            child: Text(
                              'Error al seleccionar el nombre',
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
              8.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        8.verticalSpace,
                        PopupMenuButton<int>(
                          itemBuilder: (context) {
                            return state.currencies
                                .map(
                                  (currency) => PopupMenuItem<int>(
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
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          color: Style.white,
                          elevation: 10,
                          child: SelectFromButton(
                            title: state.selectedCurrency?.title ??
                                'Seleccionar moneda',
                          ),
                        ),
                        Column(
                          children: [
                            Visibility(
                              visible: state.selectCurrencyError != null,
                              child: Padding(
                                padding: EdgeInsets.only(top: 6.r, left: 4.r),
                                child: Text(
                                  'Error al seleccionar la moneda',
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
                  8.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        8.verticalSpace,
                        PopupMenuButton<String>(
                          itemBuilder: (context) {
                            return [
                              PopupMenuItem<String>(
                                value: null,
                                child: Text(
                                  'Seleccionar método de pago',
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.sp,
                                    color: Style.unselectedTab,
                                  ),
                                ),
                              ),
                              ...['Efectivo', 'Tarjeta'].map(
                                (method) => PopupMenuItem<String>(
                                  value: method.toLowerCase(),
                                  child: Text(
                                    method,
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.sp,
                                      color: Style.black,
                                    ),
                                  ),
                                ),
                              ),
                            ];
                          },
                          onSelected: (String? selectedMethod) {
                            if (selectedMethod != null) {
                              notifier.setPaymentMethod(selectedMethod);
                            }
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          color: Style.white,
                          elevation: 10,
                          child: SelectFromButton(
                            title: state.paymentMethod.isNotEmpty == true
                                ? state.paymentMethod[0].toUpperCase() +
                                    state.paymentMethod.substring(1)
                                : 'Seleccionar método de pago',
                          ),
                        ),
                        Visibility(
                          visible: state.selectPaymentError != null,
                          child: Padding(
                            padding: EdgeInsets.only(top: 6.r, left: 4.r),
                            child: Text(
                              'Error al seleccionar el pago',
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
              8.verticalSpace,
              const Divider(),
              8.verticalSpace,

              /// Código de descuento
              Row(
                crossAxisAlignment: CrossAxisAlignment.start, // Align top
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextField(
                          inputType: TextInputType.text,
                          label: 'Código de descuento',
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(13), // Limit to 13 characters
                          ],
                          onChanged: (value) {
                            notifier.setCoupon(value); // Save the coupon
                          },
                        ),
                        4.verticalSpace,
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            '${state.coupon?.length ?? 0}/13',
                            style: GoogleFonts.inter(
                              fontSize: 12.sp,
                              color: Style.unselectedTab,
                            ),
                          ),
                        ),
                        if (state.errorMessage != null) ...[
                          4.verticalSpace,
                          Text(
                            state.errorMessage!,
                            style: GoogleFonts.inter(
                              fontSize: 12.sp,
                              color: Style.red,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  8.horizontalSpace,
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(top: 2.r), // Align with text field
                      child: LoginButton(
                        title: 'Redimir',
                        titleColor: Style.white,
                        bgColor: Style.primary,
                        onPressed: () {
                          if (state.coupon != null && state.coupon!.length <= 13) {
                            notifier.setDiscount(context); // Apply discount
                          } else {
                            AppHelpers.showSnackBar(
                              context,
                              'El código debe tener 13 caracteres',
                            );
                          }
                        },
                        textStyle: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700, // Make text bolder
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              4.verticalSpace,
              const Divider(),
              4.verticalSpace,
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
                                        border: Border.all(
                                          color:
                                              state.orderType.toLowerCase() ==
                                                      e.toString().toLowerCase()
                                                  ? Style.white
                                                  : Style.black,
                                        ),
                                      ),
                                      padding: EdgeInsets.all(6.r),
                                      child: e == 'Para llevar'
                                          ? SvgPicture.asset(
                                              "assets/svg/pickup.svg",
                                              color: state.orderType
                                                          .toLowerCase() ==
                                                      e.toString().toLowerCase()
                                                  ? Style.white
                                                  : Style.black,
                                            )
                                          : e == 'Comer Aquí'
                                              ? SvgPicture.asset(
                                                  "assets/svg/dine.svg",
                                                  color: state.orderType
                                                              .toLowerCase() ==
                                                          e
                                                              .toString()
                                                              .toLowerCase()
                                                      ? Style.white
                                                      : Style.black,
                                                )
                                              : SvgPicture.asset(
                                                  "assets/svg/dine.svg",
                                                  color: state.orderType
                                                              .toLowerCase() ==
                                                          e
                                                              .toString()
                                                              .toLowerCase()
                                                      ? Style.white
                                                      : Style.black,
                                                ),
                                    ),
                                    8.horizontalSpace,
                                    Text(
                                      e,
                                      style: GoogleFonts.inter(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                        color: state.orderType.toLowerCase() ==
                                                e.toString().toLowerCase()
                                            ? Style.white
                                            : Style.black,
                                      ),
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
              8.verticalSpace,
              const Divider(),
              16.verticalSpace,
              _priceInformation(
                state: state,
                notifier: notifier,
                bag: bag ?? BagData(),
                context: context,
              ),
              16.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 186.w,
                    child: LoginButton(
                        isLoading: state.isOrderLoading,
                        title: 'Ordenar',
                        titleColor: Style.white,
                        onPressed: () {
                          notifier.placeOrder(
                              context: context,
                              invalidateState: () {
                                ref.invalidate(shopProvider);
                                ref.invalidate(rightSideProvider);
                              });
                        }),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '',
                        style: GoogleFonts.inter(
                          color: Style.black,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
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

  Widget _priceInformation({
    required RightSideState state,
    required RightSideNotifier notifier,
    required BagData bag,
    required BuildContext context,
  }) {
    final subtotal = state.bag?.cartTotal ?? 0.0;
    final discount = state.discount; // Use the discount from the state
    final total = discount != null ? subtotal - discount : subtotal;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Subtotal',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w400, // Smaller weight
                fontSize: 14.sp, // Smaller font size
                color: Style.unselectedTab, // Softer color
              ),
            ),
            Text(
              AppHelpers.numberFormat(subtotal, symbol: '\$'),
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w500, // Slightly bold
                fontSize: 14.sp, // Smaller font size
                color: Style.unselectedTab, // Softer color
              ),
            ),
          ],
        ),
        if (state.discount != null) ...[
          4.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Descuento',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w400, // Smaller weight
                  fontSize: 14.sp, // Smaller font size
                  color: Style.red, // Highlight discount in red
                ),
              ),
              Text(
                '-${AppHelpers.numberFormat(discount, symbol: '\$')}',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500, // Slightly bold
                  fontSize: 14.sp, // Smaller font size
                  color: Style.red, // Highlight discount in red
                ),
              ),
            ],
          ),
        ],
        4.verticalSpace, // Add some spacing between Subtotal/Discount and Total
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Precio total',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
                color: Style.black,
              ),
            ),
            Text(
              AppHelpers.numberFormat(total, symbol: '\$'),
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                fontSize: 20.sp,
                color: Style.black,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
