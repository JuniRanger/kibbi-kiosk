import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../theme/theme.dart';

class CustomPasswords extends StatelessWidget {
  final VoidCallback onTap;

  const CustomPasswords({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: 'Serial:',
                  style: GoogleFonts.inter(
                      fontSize: 14.sp, letterSpacing: -0.3, color: Style.black),
                  children: [
                    TextSpan(
                      text: ' ${AppConstants.demoKioskLogin}',
                      style: GoogleFonts.inter(
                          letterSpacing: -0.3,
                          fontSize: 14.sp,
                          fontStyle: FontStyle.italic,
                          color: Style.black),
                    )
                  ],
                ),
              ),
              6.verticalSpace,
              RichText(
                text: TextSpan(
                  text: 'Contraseña:',
                  style: GoogleFonts.inter(
                      letterSpacing: -0.3, color: Style.black, fontSize: 14.sp),
                  children: [
                    TextSpan(
                      text: ' ${AppConstants.demoKioskPassword}',
                      style: GoogleFonts.inter(
                          letterSpacing: -0.3,
                          fontSize: 14.sp,
                          fontStyle: FontStyle.italic,
                          color: Style.black),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        TextButton(
          onPressed: onTap,
          child: Text(
            'Copiar',
            style: GoogleFonts.inter(fontSize: 14.sp),
          ),
        ),
      ],
    );
  }
}
