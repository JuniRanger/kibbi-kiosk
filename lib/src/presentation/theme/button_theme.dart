import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

import 'app_style.dart';

ElevatedButtonThemeData elevatedButtonThemeData = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    padding: REdgeInsets.all(16),
    backgroundColor: Style.primary,
    minimumSize: const Size(double.infinity, 32),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
    foregroundColor: Style.white
  ),
);

TextButtonThemeData textButtonThemeData = TextButtonThemeData(
  style: ButtonStyle(
    foregroundColor: WidgetStateProperty.all(Style.success),
    textStyle: WidgetStateProperty.all(Style.interSemi(size: 16)),
  ),
);

OutlinedButtonThemeData outlinedButtonTheme(
    {Color borderColor = Style.primary}) {
  return OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: Style.success,
      padding: REdgeInsets.all(24),
      minimumSize: const Size(double.infinity, 32),
      side: BorderSide(width: 1.5, color: borderColor),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
    ),
  );
}
