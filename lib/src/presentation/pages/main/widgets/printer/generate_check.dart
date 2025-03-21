// ignore_for_file: depend_on_referenced_packages

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kibbi_kiosk/src/core/routes/app_router.dart';
import 'package:kibbi_kiosk/src/core/utils/app_helpers.dart';
import 'package:kibbi_kiosk/src/models/response/order_response.dart';
import 'package:kibbi_kiosk/src/presentation/components/components.dart';
import 'package:kibbi_kiosk/src/presentation/theme/app_style.dart';

import 'print_page.dart';

class GenerateCheckPage extends StatelessWidget {
  final OrderResponse orderResponse;

  const GenerateCheckPage({super.key, required this.orderResponse});

  @override
  Widget build(BuildContext context) {
    final order = orderResponse.order;

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
              "Orden #${order.numOrder}",
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
            _infoRow('Restaurante', order.restaurantName),
            _infoRow('Cliente', order.customerName),
            _infoRow(
                'Fecha', DateFormat.yMMMd().add_jm().format(order.createdAt)),
            _infoRow('Método de pago', order.paymentMethod),
            _infoRow('Moneda', order.currency),
            _infoRow('Tipo de orden', order.orderType),
            if (order.notes != null && order.notes!.isNotEmpty)
              _infoRow('Notas', order.notes!),
            10.verticalSpace,
            Divider(thickness: 2.r),
            ListView.builder(
              padding: EdgeInsets.only(top: 16.r),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: order.products.length,
              itemBuilder: (context, index) {
                final product = order.products[index];
                return Padding(
                  padding: EdgeInsets.only(bottom: 16.r),
                  child: _productItem(product),
                );
              },
            ),
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
            _priceRow('Venta total', order.totalSale),
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
                titleColor: Style.white,
                onPressed: () async {
                  if (context.mounted) {
                    AppHelpers.showAlertDialog(
                        context: context,
                        child: PrintPage(orderData: null)); // Adjust as needed
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

  Widget _infoRow(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.r),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
                fontSize: 14.sp, fontWeight: FontWeight.w500),
          ),
          Text(
            value,
            style: GoogleFonts.inter(
                fontSize: 14.sp, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }

  Widget _productItem(Product product) {
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
                    "${product.name} x ${product.quantity}",
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                        color: Style.black),
                  ),
                  6.verticalSpace,
                  Text(
                    "Precio unitario: ${AppHelpers.numberFormat(product.salePrice)}",
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w400,
                        fontSize: 12.sp,
                        color: Style.unselectedTab),
                  ),
                ],
              ),
            ),
            Text(
              AppHelpers.numberFormat(product.salePrice * product.quantity),
              style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                  color: Style.black),
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

  Widget _priceRow(String title, num value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
              fontSize: 14.sp, fontWeight: FontWeight.w700),
        ),
        Text(
          AppHelpers.numberFormat(value),
          style: GoogleFonts.inter(
              fontSize: 14.sp, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
