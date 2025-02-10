import 'package:kiosk/src/core/constants/constants.dart';
import 'package:kiosk/src/presentation/theme/theme.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MarketTwoShimmer extends StatelessWidget {
  final bool isSimpleShop;
  final bool isShop;
  final int index;

  const MarketTwoShimmer(
      {super.key,
      this.isSimpleShop = false,
      required this.index,
       this.isShop = false})
     ;

  @override
  Widget build(BuildContext context) {
    return isShop ? Container(
      margin: EdgeInsets.only( right: 8.r),
      width: 134.w,
      height: 130.h,
      decoration: BoxDecoration(
          color: Style.shimmerBase,
          borderRadius: BorderRadius.circular(AppConstants.radius.r)),
    ) : Container(
      width: 268.w,
      height: 260.h,
      decoration: BoxDecoration(
          color: Style.shimmerBase,
          borderRadius: BorderRadius.circular(AppConstants.radius.r)),
    );
  }
}
