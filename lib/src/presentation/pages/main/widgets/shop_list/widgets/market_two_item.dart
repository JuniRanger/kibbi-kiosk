import 'package:kiosk/src/core/constants/constants.dart';
import 'package:kiosk/src/core/utils/utils.dart';
import 'package:kiosk/src/models/models.dart';
import 'package:kiosk/src/presentation/components/badge_item.dart';
import 'package:kiosk/src/presentation/components/common_image.dart';
import 'package:kiosk/src/presentation/theme/app_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'two_bonus_discount.dart';

class MarketTwoItem extends StatelessWidget {
  final RestaurantData shop;
  final VoidCallback onTap;
  final bool isSimpleShop;
  final bool isShop;
  final bool isFilter;

  const MarketTwoItem({
    super.key,
    this.isSimpleShop = false,
    required this.shop,
    this.isShop = false,
    this.isFilter = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: isShop
          ? _shopItem()
          : Container(
              decoration: BoxDecoration(
                color: Style.white,
                borderRadius: BorderRadius.circular(AppConstants.radius.r),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 150.r,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(AppConstants.radius.r),
                              topRight: Radius.circular(AppConstants.radius.r)),
                          child: CommonImage(
                            url: shop.backgroundImg ?? '',
                            height: isSimpleShop ? 136.h : 150.h,
                            width: double.infinity,
                            radius: 0,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10.h,
                        right: 0,
                        left: 0,
                        child: Padding(
                          padding: REdgeInsets.only(left: 8),
                          child: TwoBonusDiscountPopular(
                              isPopular: shop.isRecommend ?? false,
                              bonus: shop.bonus,
                              isDiscount: shop.isDiscount ?? false),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          padding: REdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: ShapeDecoration(
                            color: Style.white.withOpacity(0.6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(100.r),
                                bottomLeft: Radius.circular(100.r),
                                topRight: Radius.circular(100.r),
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                "assets/svg/delivery_time.svg",
                                height: 24.r,
                              ),
                              4.horizontalSpace,
                              Text(
                                "",
                                style: Style.interNormal(
                                  size: 12,
                                  color: Style.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: REdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      shop.translation?.title ?? "",
                                      style: Style.interSemi(
                                        size: 16,
                                        color: Style.black,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  if (shop.verify ?? false)
                                    Padding(
                                      padding: EdgeInsets.only(left: 4.r),
                                      child: const BadgeItem(),
                                    ),
                                ],
                              ),
                            ),
                            10.horizontalSpace,
                            SvgPicture.asset("assets/svg/star.svg"),
                            4.horizontalSpace,
                            Text(
                              (shop.avgRate ?? ""),
                              style: Style.interNormal(
                                size: 12.sp,
                                color: Style.black,
                              ),
                            ),
                          ],
                        ),
                        6.verticalSpace,
                        Text(
                          shop.bonus != null
                              ? ((shop.bonus?.type ?? "sum") == "sum")
                                  ? "${AppHelpers.getTranslation(TrKeys.under)} ${AppHelpers.numberFormat(shop.bonus?.value)} + ${shop.bonus?.bonusStock?.product?.translation?.title ?? ""}"
                                  : "${AppHelpers.getTranslation(TrKeys.under)} ${shop.bonus?.value ?? 0} + ${shop.bonus?.bonusStock?.product?.translation?.title ?? ""}"
                              : shop.translation?.description ?? "",
                          style: Style.interNormal(
                            size: 14,
                            color: Style.black,
                          ),
                          maxLines: isSimpleShop ? 2 : 1,
                        ),
                        8.verticalSpace,
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _shopItem() {
    return Container(
      padding: REdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Style.bgGrey,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          24.verticalSpace,
          CommonImage(
            url: shop.logoImg ?? "",
            height: 80.r,
            width: 80.r,
            radius: 40.r,
          ),
          const Spacer(),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  (shop.translation?.title?.length ?? 0) > 12
                      ? "${shop.translation?.title?.substring(0, 12) ?? " "}.."
                      : shop.translation?.title ?? "",
                  style: Style.interSemi(
                    size: 14,
                    color: Style.black,
                  ),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
                if (shop.verify ?? false)
                  Padding(
                    padding: EdgeInsets.only(left: 4.r),
                    child: const BadgeItem(),
                  ),
              ],
            ),
          ),
          6.verticalSpace,
          Text(
            "",
            style: Style.interSemi(
              size: 12,
              color: Style.textGrey,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          28.verticalSpace,
        ],
      ),
    );
  }
}
