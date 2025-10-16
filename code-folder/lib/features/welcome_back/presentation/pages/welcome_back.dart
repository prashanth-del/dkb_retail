import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:dkb_retail/features/login/presentation/widgets/login_app_bar.dart';
import 'package:dkb_retail/features/login/presentation/widgets/login_bottom_bar.dart';
import 'package:dkb_retail/features/rashid/presentation/pages/rashid_widget.dart';
import 'package:dkb_retail/features/welcome_back/presentation/widgets/welcome_back_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/constants/asset_path/asset_path.dart';

@RoutePage()
class WelcomeBackScreen extends ConsumerStatefulWidget {
  final bool fingerprintAuth;
  const WelcomeBackScreen({super.key, this.fingerprintAuth = false});

  @override
  ConsumerState<WelcomeBackScreen> createState() => _WelcomeBackScreenState();
}

class _WelcomeBackScreenState extends ConsumerState<WelcomeBackScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    return Scaffold(
      floatingActionButton: RashidWidget(),
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetPath.image.Loginbackground),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Lottie.asset(
              AssetPath.lottie.animatedCircleBg,
              width: double.infinity,
              // fit: BoxFit.cover,
              height: size.height * 0.8,
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 1000, sigmaY: 1000),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: w * 0.04,
                  vertical: h * 0.015,
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LoginAppBar(animatedProfile: true),

                      WelcomeBackBody(),
                      SizedBox(height: size.height * 0.1),

                      LoginBottomBar(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
