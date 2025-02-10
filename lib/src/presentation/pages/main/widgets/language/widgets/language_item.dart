import 'package:kiosk/src/core/utils/local_storage.dart';
import 'package:kiosk/src/models/models.dart';
import 'package:kiosk/src/presentation/components/components.dart';
import 'package:kiosk/src/presentation/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class LanguageItem extends StatelessWidget {
  final VoidCallback onTap;
  final LanguageData lang;

  const LanguageItem({super.key, required this.onTap, required this.lang});

  @override
  Widget build(BuildContext context) {
    final active = LocalStorage.getLanguage()?.locale == lang.locale;
    return ButtonEffectAnimation(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: active
              ? Style.primary.withOpacity(0.3)
              : Style.dontHaveAccBtnBack,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 5.r,
              height: 64.r,
              decoration: BoxDecoration(
                color: active ? Style.primary : Style.transparent,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(14.r),
                  bottomLeft: Radius.circular(14.r),
                ),
              ),
            ),
            8.horizontalSpace,
            CommonImage(
              width: 52.r,
              height: 48.r,
              radius: 0,
              fit: BoxFit.contain,
              url: lang.img,
            ),
            12.horizontalSpace,
            Text(
              lang.title ?? '',
              style: GoogleFonts.inter(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: Style.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
