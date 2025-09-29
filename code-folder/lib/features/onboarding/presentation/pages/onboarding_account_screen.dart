import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:flutter/material.dart';
import 'package:dkb_retail/core/router/app_router.dart';
import 'package:dkb_retail/features/onboarding/presentation/widget/image_slider.dart';

import '../../../../core/constants/asset_path/asset_path.dart';
import '../../../common/components/auto_leading_widget.dart';
@RoutePage()
class OnboardingAccountScreen extends StatelessWidget {
  const OnboardingAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DefaultColors.white_f3,
      appBar: UIAppBar.centreLogo(
        autoLeadingWidget: const AutoLeadingWidget(),
        logoPath: AssetPath.image.new_logo,
        appBarColor: DefaultColors.white,
      ),
      body: SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: imageSliderView(
                  images: ImageAssets().onBoardingSlideRetail,
                  height: 320,
                ),
              ),
              // Spacer(),
              const SizedBox(height: 30),
              TitleWidget(),
              const SizedBox(height: 50),
              UIButton.rounded(onPressed: () {
                context.router.push(const OnboardingWelcomeRoute());
              }, label: 'GET STARTED',maxWidth: context.screenWidth,height: 45,)
              // ActionButtonWidget(text: "GET STARTED", onPressed: () {
              //   context.router.push(const OnboardingWelcomeRoute());
              // })
            ],
          ),
        ),
      ),
    );
  }
}

class LogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          AssetPath.image.new_logo, // Replace with the actual image path
          height: 43.7,
        ),
      ],
    );
  }
}

class TitleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        UiTextNew.customRubik(
          'Savings Account \nOpening',
          fontSize: 24,
          color: DefaultColors.blue9D,
          textAlign: TextAlign.center,

        ),
        SizedBox(height: 10,),
        UiTextNew.customRubik(
          'Using our mobile app, you can now instantly open New Savings Account',
          fontWeight: FontWeight.w400,
          fontSize: 16,
          color: DefaultColors.gray8A,
          textAlign: TextAlign.center,

        ),
      ],
    );
  }
}
