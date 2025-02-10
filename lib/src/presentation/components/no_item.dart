import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../../../../../../../generated/assets.dart';
import '../../core/utils/app_helpers.dart';

class NoItem extends StatelessWidget {
  final String title;

  const NoItem({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
              width: MediaQuery.sizeOf(context).width/3.5,
              child: Lottie.asset(Assets.lottieNotFound)),
          8.verticalSpace,
          Padding(
            padding: REdgeInsets.symmetric(horizontal: 24),
            child: Text(
              AppHelpers.getTranslation(title),
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
