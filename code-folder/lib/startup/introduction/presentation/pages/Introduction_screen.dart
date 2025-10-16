import 'package:auto_route/auto_route.dart';
import 'package:dkb_retail/core/constants/asset_path/asset_path.dart';
import 'package:flutter/material.dart';

import '../widgets/introduction_body.dart';
import '../widgets/introduction_bottom_widget.dart';

@RoutePage()
class IntroductionScreen extends StatelessWidget {
  const IntroductionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          // --- Background GIF ---
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: Image.asset(AssetPath.gif.cardsBg, gaplessPlayback: true),
            ),
          ),

          Container(
            decoration: const BoxDecoration(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.07),
              child: Column(
                children: [
                  IntroductionBody(),
                  Spacer(),
                  walletScreenBottom(context: context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
