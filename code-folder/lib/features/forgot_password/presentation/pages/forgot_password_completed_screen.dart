import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/components.dart';
import 'package:dkb_retail/core/constants/asset_path/asset_path.dart';
import 'package:dkb_retail/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/router/app_router.dart';

/// Countdown provider
final countdownProvider = StateProvider<int>((ref) => 5);

@RoutePage()
class ForgetPasswordTaskCompleteScreen extends ConsumerStatefulWidget {
  const ForgetPasswordTaskCompleteScreen({super.key});

  @override
  ConsumerState<ForgetPasswordTaskCompleteScreen> createState() =>
      _ForgetPasswordTaskCompleteScreenState();
}

class _ForgetPasswordTaskCompleteScreenState
    extends ConsumerState<ForgetPasswordTaskCompleteScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final current = ref.read(countdownProvider);
      if (current > 1) {
        ref.read(countdownProvider.notifier).state = current - 1;
      } else {
        _timer?.cancel();
        // Navigate after countdown finishes
        context.router.pushAndPopUntil(
          LoginRoute(),
          predicate: (route) => true,
        );
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

    return PopScope(
      canPop: false,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(AssetPath.image.taskcompletedScreenBg),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(AssetPath.lottie.greenTick, width: 200, height: 200),
            UiSpace.vertical(10),
            UiTextNew.custom(
              "Password Updated Successfully",
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: DefaultColors.blue9D,
            ),
            UiSpace.vertical(20),
            UiTextNew.custom(
              "Redirecting you to login page in $countdown s",
              fontSize: 13,
            ),
          ],
        ),
      ),
    );
  }
}
