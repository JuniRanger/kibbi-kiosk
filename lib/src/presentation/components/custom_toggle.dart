import 'package:kiosk/src/core/utils/utils.dart';
import 'package:kiosk/src/presentation/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/constants.dart';


class CustomToggle extends StatefulWidget {
  final ValueNotifier<bool>? controller;
  final bool isText;
  final Function(bool?)? onChange;

  const CustomToggle(
      {super.key, this.controller, this.onChange, this.isText = false});

  @override
  State<CustomToggle> createState() => _CustomToggleState();
}

class _CustomToggleState extends State<CustomToggle> {
  @override
  void initState() {
    widget.controller?.addListener(
      () {
        if (widget.onChange != null) {
          widget.onChange!(widget.controller?.value);
        }
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AdvancedSwitch(
      controller: widget.controller,
      activeColor: Style.primary,
      inactiveColor: Style.toggleColor,
      borderRadius: BorderRadius.circular(10),
      width: 70,
      height: 30,
      enabled: true,
      disabledOpacity: 0.5,
      activeChild: widget.isText
          ? Padding(
              padding: REdgeInsets.only(left: 4.r),
              child: Text(
                AppHelpers.getTranslation(TrKeys.open),
                style: GoogleFonts.glory(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Style.black,
                ),
              ),
            )
          : const SizedBox.shrink(),
      inactiveChild: widget.isText
          ? Padding(
              padding: REdgeInsets.only(right: 4.r),
              child: Text(
                AppHelpers.getTranslation(TrKeys.close),
                style: GoogleFonts.glory(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Style.black,
                ),
              ),
            )
          : const SizedBox.shrink(),
      thumb: Container(
        margin: REdgeInsets.all(3),
        padding: REdgeInsets.symmetric(vertical: 7, horizontal: 9),
        decoration: BoxDecoration(
          color: Style.white,
          borderRadius: BorderRadius.circular(6.r),
          boxShadow: [
            BoxShadow(
              color: Style.toggleShadowColor.withOpacity(0.4),
              spreadRadius: 0,
              blurRadius: 2,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Container(
          decoration: const BoxDecoration(color: Style.toggleColor),
        ),
      ),
    );
  }
}
