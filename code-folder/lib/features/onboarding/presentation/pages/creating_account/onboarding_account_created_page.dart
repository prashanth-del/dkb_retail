import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/components.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:dkb_retail/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:db_uicomponents/src/components/retail/ui_button_retail.dart';
import 'package:db_uicomponents/src/components/retail/ui_header_subheader_retail.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/constants/asset_path/asset_path.dart';
import '../../../../common/components/auto_leading_widget.dart';
import '../../../../common/dialog/ui_dialogs.dart';
import '../../controller/notifier/onboarding_save_stage_data_notifier.dart';
import '../../provider/onboarding_provider.dart';

@RoutePage()
class OnboardingAccountCreatedPage extends ConsumerWidget {
  const OnboardingAccountCreatedPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final currentStage = getStageById(ref, "CONGRATS");
    final currentStage2 = getStageById(ref, "PROCEED_LGN");

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
              child: SvgPicture.asset(
                AssetPath
                    .icon
                    .transactionSuccess, // Replace with the actual image path
                height: 100,
                width: 100,
                alignment: Alignment.center,
              ),
            ),
            const SizedBox(height: 32),

            const UiTextNew.customRubik(
              "Your Savings Account was Created",
              fontSize: 24,
              color: DefaultColors.white_800,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),

            // "We’re creating your account..." Text
            const UiTextNew.h4Regular(
              "Congratulations! You can now log in to start using your account.",
              color: DefaultColors.white_800,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),

            const UiTextNew.h4Regular(
              "Here is your new IBAN number",
              color: DefaultColors.white_800,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Flexible(
                  child: UiTextNew.customRubik(
                    "793282379237802",
                    fontSize: 14,
                    color: DefaultColors.white_800,
                  ),
                ),
                const UiSpace.horizontal(4),
                IconButton(
                  iconSize: 20,
                  style: const ButtonStyle(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(
                    minHeight: 20,
                    minWidth: 20,
                    maxHeight: 20,
                    maxWidth: 20,
                  ),
                  onPressed: () async {
                    await Clipboard.setData(
                      const ClipboardData(text: "793282379237802"),
                    ).then((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("IBAN copied to clipboard"),
                        ),
                      );
                    });
                  },
                  icon: const Icon(
                    Icons.copy_rounded,
                    color: DefaultColors.blue9D,
                    size: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(28.0),
        child: ActionButtonWidget(
          text: 'Login',
          onPressed: () async {
            bool value = await ref
                .read(onboardingSaveStageDataNotifierProvider.notifier)
                .fetch(
                  custJourneyId: ref.watch(customerJourneyId),
                  stageId: "${currentStage?.stageId}",
                  data: {"CONGRATS": "YES"},
                );
            if (value == true) {
              bool value = await ref
                  .read(onboardingSaveStageDataNotifierProvider.notifier)
                  .fetch(
                    custJourneyId: ref.watch(customerJourneyId),
                    stageId: "${currentStage2?.stageId}",
                    data: {"PROCEED_LGN": "YES"},
                  );
              if (value == true) {
                context.router.push(LoginRoute());
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
