import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:kiosk/src/presentation/theme/theme.dart';

class CircleChoosingButton extends StatelessWidget {
  final bool isActive;
  const CircleChoosingButton({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 18.h,
      width: 18.w,
      decoration: BoxDecoration(
          color: isActive
              ? Style.primary
              : Style.transparent,
          shape: BoxShape.circle,
          border: Border.all(
              color: !isActive
                  ? Style.icon
                  : Style.transparent,
              width: 2)),
      child: Center(
        child: Container(
          height: 6.h,
          width: 6.w,
          decoration: BoxDecoration(
              color:isActive
                  ? Style.locationAddress
                  : Style.transparent,
              shape: BoxShape.circle),
        ),
      ),
    );
  }
}
