import 'package:flutter/material.dart';
import 'app_style.dart';
import 'input_decoration_theme.dart';
import 'checkbox_theme_data.dart';
import 'button_theme.dart';
import 'theme_data.dart';

ThemeData lightTheme() {
  return ThemeData(
    useMaterial3: false,
    brightness: Brightness.light,
    primaryColor: Style.primary,
    scaffoldBackgroundColor: Style.bg,
    iconTheme: const IconThemeData(color: Style.black),
    textTheme: TextTheme(bodyMedium: Style.interNormal()),
    elevatedButtonTheme: elevatedButtonThemeData,
    outlinedButtonTheme: outlinedButtonTheme(),
    // textButtonTheme: textButtonThemeData,
    inputDecorationTheme: lightInputDecorationTheme,
    checkboxTheme: checkboxThemeData.copyWith(
      side: const BorderSide(color: Style.black),
    ),
    textSelectionTheme:
        const TextSelectionThemeData(cursorColor: Style.primary),
    appBarTheme: appBarLightTheme,
    floatingActionButtonTheme: floatingActionButtonThemeData,
    dialogTheme: const DialogTheme(
      backgroundColor: Style.white,
      shadowColor: Style.black,
    ),
    scrollbarTheme: scrollbarThemeData,
    // dataTableTheme: dataTableLightThemeData,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: Style.primary,
      primary: Style.primary,
      error: Style.red,
    ),
  );
}
