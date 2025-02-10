import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/theme.dart';

class OutlinedBorderTextField extends StatelessWidget {
  final String? label;
  final double width;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? obscure;
  final TextEditingController? textController;
  final Function(String)? onChanged;
  final VoidCallback? onTap;
  final Function(String)? onFieldSubmitted;
  final TextInputType? inputType;
  final String? initialText;
  final String? descriptionText;
  final bool readOnly;
  final bool isError;
  final bool isSuccess;
  final int? maxLine;
  final TextCapitalization? textCapitalization;
  final TextInputAction? textInputAction;
  final double? verticalPadding;
  final double? labelSize;
  final int? maxLength;
  final bool? isDate;
  final Color? color;
  final Color? border;
  final TextStyle? style;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  const OutlinedBorderTextField({
    super.key,
    required this.label,
    this.suffixIcon,
    this.prefixIcon,
    this.width = double.infinity,
    this.maxLine = 1,
    this.obscure,
    this.onChanged,
    this.textController,
    this.inputType,
    this.initialText,
    this.descriptionText,
    this.readOnly = false,
    this.isError = false,
    this.isSuccess = false,
    this.textCapitalization,
    this.onFieldSubmitted,
    this.onTap,
    this.verticalPadding,
    this.labelSize,
    this.maxLength,
    this.isDate,
    this.color,
    this.style,
    this.border,
    this.validator,   this.textInputAction, this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(label != null)
          Column(
            children: [
              Text(label ?? "",),
              4.verticalSpace,
            ],
          ),
        Container(
          width: width.r,
          decoration: BoxDecoration(
            color: Style.white,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              width: 1.r,
              style: BorderStyle.solid,
              color: isError
                  ? Style.red
                  : isSuccess
                  ? Style.primary
                  : border ?? Style.border,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: TextFormField(
              validator: validator,
              maxLength: maxLength,
              maxLines: maxLine,
              onTap: onTap,
              inputFormatters: inputFormatters,
              textInputAction: textInputAction,
              onFieldSubmitted: onFieldSubmitted,
              onChanged: onChanged,
              obscureText: !(obscure ?? true),
              obscuringCharacter: '*',
              controller: textController,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
                fontSize: labelSize ?? 16.sp,
                color: Style.black,
                letterSpacing: -14 * 0.01,
              ),
              cursorWidth: 1,
              cursorColor: Style.black,
              keyboardType: inputType,
              initialValue: initialText,
              readOnly: readOnly,
              textCapitalization:
              textCapitalization ?? TextCapitalization.sentences,
              decoration: InputDecoration(
                counterText: '',
                suffixIcon: suffixIcon,
                suffixIconConstraints:
                BoxConstraints(maxWidth: 24.r, minWidth: 24.r),
                labelStyle: style,
                prefix: prefixIcon,
                contentPadding: REdgeInsets.symmetric(
                    horizontal: 16, vertical: verticalPadding ?? 10),
                floatingLabelStyle: GoogleFonts.inter(
                  fontWeight: FontWeight.w400,
                  fontSize: labelSize ?? 14.sp,
                  color: Style.black,
                  letterSpacing: -14 * 0.01,
                ),
                fillColor: color ?? Style.white,
                filled: true,
                hoverColor: Style.transparent,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                border: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
        ),
        if (descriptionText != null)
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              4.verticalSpace,
              Text(
                descriptionText!,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w400,
                  letterSpacing: -0.3,
                  fontSize: 12.sp,
                  color: isError
                      ? Style.red
                      : isSuccess
                      ? Style.primary
                      : Style.black,
                ),
              ),
            ],
          )
      ],
    );
  }
}
