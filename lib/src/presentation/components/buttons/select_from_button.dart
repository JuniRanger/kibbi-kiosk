import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/theme.dart';

class SelectFromButton extends StatelessWidget {
  final IconData? iconData;
  final String title;

  const SelectFromButton({
    super.key,
    this.iconData,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.r,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Style.unselectedBottomBarBack,
          width: 1.r,
        ),
      ),
      alignment: Alignment.center,
      padding: REdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                iconData != null ? Icon(
                  iconData,
                  size: 20.r,
                  color: Style.black,
                ) : const SizedBox.shrink(),
                8.horizontalSpace,
                Expanded(
                  child: Text(
                    title,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                      color: Style.black,
                      letterSpacing: -14 * 0.02,
                    ),
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            FlutterRemix.arrow_down_s_line,
            size: 20.r,
            color: Style.black,
          ),
        ],
      ),
    );
  }
}
