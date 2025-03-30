import 'package:kibbi_kiosk/src/presentation/theme/theme.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'buttons/animation_button_effect.dart';

class LoginButton extends StatelessWidget {
  final String title;
  final bool isLoading;
  final bool isActive;
  final Color bgColor;
  final Color titleColor;
  final Function()? onPressed;

  const LoginButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.isLoading = false,
    this.isActive = true,
    this.bgColor = Style.primary,
    this.titleColor = Style.black, TextStyle? textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return AnimationButtonEffect(
      child: Material(
        borderRadius: BorderRadius.circular(8.r),
        color: isActive ? bgColor : Style.selectedItemsText,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(8.r),
          child: Container(
            height: 56.r,
            padding: EdgeInsets.symmetric(horizontal: 12.r),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                    color: bgColor == Style.transparent
                        ? Style.selectedItemsText
                        : Style.transparent)),
            alignment: Alignment.center,
            child: isLoading
                ? SizedBox(
                    height: 24.r,
                    width: 24.r,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.r,
                      color: Style.white,
                    ),
                  )
                : Text(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      color: isActive ? titleColor : Style.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
