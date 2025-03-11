// ignore_for_file: must_be_immutable

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
              16.verticalSpace,
              Row(
                children: [
                  Expanded(
                    flex: 999,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextField(
                          inputType: TextInputType.text,
                          validator: AppValidators.emptyCheck,
                          onChanged: notifier.setFirstName,
                          label: 'Nombre',
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
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Visibility(
                        child: Padding(
                          padding: EdgeInsets.only(top: 6.r, left: 4.r),
                          child: Text(
                            'Error al seleccionar el teléfono',
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
                  16.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PopupMenuButton<String>(
                          itemBuilder: (context) {
                            return state.payments
                                .map(
                                  (payment) => PopupMenuItem<String>(
                                    value: payment.id,
                                    child: Text(
                                      payment.tag ?? '',
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
                            title: 'Seleccionar pago',
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
                                      child: e == 'Para llevar'
                                          ? Icon(
                                              FlutterRemix.takeaway_fill,
                                              size: 18.sp,
                                            )
                                          : e == 'Comer Aquí'
                                              ? SvgPicture.asset(
                                                  "assets/svg/pickup.svg")
                                              : SvgPicture.asset(
                                                  "assets/svg/dine.svg"),
                                    ),
                                    8.horizontalSpace,
                                    Text(
                                      e,
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
                        title: 'Ordenar',
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
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          letterSpacing: -0.4,
                        ),
                      ),
                      Text(
                        AppHelpers.numberFormat(
                          state.paginateResponse?.totalPrice,
                          symbol: '\$',
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
}

Widget _priceInformation({
  required RightSideState state,
  required RightSideNotifier notifier,
  required BagData bag,
  required BuildContext context,
}) {
  return Column(
    children: [
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
            AppHelpers.numberFormat(state.paginateResponse?.totalPrice,
                symbol: '\$'),
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
