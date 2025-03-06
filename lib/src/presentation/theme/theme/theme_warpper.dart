import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'theme.dart';

class ThemeWrapper extends StatelessWidget {
  final Function(
    CustomColorSet colors,
    AppTheme controller,
  ) builder;

  const ThemeWrapper({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppTheme>(builder: (context, theme, _) {
      return builder(theme.colors, theme);
    });
  }
}
