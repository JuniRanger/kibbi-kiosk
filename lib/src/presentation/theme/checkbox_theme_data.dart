import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

import 'app_style.dart';

CheckboxThemeData checkboxThemeData = CheckboxThemeData(
  fillColor: WidgetStateProperty.all(Style.primary),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.r)),
  side: const BorderSide(color: Style.primary),
);
