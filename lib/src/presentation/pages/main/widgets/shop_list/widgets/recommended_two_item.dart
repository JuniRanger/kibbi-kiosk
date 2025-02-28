import 'package:kiosk/src/core/constants/constants.dart';
import 'package:kiosk/src/core/utils/utils.dart';
import 'package:kiosk/src/models/models.dart';
import 'package:kiosk/src/presentation/components/components.dart';
import 'package:kiosk/src/presentation/theme/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecommendedTwoItem extends StatelessWidget {
  final RestaurantData shop;

  const RecommendedTwoItem({
    super.key,
    required this.shop,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // context.pushRoute(ShopRoute(shopId: shop.id ?? 0));
      },
      child: Container(
        margin: EdgeInsets.only(left: 0, right: 9.r),
        width: MediaQuery.sizeOf(context).width / 3,
        height: 190.h,
        decoration: BoxDecoration(
            color: Style.recommendBg,
            borderRadius: BorderRadius.all(Radius.circular(10.r))),
        child: Stack(
          children: [
            CommonImage(
                url: shop.backgroundImg ?? "",
                width: MediaQuery.sizeOf(context).width / 2,
                height: 190.h,
                radius: 10.r),
            Padding(
              padding: EdgeInsets.all(12.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      // ShopAvatar(
                      //   shopImage: shop.logoImg ?? "",
                      //   size: 36,
                      //   padding: 4,
                      // ),
                      8.horizontalSpace,
                      Expanded(
                        child: Text(
                          shop.translation?.title ?? "",
                          style: Style.interNormal(
                            size: 12,
                            color: Style.black,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 4.h, horizontal: 12.w),
                    decoration: BoxDecoration(
                        color: Style.black.withOpacity(0.8),
                        borderRadius: BorderRadius.all(Radius.circular(100.r))),
                    child: Text(
                      "${shop.productsCount ?? 0}  ${AppHelpers.getTranslation(TrKeys.products)}",
                      style: Style.interNormal(
                        size: 12,
                        color: Style.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
