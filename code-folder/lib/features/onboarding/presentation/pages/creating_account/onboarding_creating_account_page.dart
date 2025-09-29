import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/components.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:dkb_retail/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:db_uicomponents/src/components/retail/ui_button_retail.dart';
import 'package:db_uicomponents/src/components/retail/ui_header_subheader_retail.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/constants/asset_path/asset_path.dart';
import '../../../../common/components/auto_leading_widget.dart';
import '../../../../common/dialog/ui_dialogs.dart';
import '../../controller/notifier/onboarding_save_stage_data_notifier.dart';
import '../../provider/onboarding_provider.dart';

@RoutePage()
class OnboardingCreatingAccountPage extends ConsumerWidget {
  const OnboardingCreatingAccountPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final currentStage = getStageById(ref, "ACCOUNT_CREATION");
    final currentStage2 = getStageById(ref, "CONFIRMATION");

    return Scaffold(
      // appBar: const UIAppBar.secondary(
      //   autoLeadingWidget: AutoLeadingWidget(),
      //   title: "New Account",
      //   appBarColor: DefaultColors.white,
      // ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Dukhan Bank Logo
            Center(
              child: Image.asset(
                AssetPath.image.new_logo, // Replace with the actual image path
                height: 43.7,
                alignment: Alignment.center,
              ),
            ),
            const SizedBox(height: 40),

            const UiTextNew.customRubik(
              "We’re creating your\n account...",
              fontSize: 24,
              color: DefaultColors.white_800,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),

            // "We’re creating your account..." Text
            const UiTextNew.h4Regular(
              "This action may take some time. Feel free to close the app at the point. You’ll receive a notification when the process has completed.",
              color: DefaultColors.white_800,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),

            const UiTextNew.customRubik(
              "Thank you for choosing Dukhan Bank!",
              fontSize: 14,
              color: DefaultColors.white_800,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(28.0),
        child: ActionButtonWidget(
          text: 'SET USERNAME & PASSWORD',
          onPressed: () async {
            bool value = await ref
                .read(onboardingSaveStageDataNotifierProvider.notifier)
                .fetch(
                  custJourneyId: ref.watch(customerJourneyId),
                  stageId: "${currentStage?.stageId}",
                  data: {"Account_Creation": "YES"},
                );
            if (value == true) {
              bool value = await ref
                  .read(onboardingSaveStageDataNotifierProvider.notifier)
                  .fetch(
                    custJourneyId: ref.watch(customerJourneyId),
                    stageId: "${currentStage2?.stageId}",
                    data: {"CONFIRMATION": "YES"},
                  );
              if (value == true) {
                context.router.push(OnboardingSetUsernamePasswordRoute());
              } else {
                UiDialogs.showErrorDialog(
                  context: context,
                  description: "Error Caught",
                  bknOkPressed: () {
                    context.router.maybePop();
                  },
                );
              }
            } else {
              UiDialogs.showErrorDialog(
                context: context,
                description: "Error Caught",
                bknOkPressed: () {
                  context.router.maybePop();
                },
              );
            }
          },
        ),
      ),
    );
  }
}
