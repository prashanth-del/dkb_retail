import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class UILottie extends StatelessWidget {
  final String asset;
  final AnimationController? controller;
  final double? height;
  final double? width;
  final bool? repeat;
  final bool? reverse;
  final BoxFit? fit;
  const UILottie(
      {super.key,
        required this.asset,
        this.controller,
        this.height = 75,
        this.width,
        this.fit,
        this.repeat = true,
        this.reverse = false});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(asset,
        repeat: repeat,
        height: height,
        width: width,
        animate: true,
        fit: fit,
        controller: controller,
        reverse: reverse,
        addRepaintBoundary: false
    );
  }
}
