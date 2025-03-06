import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kibbi_kiosk/src/presentation/theme/theme.dart';

class SectionsItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final bool isDivider;
  final bool isActive;

  const SectionsItem(
      {super.key,
      required this.title,
      required this.icon,
      required this.onTap,
      this.isActive = false,
      this.isDivider = true});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 12),
        color: Style.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Added
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  size: 24.r,
                  color: isActive ? Style.primary : Style.black,
                ),
                16.horizontalSpace,
                Text(
                  title,
                  style: Style.interRegular(
                      size: 16.sp,
                      color: isActive ? Style.primary : Style.black),
                ),
              ],
            ),
            if (isDivider) 12.verticalSpace,
            if (isDivider) const Divider(color: Style.hint),
          ],
        ),
      ),
    );
  }
}
