import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../common/utils.dart';
import '../../../../core/constants/asset_path/asset_path.dart';

class SplashView extends StatefulWidget {
  final Duration fadeDelay;
  final Duration fadeDuration;
  const SplashView({
    super.key,
    this.fadeDelay = const Duration(milliseconds: 5200),
    this.fadeDuration = const Duration(seconds: 1),
  });

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  final double _opacity = 1.0;
  late final AnimationController _controller;

  // @override
  // void initState() {
  //   super.initState();
  //   Future.delayed(widget.fadeDelay, () {
  //     if (mounted) setState(() => _opacity = 0.0);
  //   });
  // }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setSystemBar(color: DefaultColors.transparent);

    // return AnimatedOpacity(
    //   opacity: _opacity,
    //   duration: widget.fadeDuration,
    //   child: UILottie(
    //     asset: AssetPath.lottie.splashScreen,
    //     height: context.screenHeight,
    //     width: context.screenWidth,
    //     fit: BoxFit.cover,
    //   ),
    // );
    return LottieBuilder.asset(
      AssetPath.lottie.splashScreen,
      controller: _controller,
      width: context.screenWidth,
      height: context.screenHeight,
      fit: BoxFit.cover,
      onLoaded: (composition) {
        consoleLog(
          'Animation duration: ${composition.duration.inMilliseconds} ms',
        );
        _controller
          ..duration = composition.duration
          ..forward();
      },
    );
  }
}
