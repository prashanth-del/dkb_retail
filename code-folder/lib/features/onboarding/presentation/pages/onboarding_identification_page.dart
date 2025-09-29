import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/components.dart';
import 'package:db_uicomponents/src/components/retail/ui_button_retail.dart';
import 'package:flutter/material.dart';
import 'package:dkb_retail/core/constants/asset_path/asset_path.dart';
import 'package:dkb_retail/core/router/app_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/colors.dart';
import '../../../common/components/auto_leading_widget.dart';
import '../../../common/dialog/ui_dialogs.dart';
import '../controller/notifier/onboarding_save_stage_data_notifier.dart';
import '../provider/onboarding_provider.dart';

@RoutePage()
class OnboardingIdentificationPage extends ConsumerWidget {
  const OnboardingIdentificationPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final currentStage = getStageById(ref, "IDENTIFICATION_QID");
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Container(
        color: const Color(0xFFF0F0F3),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const UiTextNew.customRubik(
                      "QID Scan",
                      fontSize: 18,
                      color: Colors.black,
                    ),

                    const SizedBox(height: 10),

                    const UiTextNew.h4Regular(
                      "We’ll start by capturing some images of your Identity card. For better results, ensure the following conditions.",
                      color: DefaultColors.white_800,
                    ),

                    const SizedBox(height: 10),

                    const ChecklistItem(label: "QID card next to you"),
                    SizedBox(height: 12),
                    const ChecklistItem(label: "Good lighting"),
                    SizedBox(height: 12),
                    const ChecklistItem(label: "Good network connection"),
                    SizedBox(height: 12),
                    const ChecklistItem(label: "No glares on your QID"),

                    SizedBox(height: 20),

                    const UiTextNew.customRubik(
                      "Requirements",
                      fontSize: 14,
                      color: DefaultColors.white_800,
                    ),

                    SizedBox(height: 10),
                    RequirementItem(label: " Qatar ID"),
                    SizedBox(height: 12),
                    RequirementItem(label: " Proof of address"),
                    SizedBox(height: 12),
                    RequirementItem(label: " Proof of income"),

                    SizedBox(height: 40),

                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const UiTextNew.customRubik(
                            "Take a photo of Front and Back of your ID card",
                            fontSize: 14,
                            color: DefaultColors.white_800,
                          ),
                          SizedBox(height: 32),

                          Image.asset(
                            AssetPath.image.identificationCardOnBoardingImage,
                            height: 112,
                            width: double.infinity,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ActionButtonWidget(
              text: 'SCAN ID',
              onPressed: () async {
                // ref.read(isSubmittedRequestProvider.notifier).state = false;
                //
                bool value = await ref
                    .read(onboardingSaveStageDataNotifierProvider.notifier)
                    .fetch(
                      custJourneyId: ref.watch(customerJourneyId),
                      stageId: "${currentStage?.stageId}",
                      data: {"Identification_QID": "YES"},
                    );
                if (value == true) {
                 // context.router.push(OnboardingIdentifyDocumentRoute());
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

UIAppBar _buildAppBar() {
  return const UIAppBar.secondary(
    title: "Identification",
    autoLeadingWidget: AutoLeadingWidget(),
    iconWidth: 20,
    iconHeight: 20,
  );
}

class ChecklistItem extends StatelessWidget {
  final String label;
  const ChecklistItem({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Icons.check, color: DefaultColors.gray54, size: 18),
        const SizedBox(width: 8),
        Expanded(
          child: UiTextNew.h5Regular(label, color: DefaultColors.gray54),
        ),
      ],
    );
  }
}

class RequirementItem extends StatelessWidget {
  final String label;
  const RequirementItem({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          AssetPath.icon.descriptionRetailIcon,
          width: 16,
          height: 16,
        ),
        SizedBox(width: 8),
        Expanded(
          child: UiTextNew.h5Regular(label, color: DefaultColors.gray54),
        ),
      ],
    );
  }
}
