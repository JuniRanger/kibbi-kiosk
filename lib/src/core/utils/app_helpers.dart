import 'package:dio/dio.dart';
import 'package:kibbi_kiosk/src/presentation/theme/app_style.dart';

// import 'dart:io';
// import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../presentation/theme/theme.dart';
// import '../constants/constants.dart';
// import 'local_storage.dart';

class AppHelpers {
  AppHelpers._();

  static String errorHandler(e) {
    try {
      return (e.runtimeType == DioException)
          ? ((e as DioException).response?.data["message"] == "Bad request."
              ? (e.response?.data["params"] as Map).values.first[0]
              : e.response?.data["message"])
          : e.toString();
    } catch (s) {
      try {
        return (e.runtimeType == DioException)
            ? ((e as DioException).response?.data.toString().substring(
                    (e.response?.data.toString().indexOf("<title>") ?? 0) + 7,
                    e.response?.data.toString().indexOf("</title") ?? 0))
                .toString()
            : e.toString();
      } catch (r) {
        try {
          return (e.runtimeType == DioException)
              ? ((e as DioException).response?.data["error"]["message"])
                  .toString()
              : e.toString();
        } catch (f) {
          return e.toString();
        }
      }
    }
  }

  static String? getAppName() {
    // final List<SettingsData> settings = LocalStorage.getSettingsList();
    // for (final setting in settings) {

    //   if (setting.key == 'title') {
    //     return setting.value;
    //   }
    // }
    return 'Kibbi Kiosk';
  }

  static Color getStatusColor(String? value) {
    switch (value) {
      case 'pending':
        return Style.pendingDark;
      case 'new':
        return Style.blueColor;
      case 'accepted':
        return Style.deepPurple;
      case 'ready':
      case 'progress':
        return Style.revenueColor;
      case 'on_a_way':
        return Style.black;
      case 'unpublished':
        return Style.orange;
      case 'published':
      case 'active':
      case 'true':
      case 'delivered':
      case 'cash':
      case 'paid':
      case 'approved':
        return Style.green;
      case 'inactive':
      case 'false':
      case 'null':
      case 'canceled':
      case 'cancel':
        return Style.red;
      default:
        return Style.primary;
    }
  }

  static bool checkIsSvg(String? url) {
    if (url == null) {
      return false;
    }
    final length = url.length;
    return length > 3 ? url.substring(length - 3, length) == 'svg' : false;
  }

  static showSnackBar(BuildContext context, String title,
      {bool isIcon = false}) {
    ScaffoldMessenger.of(context).clearSnackBars();
    final snackBar = SnackBar(
      backgroundColor: Style.white,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 3),
      margin: EdgeInsets.fromLTRB(MediaQuery.sizeOf(context).width - 400.w, 0,
          32, MediaQuery.sizeOf(context).height - 160.h),
      content: Row(
        children: [
          if (isIcon)
            Padding(
              padding: EdgeInsets.only(right: 8.r),
              child: const Icon(
                FlutterRemix.checkbox_circle_fill,
                color: Style.primary,
              ),
            ),
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: Style.black,
              ),
            ),
          ),
        ],
      ),
      action: SnackBarAction(
        label: 'Cerrado',
        disabledTextColor: Style.black,
        textColor: Style.black,
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static showNoConnectionSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    final snackBar = SnackBar(
      backgroundColor: Style.primary,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 3),
      content: Text(
        'No internet connection',
        style: Style.interNoSemi(
          size: 14,
          color: Style.white,
        ),
      ),
      action: SnackBarAction(
        label: 'Close',
        disabledTextColor: Style.black,
        textColor: Style.black,
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showAlertDialog({
    required BuildContext context,
    required Widget child,
    double radius = 16,
    Color? backgroundColor,
  }) {
    AlertDialog alert = AlertDialog(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius.r),
      ),
      contentPadding: EdgeInsets.all(20.r),
      iconPadding: EdgeInsets.zero,
      content: child,
    );

    ///todo Directionality
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static String numberFormat(num? number, {String? symbol, bool? isOrder}) {
    // Aquí forzamos que el símbolo sea siempre '$' y esté antes del número
    return NumberFormat.currency(
      customPattern: '\u00a4#,###.#', // Símbolo antes del número
      symbol: '\$', // Forzamos que el símbolo sea '$'
      decimalDigits: 2,
    ).format(number ?? 0);
  }

    static void showCustomDialog({
    required BuildContext context,
    required Widget child,
    double radius = 16,
    String? title,
  }) {
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius.r),
      ),
      contentPadding: EdgeInsets.all(16.r),
      iconPadding: EdgeInsets.zero,
      alignment: Alignment.topRight,
      content: SizedBox(
        width: 0.2.sw,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title ?? "",
                  style: Style.interSemi(size: 18),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(FlutterRemix.close_fill))
              ],
            ),
            4.verticalSpace,
            child,
          ],
        ),
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}
