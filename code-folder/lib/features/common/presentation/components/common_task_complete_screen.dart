import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/components.dart';
import 'package:db_uicomponents/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/constants/asset_path/asset_path.dart';

/// Common countdown provider (shared)
final countdownProvider = StateProvider<int>((ref) => 0);

@RoutePage()
class CommonTaskCompleteScreen extends ConsumerStatefulWidget {
  /// Background image
  final String? backgroundImage;

  /// Lottie animation path
  final String? lottiePath;

  /// Main title text
  final String title;

  /// Subtitle text (e.g. “Redirecting in 5s”)
  final String? subtitle;

  /// Called when countdown finishes
  final VoidCallback onCountdownComplete;

  /// Countdown duration (in seconds)
  final int countdownSeconds;

  /// Title styling
  final TextStyle? titleStyle;

  /// Subtitle styling
  final TextStyle? subtitleStyle;

  /// Custom widget (optional) instead of Lottie
  final Widget? customAnimation;

  /// Whether back navigation is disabled
  final bool disableBack;

  const CommonTaskCompleteScreen({
    super.key,
    this.backgroundImage,
    this.lottiePath,
    required this.title,
    this.subtitle,
    required this.onCountdownComplete,
    this.countdownSeconds = 5,
    this.titleStyle,
    this.subtitleStyle,
    this.customAnimation,
    this.disableBack = true,
  });

  @override
  ConsumerState<CommonTaskCompleteScreen> createState() =>
      _CommonTaskCompleteScreenState();
}

class _CommonTaskCompleteScreenState
    extends ConsumerState<CommonTaskCompleteScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    // Delay provider update until after build
    Future.microtask(() {
      ref.read(countdownProvider.notifier).state = widget.countdownSeconds;
      _startCountdown();
    });
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final current = ref.read(countdownProvider);
      if (current > 1) {
        ref.read(countdownProvider.notifier).state = current - 1;
      } else {
        _timer?.cancel();
        widget.onCountdownComplete(); // ✅ Call the provided callback
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final countdown = ref.watch(countdownProvider);

    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Material(
      child: PopScope(
        canPop: !widget.disableBack,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                widget.backgroundImage ?? AssetPath.image.headerbackground,
              ),
            ),
          ),
          child: Stack(
            children: [
              Image.asset(
                AssetPath.image.backgroundGradient,

                width: double.infinity,

                fit: BoxFit.cover,
              ),
              Image.asset(
                AssetPath.image.taskcompletedScreenBg,
                fit: BoxFit.cover,
                height: double.infinity,
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        widget.lottiePath ?? AssetPath.gif.taskSuccess,
                        width: width * 0.3,
                        height: height * 0.3,
                      ),

                      UiSpace.vertical(12),
                      Text(
                        widget.title,
                        textAlign: TextAlign.center,
                        style:
                            widget.titleStyle ??
                            TextStyle(
                              fontSize: size.aspectRatio * 50,
                              fontWeight: FontWeight.bold,
                              color: DefaultColors.white,
                            ),
                      ),
                      if (widget.subtitle != null) ...[
                        UiSpace.vertical(height * 0.06),
                        Text(
                          "${widget.subtitle ?? 'Redirecting'} in $countdown s",
                          style:
                              widget.subtitleStyle ??
                              TextStyle(
                                fontSize: size.aspectRatio * 35,
                                color: DefaultColors.white,
                              ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
