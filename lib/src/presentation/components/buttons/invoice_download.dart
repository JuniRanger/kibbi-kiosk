import 'package:kibbi_kiosk/generated/assets.dart';
import 'package:kibbi_kiosk/src/models/data/order_body_data.dart';
import 'package:kibbi_kiosk/src/models/data/order_data.dart';
import 'package:kibbi_kiosk/src/presentation/pages/main/widgets/printer/generate_check.dart';
import 'package:kibbi_kiosk/src/presentation/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/constants.dart';
import '../../../core/utils/app_helpers.dart';
import 'animation_button_effect.dart';

class InvoiceDownload extends StatelessWidget {
  final OrderBodyData? orderData;

  const InvoiceDownload({super.key, required this.orderData});

  @override
  Widget build(BuildContext context) {
    return AnimationButtonEffect(
      child: GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) {
                return LayoutBuilder(builder: (context, constraints) {
                  return SimpleDialog(
                    title: SizedBox(
                      height: constraints.maxHeight * 0.7,
                      width: 300.r,
                      child: GenerateCheckPage(orderData: orderData),
                    ),
                  );
                });
              });
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.r, horizontal: 18.r),
          decoration: BoxDecoration(
            color: Style.invoiceColor,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                Assets.svgFilePdf,
                colorFilter:
                    const ColorFilter.mode(Style.white, BlendMode.srcIn),
                height: 18.r,
                width: 18.r,
              ),
              8.horizontalSpace,
              Text(
                'Descargar factura',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  letterSpacing: 0,
                  color: Style.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
