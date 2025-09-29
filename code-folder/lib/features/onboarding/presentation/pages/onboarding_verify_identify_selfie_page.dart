import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/components.dart';
import 'package:db_uicomponents/src/components/retail/ui_button_retail.dart';
import 'package:flutter/material.dart';
import 'package:dkb_retail/core/router/app_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/asset_path/asset_path.dart';
import '../../../../core/constants/colors.dart';
import '../../../common/components/auto_leading_widget.dart';
import '../../../common/dialog/ui_dialogs.dart';
import '../controller/notifier/onboarding_save_stage_data_notifier.dart';
import '../provider/onboarding_provider.dart';

@RoutePage()
class OnboardingVerifyIdentifySelfiePage extends ConsumerWidget {
  const OnboardingVerifyIdentifySelfiePage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final currentStage = getStageById(ref, "IDENTIFICATION_SELFIE");

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const UIAppBar.secondary(
        title: "Identification",
        autoLeadingWidget: AutoLeadingWidget(),
        iconWidth: 20,
        iconHeight: 20,
      ),
      body: Container(
        color: const Color(0xFFF0F0F3),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const UiTextNew.customRubik(
              'Selfie Time',
              fontSize: 18,
              color: DefaultColors.black,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const UiTextNew.customRubik(
                    'Get Ready!',
                    fontSize: 24,
                    color: DefaultColors.white_800,
                  ),
                  const SizedBox(height: 24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InstructionItem(
                        icon: AssetPath.icon.onBoardingLightRetailIcon,
                        text: "Good \nIllumination",
                      ),
                      InstructionItem(
                        icon: AssetPath.icon.onboardingAccessoriesRetailIcon,
                        text: "No accessories\nlike glasses,\nmasks, hats etc.",
                      ),
                      InstructionItem(
                        icon: AssetPath.icon.onboardingMobileRetailIcon,
                        text: "Camera at\neye level",
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            ActionButtonWidget(
              text: 'Let’s start',
              onPressed: () async {
                bool value = await ref
                    .read(onboardingSaveStageDataNotifierProvider.notifier)
                    .fetch(
                      custJourneyId: ref.watch(customerJourneyId),
                      stageId: "${currentStage?.stageId}",
                      data: {"Identification-selfie": "YES"},
                    );

                if (value == true) {
                  context.router.push(
                    const OnboardingVerifyIdentifyFaceRoute(),
                  );
                } else {
                  UiDialogs.showErrorDialog(
                    context: context,
                    description: "Data Not Saved",
                    bknOkPressed: () {
                      context.router.maybePop();
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class InstructionItem extends StatelessWidget {
  final String icon;
  final String text;

  const InstructionItem({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(icon, width: 76, height: 76),

        const SizedBox(height: 12),
        UiTextNew.h5Regular(
          text,
          color: DefaultColors.white_800,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
