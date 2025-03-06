import 'package:kibbi_kiosk/app_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

import 'app_style.dart';

InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
  focusColor: Style.primary,
  errorStyle: Style.interRegular(color: Style.red, size: 12),
  contentPadding: REdgeInsets.symmetric(vertical: 20, horizontal: 12),
  hintStyle: Style.interRegular(color: Style.textGrey, size: 14),
  labelStyle: Style.interRegular(color: Style.textGrey, size: 16),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(AppConstants.radius.r),
    borderSide: const BorderSide(color: Style.border),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(AppConstants.radius.r),
    borderSide: const BorderSide(color: Style.border),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(AppConstants.radius.r),
    borderSide: const BorderSide(color: Style.border),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(AppConstants.radius.r),
    borderSide: const BorderSide(color: Style.red),
  ),
);

OutlineInputBorder secondaryOutlineInputBorder(BuildContext context) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8.r)),
    borderSide: BorderSide(
      color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.15),
    ),
  );
}
