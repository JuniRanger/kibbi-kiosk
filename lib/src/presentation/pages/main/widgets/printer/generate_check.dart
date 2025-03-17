// ignore_for_file: depend_on_referenced_packages

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../product_list/right_side/riverpod/right_side_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kibbi_kiosk/src/core/constants/constants.dart';
import 'package:kibbi_kiosk/src/core/routes/app_router.dart';
import 'package:kibbi_kiosk/src/core/utils/app_helpers.dart';
import 'package:kibbi_kiosk/src/core/utils/time_service.dart';
import 'package:kibbi_kiosk/src/models/data/bag_data.dart';
import 'package:kibbi_kiosk/src/models/data/order_body_data.dart';
import 'package:kibbi_kiosk/src/models/data/order_data.dart';
import 'package:kibbi_kiosk/src/presentation/components/components.dart';
import 'package:kibbi_kiosk/src/presentation/theme/app_style.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../product_list/right_side/riverpod/right_side_provider.dart';

import 'print_page.dart';

class GenerateCheckPage extends ConsumerWidget {
  final OrderBodyData? orderData;

  const GenerateCheckPage({super.key, required this.orderData});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rightSideState = ref.watch(rightSideProvider);
    final bagData = rightSideState.bag;
    num subTotal = bagData?.cartTotal ?? 0; // Use cartTotal from BagData

    return Container(
      decoration: BoxDecoration(
        color: Style.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      padding: EdgeInsets.all(16.r),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Resumen del pedido',
              style: GoogleFonts.inter(
                  fontSize: 22.sp, fontWeight: FontWeight.w600),
            ),
            8.verticalSpace,
            Text(
              "Orden #${orderData?.numOrder}",
              style: GoogleFonts.inter(
                  fontSize: 16.sp, fontWeight: FontWeight.w500),
            ),
            12.verticalSpace,
            Row(
              children: List.generate(
                  20,
                  (index) => Expanded(
                        child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 4.r),
                            height: 2,
                            color: Style.iconButtonBack),
                      )),
            ),
            12.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 100.w,
                  child: Text(
                    'Restaurante',
                    style: GoogleFonts.inter(
                        fontSize: 14.sp, fontWeight: FontWeight.w500),
                  ),
                ),
                Text(
                  "Restaurante",
                  style: GoogleFonts.inter(
                      fontSize: 14.sp, fontWeight: FontWeight.w400),
                )
              ],
            ),
            8.verticalSpace,
            // Commented out the username check and display logic
            /*
            if (orderData?.username?.isNotEmpty ?? false)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 100.w,
                        child: Text(
                          'Cliente',
                          style: GoogleFonts.inter(
                              fontSize: 14.sp, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Text(
                        orderData?.username ?? "Cliente",
                        style: GoogleFonts.inter(
                            fontSize: 14.sp, fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                  8.verticalSpace,
                ],
              ),
            */
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 80.w,
                  child: Text(
                    'Fecha',
                    style: GoogleFonts.inter(
                        fontSize: 14.sp, fontWeight: FontWeight.w500),
                  ),
                ),
                // Text(
                //   TimeService.dateFormatYMDHm(orderData?.createdAt),
                //   style: GoogleFonts.inter(
                //       fontSize: 12.sp, fontWeight: FontWeight.w400),
                // )
              ],
            ),
            10.verticalSpace,
            Divider(
              thickness: 2.r,
            ),
            ListView.builder(
                padding: EdgeInsets.only(top: 16.r),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: bagData?.bagProducts?.length ?? 0,
                itemBuilder: (context, index) {
                  final product = bagData?.bagProducts?[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 16.r),
                    child: _productItem(product),
                  );
                }),
            Row(
              children: List.generate(
                  20,
                  (index) => Expanded(
                        child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 4.r),
                            height: 2,
                            color: Style.iconButtonBack),
                      )),
            ),
            20.verticalSpace,
            Row(
              children: [
                Text(
                  'Precio total',
                  style: GoogleFonts.inter(
                      fontSize: 14.sp, fontWeight: FontWeight.w700),
                ),
                const Spacer(),
                Text(
                  AppHelpers.numberFormat(subTotal),
                  style: GoogleFonts.inter(
                      fontSize: 14.sp, fontWeight: FontWeight.w400),
                )
              ],
            ),
            10.verticalSpace,
            Row(
              children: List.generate(
                  20,
                  (index) => Expanded(
                        child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 4.r),
                            height: 2,
                            color: Style.iconButtonBack),
                      )),
            ),
            26.verticalSpace,
            Text(
              'Gracias!!'.toUpperCase(),
              style: GoogleFonts.inter(
                  fontSize: 16.sp, fontWeight: FontWeight.w500),
            ),
            24.verticalSpace,
            LoginButton(
                title: 'Imprimir',
                onPressed: () async {
                  if (context.mounted) {
                    AppHelpers.showAlertDialog(
                        context: context,
                        child: PrintPage(orderData: orderData));
                  }
                }),
            12.verticalSpace,
            LoginButton(
                title: 'Salir',
                bgColor: Style.greyColor,
                onPressed: () async {
                  context.router.popUntilRoot();
                  context.replaceRoute(const MainRoute());
                }),
          ],
        ),
      ),
    );
  }

  _productItem(BagProductData? product) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${product?.productId ?? ""} x ${product?.quantity ?? ""}",
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                        color: Style.black),
                  ),
                  6.verticalSpace,
                ],
              ),
            ),
          ],
        ),
        10.verticalSpace,
        Row(
          children: List.generate(
              20,
              (index) => Expanded(
                    child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 4.r),
                        height: 2,
                        color: Style.iconButtonBack),
                  )),
        )
      ],
    );
  }

  _priceItem({
    required String title,
    required num? price,
    String? symbol,
    bool isDiscount = false,
  }) {
    return (price ?? 0) != 0
        ? Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
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
