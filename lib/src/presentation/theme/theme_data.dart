import 'package:kibbi_kiosk/src/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_style.dart';

AppBarTheme appBarLightTheme = AppBarTheme(
  backgroundColor: Style.white,
  elevation: 1,
  iconTheme: const IconThemeData(color: Style.black),
  titleTextStyle: Style.interNormal(size: 16),
);
FloatingActionButtonThemeData floatingActionButtonThemeData =
    const FloatingActionButtonThemeData(
        backgroundColor: Style.primary, shape: CircleBorder());

ScrollbarThemeData scrollbarThemeData = ScrollbarThemeData(
  trackColor: WidgetStateProperty.all(Style.primary),
);

DataTableThemeData dataTableLightThemeData = DataTableThemeData(
  columnSpacing: 24,
  headingRowColor: WidgetStateProperty.all(Style.transparent),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(AppConstants.radius.r),
    border: Border.all(color: Style.black),
  ),
  dataTextStyle: Style.interNormal(size: 12),
);
