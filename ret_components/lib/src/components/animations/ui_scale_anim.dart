import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class UIScaleAnimation extends StatelessWidget {
  final Widget? child;
  final double? delay;
  const UIScaleAnimation({Key? key, this.child, this.delay}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlayAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: delay != null
          ? Duration(milliseconds: (50 * delay!).round())
          : const Duration(seconds: 2),
      curve: Curves.easeInOutQuart,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: child,
        );
      },
      child: child,
    );
  }
}
