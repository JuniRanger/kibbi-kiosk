import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Style {
  Style._();

  static const Color primary = Color(0xFFAB0831);
  static const Color bottomNavigationBarColor = Color(0xFF191919);
  static const Color enterOrderButton = Color(0xFFF4F8F7);
  static const Color tabBarBorderColor = Color(0xFFDEDFE1);
  static const Color orderButtonColor = Color(0xFF323232);
  static const Color dotColor = Color(0xFFBDBEC1);
  static const Color switchBg = Color(0xFFD3D3D3);
  static const Color white = Color(0xFFFFFFFF);
  static const Color transparent = Color(0x00FFFFFF);
  static const Color black = Color(0xFF232B2F);
  static const Color blackWithOpacity = Color(0x20232B2F);
  static const Color whiteWithOpacity = Color(0x90FFFFFF);
  static const Color dontHaveAccBtnBack = Color(0xFFF8F8F8);
  static const Color mainBack = Color(0xFFF4F4F4);
  static const Color border = Color(0xFFE6E6E6);
  static const Color textGrey = Color(0xFF898989);
  static const Color recommendBg = Color(0xFFE8C7B0);
  static const Color bannerBg = Color(0xFFF3DED4);
  static const Color bgGrey = Color(0xFFF4F5F8);
  static const Color outlineButtonBorder = Color(0xFFD2D2D7);
  static const Color bottomNavigationBack = Color.fromRGBO(0, 0, 0, 0.06);
  static const Color unselectedBottomItem = Color(0xFFA1A1A1);
  static const Color hint = Color(0xFFA7A7A7);
  static const Color unselectedTab = Color(0xFF929292);
  static const Color newStoreDataBorder = Color(0xDCDCDCC9);
  static const Color differBorderColor = Color(0xFFE0E0E0);
  static const Color starColor = Color(0xFFFFA826);
  static const Color doorColor = Color(0xFFFFC636);
  static const Color dragElement = Color(0xFFC4C5C7);
  static const Color addProductSearchedToBasket = Color.fromRGBO(0, 0, 0, 0.62);
  static const Color rate = Color(0xFFFFB800);
  static const Color red = Color(0xFFFF3D00);
  static const Color redBg = Color(0xFFFFF2EE);
  static const Color blue = Color(0xFF03758E);
  static const Color blueBonus = Color(0xFF0D5FFF);
  static const Color divider = Color.fromRGBO(0, 0, 0, 0.04);
  static const Color reviewText = Color(0xFF88887E);
  static const Color notificationTime = Color(0xFF8B8B8B);
  static const Color separatorDot = Color(0xFFD9D9D9);
  static Color shimmerBase = Colors.grey.shade300;
  static Color shimmerHighlight = Colors.grey.shade100;
  static const Color locationAddress = Color(0xFF343434);
  static const Color selectedItemsText = Color(0xFFA0A09C);
  static const Color iconButtonBack = Color(0xFFE9E9E6);
  static const Color unselectedBottomBarBack = Color(0xFFEFEFEF);
  static const Color shadow = Color(0x3FD8D8D8);
  static const Color shadowBottom = Color(0x33000000);
  static const success = Color(0xff31D0AA);
  

  static const Color editProfileCircle = Color(0xFFF4F5F8);
  static const green = Color(0xFF16AA16);
  static const Color revenueColor = Color(0xFFFF8A00);
  static const Color deepPurple = Color(0xFF673AB7);
  static const Color arrowRight = Color(0xFFD9D9D9);
  static const Color addButtonColor = Color(0xFFF3F3F3);
  static const Color removeButtonColor = Color(0xFFF7F7F7);
  static const Color icon = Color(0xFF898989);
  static const Color searchHint = Color(0xFF2E3456);
  static const Color inStockText = Color(0xFF16AA16);
  static const Color discountText = Color(0xFFC0C2CC);
  static const Color shadowSecond = Color(0x45A8A8A9);
  static const Color invoiceColor = Color(0xff232B2F);
  static const Color bg = Color(0xFFF9F9FA);
  static const Color greyColor = Color(0xFFF4F5F8);
  static const Color colorGrey = Color.fromRGBO(179, 181, 193, 1);
  static const Color toggleColor = Color(0xFFE7E7E7);
  static const Color toggleShadowColor = Color(0xFF6B6B6B);
  static const Color pendingDark = Color(0xFFF19204);
  static const Color blueColor = Color(0xff3a92f5);
  static const Color orange = Color(0xffF26110);


  /// font style

  static interBold({
    double size = 18,
    Color color = Style.black,
    double letterSpacing = 0
    }) =>
      GoogleFonts.inter(
          fontSize: size.sp,
          fontWeight: FontWeight.bold,
          color: color,
          letterSpacing: letterSpacing.sp,
          decoration: TextDecoration.none);

  static interSemi({
    double size = 18,
    Color color = Style.black,
    TextDecoration decoration =  TextDecoration.none,
    double letterSpacing = 0}) =>
      GoogleFonts.inter(
          fontSize: size.sp,
          fontWeight: FontWeight.w700,
          color: color,
          letterSpacing: letterSpacing.sp,
          decoration: decoration);

  static interNoSemi({
    double size = 18,
    Color color = Style.black,
    TextDecoration decoration =  TextDecoration.none,
    double letterSpacing = 0}) =>
      GoogleFonts.inter(
          fontSize: size.sp,
          fontWeight: FontWeight.w600,
          color: color,
          letterSpacing: letterSpacing.sp,
          decoration: decoration);

  static interNormal(
      {double size = 16,
        Color color = Style.black,
        TextDecoration textDecoration = TextDecoration.none,
        double letterSpacing = 0
      }) =>
      GoogleFonts.inter(
          fontSize: size.sp,
          fontWeight: FontWeight.w500,
          color: color,
          letterSpacing: letterSpacing.sp,
          decoration: textDecoration);

  static interRegular(
      {double size = 16,
        Color color = Style.black,
        TextDecoration textDecoration = TextDecoration.none,
        double letterSpacing = 0}) =>
      GoogleFonts.inter(
          fontSize: size,
          fontWeight: FontWeight.w400,
          color: color,
          letterSpacing: letterSpacing.sp,
          decoration: textDecoration);


}
