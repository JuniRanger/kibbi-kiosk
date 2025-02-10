import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import 'package:kiosk/src/presentation/theme/theme.dart';

class LineShimmer extends StatelessWidget {
  final bool? isActiveLine;
  const LineShimmer({super.key, this.isActiveLine});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        enabled: false,
        baseColor: Style.arrowRight,
        highlightColor: Style.icon,
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Row(
                children: [
                  8.verticalSpace,
                  Container(
                    height: 56.r,
                    width: 56.r,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Style.icon),
                  ),
                  6.horizontalSpace,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 6.h,
                            width: 100.w,
                            color: Style.icon,
                          ),
                          15.horizontalSpace,
                        ],
                      ),
                      6.verticalSpace,
                      Container(
                        height: 6.h,
                        width: 300.w,
                        color: Style.icon,
                      ),
                      8.verticalSpace,
                      isActiveLine ?? false
                          ? Container(
                              height: 6.h,
                              width: 50.w,
                              color: Style.icon,
                            )
                          : const SizedBox.shrink()
                    ],
                  ),
                ],
              ),
            );
          },
        ));
  }
}
