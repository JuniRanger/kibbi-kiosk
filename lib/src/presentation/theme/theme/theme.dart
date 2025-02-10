import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../app_style.dart';

part 'color_set.dart';

part 'theme_preference.dart';

class AppTheme with ChangeNotifier {
  final _ThemePreference _preference;
  CustomColorSet _colorSet;
  CustomThemeMode _mode;

  CustomColorSet get colors => _colorSet;

  CustomThemeMode get mode => _mode;

  bool get isDark => _mode.isDark;


  AppTheme._(
    this._colorSet,
    this._preference,
    this._mode,
  );

  static Future<AppTheme> get create async {
    final themePreference = await _ThemePreference.create;
    final mode = themePreference.getMode();
    final colorSet = CustomColorSet.createOrUpdate(mode);

    return AppTheme._(
      colorSet,
      themePreference,
      mode,
    );
  }

  Future<void> setLight() async {
    await _update(CustomThemeMode.light);
  }

  Future<void> setDark() async {
    await _update(CustomThemeMode.dark);
  }

  Future<void> clean() async {
    await _preference.clean();
  }

  Future toggle() async {
    if (_mode.isLight) {
      return await setDark();
    }
    return await setLight();
  }

  Future<void> _update(CustomThemeMode mode) async {
    _colorSet = CustomColorSet.createOrUpdate(mode);
    _mode = mode;
    notifyListeners();
    await _preference.setMode(mode);
  }
}
