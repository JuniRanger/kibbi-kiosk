import 'package:kibbi_kiosk/src/presentation/components/buttons/button_effect_animation.dart';
import 'package:kibbi_kiosk/src/presentation/theme/theme.dart';

import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color backgroundColor;
  final double height;
  final double width;
  final double iconSize;

  const CircleButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.backgroundColor = Style.greyColor,
    this.height = 36,
    this.width = 36,
    this.iconSize = 21,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonEffectAnimation(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        child: Center(
            child: Icon(
          icon,
          color: Style.black,
          size: iconSize,
        )),
      ),
    );
  }
}
