import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components.dart';
import '../../../models/data/product_data.dart';

class ProductGridItem extends StatelessWidget {
  final ProductData product;
  final Function() onTap;

  const ProductGridItem({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10.r),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: Colors.white,
        ),
        constraints: BoxConstraints(
          maxWidth: 227.r,
          maxHeight: 246.r,
        ),
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: CommonImage(
                url: product.img,
              ),
            ),
            16.verticalSpace,
            Text(
              '${product.title}', // Usamos directamente el título del producto en español
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                letterSpacing: -14 * 0.02,
                color: Colors.black,
              ),
            ),
            6.verticalSpace,
            Text(
              'Disponible', // Texto en español para disponibilidad
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                letterSpacing: -14 * 0.02,
                color: Colors.green, // Indicamos que está disponible
              ),
            ),
            8.verticalSpace,
            Row(
              children: [
                Text(
                  '${product.totalPrice}', // Usamos el precio total directamente
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    letterSpacing: -14 * 0.02,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
