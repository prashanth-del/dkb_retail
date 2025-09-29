import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/components.dart';
import 'package:db_uicomponents/src/components/retail/ui_header_subheader_retail.dart';
import 'package:db_uicomponents/src/components/retail/ui_label_dropdown_retail.dart';
import 'package:db_uicomponents/utils.dart';
import 'package:flutter/material.dart';
import 'package:dkb_retail/core/router/app_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../common/components/auto_leading_widget.dart';
import '../../../../common/dialog/ui_dialogs.dart';
import '../../controller/notifier/onboarding_save_stage_data_notifier.dart';
import '../../provider/onboarding_provider.dart';

@RoutePage()
class OnboardingProminentFormPage extends ConsumerStatefulWidget {
  const OnboardingProminentFormPage({super.key});

  @override
  ConsumerState<OnboardingProminentFormPage> createState() =>
      _OnboardingProminentFormPageState();
}

class _OnboardingProminentFormPageState
    extends ConsumerState<OnboardingProminentFormPage> {
  String selectedOption = 'Yes';
  String selectedPositionRelationType = '';

  @override
  Widget build(BuildContext context) {
    TextEditingController uploadControllerPassport = TextEditingController();
    final currentStage = getStageById(ref, "FINANTIAL_DTL3");

    return Scaffold(
      appBar: const UIAppBar.secondary(
        autoLeadingWidget: AutoLeadingWidget(),
        title: "Financial",
        appBarColor: DefaultColors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const UiHeaderSubHeaderRetail(
                      title: "Financial Details",
                      description:
                          "Have you or any family members occupied prominent public/government functions in any country?",
                    ),
                    const SizedBox(height: 20),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildRadioOption('Yes'),
                        const SizedBox(height: 7),
                        buildRadioOption('No'),
                      ],
                    ),
                    const SizedBox(height: 20),

                    if (selectedOption == 'Yes') ...[
                      UiLabelDropdownRetail(
                        label: "Position and Relation Type",
                        options: const ["Please Select", "1", "2"],
                        onChanged: (value) {
                          setState(() {
                            selectedPositionRelationType =
                                ((value == 'Please Select') ? '' : value)!;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      setCountrySearchField(),
                    ],
                  ],
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: UIButton.rounded(
                label: 'CONTINUE',
                isDisabled:
                    (selectedOption == "Yes" &&
                    selectedPositionRelationType.isEmpty),
                onPressed: () async {
                  bool value = await ref
                      .read(onboardingSaveStageDataNotifierProvider.notifier)
                      .fetch(
                        custJourneyId: ref.watch(customerJourneyId),
                        stageId: "${currentStage?.stageId}",
                        data: {
                          "Financial_Details3": selectedOption,
                          if (selectedOption == "Yes") ...{
                            "Position_Relation_Type":
                                selectedPositionRelationType,
                            "country": "",
                          },
                        },
                      );

                  if (value == true) {
                    context.router.push(OnboardingTaxResidencyRoute());
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
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRadioOption(String title) {
    return SizedBox(
      height: 24,
      child: Row(
        children: [
          Radio<String>(
            value: title,
            groupValue: selectedOption,
            onChanged: (value) {
              setState(() {
                selectedOption = value!;
              });
            },
          ),
          UiTextNew.h5Regular(title, color: DefaultColors.black),
        ],
      ),
    );
  }

  setCountrySearchField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const UiTextNew.h4Regular(
          "Country (Position and Relation Type)",
          color: DefaultColors.white_800,
        ).vertical(8.0),
        const UiSearch(
          hintText: "Please Select",
          borderColorOfSearch: DefaultColors.grayE6,
        ).vertical(30.0),
      ],
    );
  }
}
