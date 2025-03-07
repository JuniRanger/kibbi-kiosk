import 'package:kibbi_kiosk/src/presentation/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/data/product_data.dart';

class ProductListItem extends StatelessWidget {
  final ProductData product;
  final Function() onTap;
  final bool isSelected;

  const ProductListItem({
    super.key,
    required this.product,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Style.white,
          borderRadius: BorderRadius.circular(10.r),
        ),
        padding: REdgeInsets.all(18),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 18.r,
                height: 18.r,
                margin: EdgeInsets.only(right: 10.r),
                decoration: BoxDecoration(
                  color: isSelected ? Style.primary : Style.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: !isSelected ? Style.hint : Style.primary),
                ),
                child: Icon(
                  FlutterRemix.check_line,
                  color: Style.white,
                  size: 16.r,
                ),
              ),
              16.horizontalSpace,
              Expanded(
                child: Text(
                  product.name ?? '',
                  style: GoogleFonts.inter(
                    fontSize: 15.sp,
                    color: Style.black,
                    letterSpacing: -0.3,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
