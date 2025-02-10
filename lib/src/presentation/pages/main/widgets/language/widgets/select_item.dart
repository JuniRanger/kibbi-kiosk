import 'package:kiosk/src/presentation/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../components/buttons/button_effect_animation.dart';

class SelectItem extends StatelessWidget {
  final VoidCallback onTap;
  final bool isActive;
  final String title;

  const SelectItem({
    super.key,
    required this.onTap,
    required this.isActive,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonEffectAnimation(
      onTap: onTap,
      child: Column(
        children: [
          8.verticalSpace,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 18.r,
                height: 18.r,
                margin: EdgeInsets.only(right: 10.r),
                decoration: BoxDecoration(
                  color: isActive ? Style.primary : Style.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: !isActive ? Style.hint : Style.primary),
                ),
                child: Icon(
                  FlutterRemix.check_line,
                  color: Style.white,
                  size: 16.r,
                ),
              ),
              4.horizontalSpace,
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Style.black,
                ),
              ),
            ],
          ),
          12.verticalSpace,
          const Divider(color: Style.hint)
        ],
      ),
    );
  }
}
