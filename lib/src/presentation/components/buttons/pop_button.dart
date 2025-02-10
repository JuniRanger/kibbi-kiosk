import 'package:kiosk/src/presentation/components/buttons/animation_button_effect.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiosk/src/presentation/theme/theme.dart';

class PopButton extends ConsumerWidget {
  final String heroTag;
  final VoidCallback? onTap;

  const PopButton( {super.key, required this.heroTag,this.onTap,});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimationButtonEffect(
      child: Hero(
        tag: heroTag,
        child: GestureDetector(
          onTap: onTap ?? context.popRoute,
          child: Container(
            width: 48.r,
            height: 48.r,
            decoration: BoxDecoration(
              color: Style.black,
              borderRadius: BorderRadius.circular(10.r),
            ),
            alignment: Alignment.center,
            child: Icon( FlutterRemix.arrow_left_s_line,
              color: Style.white,
              size: 20.r,
            ),
          ),
        ),
      ),
    );
  }
}
