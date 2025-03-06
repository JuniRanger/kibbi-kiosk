import 'package:kibbi_kiosk/src/presentation/theme/theme.dart';

import 'package:flutter/material.dart';

class ButtonEffectAnimation extends StatefulWidget {
  final bool disabled;
  final VoidCallback? onTap;
  final Widget child;

  const ButtonEffectAnimation({
    super.key,
    this.disabled = false,
    required this.child,
    this.onTap,
  });

  @override
  State createState() => _ButtonEffectAnimationState();
}

class _ButtonEffectAnimationState extends State<ButtonEffectAnimation>
    with TickerProviderStateMixin {
  AnimationController? _controllerA;

  var squareScaleA = 0.95;

  @override
  void initState() {
    _controllerA = AnimationController(
      vsync: this,
      lowerBound: 0.95,
      upperBound: 1.0,
      duration: const Duration(milliseconds: 80),
    );
    _controllerA!.addListener(() {
      setState(() {
        squareScaleA = _controllerA!.value;
      });
    });

    _controllerA!.forward(from: 0.0);
    super.initState();
  }

  @override
  void dispose() {
    _controllerA!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.disabled
        ? Listener(
            onPointerDown: (_) {
              _controllerA!.reverse();
            },
            onPointerUp: (_) {
              _controllerA!.forward(from: 1.0);
              if (!widget.disabled) {}
            },
            child: Transform.scale(
              scale: squareScaleA,
              child: GestureDetector(
                  onTap: widget.onTap,
                  child:
                      Container(color: Style.transparent, child: widget.child)),
            ),
          )
        : GestureDetector(onTap: widget.onTap, child: widget.child);
  }
}
