import 'package:kiosk/src/core/constants/constants.dart';
import 'package:kiosk/src/core/utils/app_helpers.dart';
import 'package:kiosk/src/models/data/bag_data.dart';
import 'package:kiosk/src/models/data/bag_shop_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/theme.dart';

class ShopBagItem extends StatelessWidget {
  final BagShopData bagShopData;
  final Function(BagProductData) onDeleteProduct;
  final Function(BagProductData) onDecreaseProduct;
  final Function(BagProductData) onIncreaseProduct;

  const ShopBagItem({
    super.key,
    required this.bagShopData,
    required this.onDeleteProduct,
    required this.onDecreaseProduct,
    required this.onIncreaseProduct,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        21.verticalSpace,
        Padding(
          padding: REdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${bagShopData.shopData.translation?.title}',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                  color: Style.black,
                  letterSpacing: -0.4,
                ),
              ),
              Text(
                '${bagShopData.bagProducts.length} ${AppHelpers.getTranslation(
                    TrKeys.products)}',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                  color: Style.black,
                  letterSpacing: -0.4,
                ),
              ),
            ],
          ),
        ),
        22.verticalSpace,
        Divider(
          height: 1.r,
          thickness: 1.r,
          color: Style.black.withOpacity(0.1),
        ),

      ],
    );
  }
}
