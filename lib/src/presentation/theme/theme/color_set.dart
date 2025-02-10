part of 'theme.dart';

class CustomColorSet {
  final Color primary;

  final Color white;

  final Color textHint;

  final Color textBlack;

  final Color textWhite;

  final Color icon;

  final Color success;

  final Color error;

  final Color transparent;

  final Color backgroundColor;

  final Color socialButtonColor;

  final Color newBoxColor;

  final Color bottomBarColor;

  final Color categoryColor;

  final Color categoryTitleColor;

  CustomColorSet._({
    required this.textHint,
    required this.textBlack,
    required this.textWhite,
    required this.primary,
    required this.white,
    required this.icon,
    required this.success,
    required this.error,
    required this.transparent,
    required this.backgroundColor,
    required this.socialButtonColor,
    required this.bottomBarColor,
    required this.categoryColor,
    required this.categoryTitleColor,
    required this.newBoxColor,
  });

  factory CustomColorSet._create(CustomThemeMode mode) {
    final isLight = mode.isLight;

    final textHint = isLight ? Style.hint : Style.white;

    final textBlack = isLight ? Style.black : Style.white;

    final textWhite = isLight ? Style.white : Style.black;

    final categoryColor = isLight ? Style.black : Style.iconButtonBack;

    final categoryTitleColor = isLight ? Style.black : Style.white;

    const primary = Style.primary;

    const white = Style.white;

    const icon = Style.icon;

    final backgroundColor = isLight ? Style.mainBack : Style.iconButtonBack;

    final newBoxColor = isLight ? Style.icon : Style.iconButtonBack;

    const success = Style.primary;

    const error = Style.red;

    const transparent = Style.transparent;

    final socialButtonColor =
        isLight ? Style.icon : Style.iconButtonBack;

    final bottomBarColor = isLight
        ? Style.icon.withOpacity(0.8)
        : Style.iconButtonBack;

    return CustomColorSet._(
      categoryColor: categoryColor,
      textHint: textHint,
      textBlack: textBlack,
      textWhite: textWhite,
      primary: primary,
      white: white,
      icon: icon,
      backgroundColor: backgroundColor,
      success: success,
      error: error,
      transparent: transparent,
      socialButtonColor: socialButtonColor,
      bottomBarColor: bottomBarColor,
      categoryTitleColor: categoryTitleColor,
      newBoxColor: newBoxColor,
    );
  }

  static CustomColorSet createOrUpdate(CustomThemeMode mode) {
    return CustomColorSet._create(mode);
  }
}
