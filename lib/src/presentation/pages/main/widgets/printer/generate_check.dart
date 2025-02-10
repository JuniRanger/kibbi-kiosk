// ignore_for_file: depend_on_referenced_packages

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kiosk/src/core/constants/constants.dart';
import 'package:kiosk/src/core/routes/app_router.dart';
import 'package:kiosk/src/core/utils/app_helpers.dart';
import 'package:kiosk/src/core/utils/time_service.dart';
import 'package:kiosk/src/core/utils/utils.dart';
import 'package:kiosk/src/models/data/addons_data.dart';
import 'package:kiosk/src/models/data/order_data.dart';
import 'package:kiosk/src/presentation/components/components.dart';
import 'package:kiosk/src/presentation/theme/app_style.dart';

import 'print_page.dart';

class GenerateCheckPage extends StatefulWidget {
  final OrderData? orderData;

  const GenerateCheckPage({super.key, required this.orderData});

  @override
  State<GenerateCheckPage> createState() => _GenerateCheckPageState();
}

class _GenerateCheckPageState extends State<GenerateCheckPage> {
  @override
  Widget build(BuildContext context) {
    num subTotal = 0;
    subTotal = ((widget.orderData?.totalPrice ?? 0) -
        (widget.orderData?.tax ?? 0) -
        (widget.orderData?.serviceFee ?? 0) +
        (widget.orderData?.totalDiscount ?? 0));
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
              AppHelpers.getTranslation(TrKeys.orderSummary),
              style: GoogleFonts.inter(
                  fontSize: 22.sp, fontWeight: FontWeight.w600),
            ),
            8.verticalSpace,
            Text(
              "${AppHelpers.getTranslation(TrKeys.order)} #${AppHelpers.getTranslation(TrKeys.id)}${widget.orderData?.id}",
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
                    AppHelpers.getTranslation(TrKeys.shopName),
                    style: GoogleFonts.inter(
                        fontSize: 14.sp, fontWeight: FontWeight.w500),
                  ),
                ),
                Text(
                  widget.orderData?.shop?.translation?.title ?? "",
                  style: GoogleFonts.inter(
                      fontSize: 14.sp, fontWeight: FontWeight.w400),
                )
              ],
            ),
            8.verticalSpace,
            if (widget.orderData?.username?.isNotEmpty ?? false)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 100.w,
                        child: Text(
                          AppHelpers.getTranslation(TrKeys.client),
                          style: GoogleFonts.inter(
                              fontSize: 14.sp, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Text(
                        widget.orderData?.username ?? "",
                        style: GoogleFonts.inter(
                            fontSize: 14.sp, fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                  8.verticalSpace,
                ],
              ),
            if (widget.orderData?.table?.name?.isNotEmpty ?? false)
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 100.w,
                        child: Text(
                          AppHelpers.getTranslation(TrKeys.table),
                          style: GoogleFonts.inter(
                              fontSize: 14.sp, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Text(
                        widget.orderData?.table?.name ?? "",
                        style: GoogleFonts.inter(
                            fontSize: 14.sp, fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                  8.verticalSpace,
                ],
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 80.w,
                  child: Text(
                    AppHelpers.getTranslation(TrKeys.date),
                    style: GoogleFonts.inter(
                        fontSize: 14.sp, fontWeight: FontWeight.w500),
                  ),
                ),
                Text(
                  TimeService.dateFormatYMDHm(widget.orderData?.createdAt),
                  style: GoogleFonts.inter(
                      fontSize: 12.sp, fontWeight: FontWeight.w400),
                )
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
                itemCount: widget.orderData?.details?.length ?? 0,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 16.r),
                    child: _productItem(
                        orderDetail: widget.orderData?.details?[index]),
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
            _priceItem(
              title: TrKeys.subtotal,
              price: subTotal,
            ),
            _priceItem(
              title: TrKeys.tax,
              price: widget.orderData?.tax,
            ),
            _priceItem(
              title: TrKeys.serviceFee,
              price: widget.orderData?.serviceFee,
            ),
            _priceItem(
              title: TrKeys.discount,
              price: widget.orderData?.totalDiscount,
              isDiscount: true,
            ),
            // _priceItem(
            //   title: TrKeys.promoCode,
            //   price: widget.orderData?.couponPrice,
            //   isDiscount: true,
            // ),
            Row(
              children: [
                Text(
                  AppHelpers.getTranslation(TrKeys.totalPrice),
                  style: GoogleFonts.inter(
                      fontSize: 14.sp, fontWeight: FontWeight.w700),
                ),
                const Spacer(),
                Text(
                  AppHelpers.numberFormat(widget.orderData?.totalPrice),
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
              AppHelpers.getTranslation(TrKeys.thankYou).toUpperCase(),
              style: GoogleFonts.inter(
                  fontSize: 16.sp, fontWeight: FontWeight.w500),
            ),
            24.verticalSpace,
            LoginButton(
                title: AppHelpers.getTranslation(TrKeys.print),
                onPressed: () async {
                  if (context.mounted) {
                    AppHelpers.showAlertDialog(
                        context: context,
                        child: PrintPage(orderData: widget.orderData));
                  }
                }),
            12.verticalSpace,
            LoginButton(
                title: AppHelpers.getTranslation(TrKeys.noNeedToPrint),
                bgColor: Style.greyColor,
                onPressed: () async {
                  context.router.popUntilRoot();
                  context.replaceRoute(const LanguagesRoute());
                }),
          ],
        ),
      ),
    );
  }

  _productItem({required OrderDetail? orderDetail}) {
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
                    "${orderDetail?.stock?.product?.translation?.title ?? ""} x ${orderDetail?.quantity ?? ""}",
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                        color: Style.black),
                  ),
                  6.verticalSpace,
                  for (Addons e in (orderDetail?.addons ?? []))
                    Text(
                      "${e.stocks?.product?.translation?.title ?? ""} ( ${NumberFormat.currency(
                        symbol: widget.orderData?.currency?.symbol ?? "",
                      ).format((e.price ?? 0) / (e.quantity ?? 1))} x ${(e.quantity ?? 1)} )",
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        color: Style.unselectedTab,
                      ),
                    ),
                ],
              ),
            ),
            Column(
              children: [
                Text(
                  AppHelpers.numberFormat(
                    orderDetail?.originPrice,
                    symbol: widget.orderData?.currency?.symbol,
                  ),
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                      decoration: (orderDetail?.discount ?? 0) != 0
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      color: Style.black),
                ),
                if ((orderDetail?.discount ?? 0) != 0)
                  Text(
                    AppHelpers.numberFormat(
                      orderDetail?.totalPrice,
                      symbol: widget.orderData?.currency?.symbol,
                    ),
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        color: Style.black),
                  ),
              ],
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
