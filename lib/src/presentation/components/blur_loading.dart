import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/theme.dart';

class BlurLoadingWidget extends StatelessWidget {
  final bool isLoading;

  const BlurLoadingWidget({super.key, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Style.white.withOpacity(0.5),
              ),
              child: Container(
                width: 80,
                height: 80,
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  color: Style.black,
                  strokeWidth: 4.r,
                ),
              ),
            ),
          )
        : const SizedBox();
  }
}
