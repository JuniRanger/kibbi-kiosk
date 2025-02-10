import 'dart:io' show Platform;
import 'package:kiosk/src/presentation/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class Loading extends StatelessWidget {
  final int size;
  final Color? color;

  const Loading({
    super.key,
    this.size = 24,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Platform.isAndroid
          ? SizedBox(
              height: size.r,
              width: size.r,
              child: CircularProgressIndicator(
                color: color ?? Style.black,
                strokeWidth: 3.r,
              ),
            )
          : CupertinoActivityIndicator(
              radius: 12,
              color: color ?? Style.black,
            ),
    );
  }
}
