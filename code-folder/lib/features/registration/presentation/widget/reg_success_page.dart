import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:dkb_retail/core/constants/asset_path/asset_path.dart';
import 'package:dkb_retail/core/router/app_router.dart';
import 'package:dkb_retail/core/utils/extensions/locale_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegSuccessPage extends ConsumerStatefulWidget {
  const RegSuccessPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegSuccessPageState();
}

class _RegSuccessPageState extends ConsumerState<RegSuccessPage> {
  late Timer _timer;
  late int _remainingSeconds;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _remainingSeconds = 3;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() => _remainingSeconds--);
      } else {
        _timer.cancel();
        context.router.replaceAll([(WelcomeBackRoute())]);
      }
    });
  }

  String get _formattedTime {
    // final minutes = (_remainingSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_remainingSeconds % 60).toString().padLeft(2, '0');
    return seconds;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DefaultColors.white,
      body: UiBackgroundWrapper(
        child: Stack(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Image.asset(AssetPath.image.vectorleft),
            ),
            Container(
              alignment: Alignment.centerRight,
              child: Image.asset(AssetPath.image.vectorright),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: UiTextNew.h2Semibold(
                    ref.getLocaleString(
                      'Registration Completed\nSuccessfully',
                      defaultValue: 'Registration Completed\nSuccessfully',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                UiSpace.vertical(20),
                Center(
                  child: UiTextNew.b14Medium(
                    '${ref.getLocaleString('Taking you to login in', defaultValue: 'Taking you to login in')} $_formattedTime s',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
