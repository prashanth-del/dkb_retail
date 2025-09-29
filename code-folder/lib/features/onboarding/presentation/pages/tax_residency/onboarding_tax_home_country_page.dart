import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/components.dart';
import 'package:db_uicomponents/src/components/retail/ui_header_subheader_retail.dart';
import 'package:db_uicomponents/src/components/retail/ui_label_dropdown_retail.dart';
import 'package:flutter/material.dart';
import 'package:dkb_retail/core/router/app_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/validator/utils/tin_form_validator.dart';
import '../../../../common/components/auto_leading_widget.dart';
import '../../../../common/dialog/ui_dialogs.dart';
import '../../controller/notifier/onboarding_save_stage_data_notifier.dart';
import '../../provider/onboarding_provider.dart';

@RoutePage()
class OnboardingTaxHomeCountryPage extends ConsumerStatefulWidget {
  const OnboardingTaxHomeCountryPage({super.key});

  @override
  ConsumerState<OnboardingTaxHomeCountryPage> createState() =>
      _OnboardingTaxHomeCountryPageState();
}

class _OnboardingTaxHomeCountryPageState
    extends ConsumerState<OnboardingTaxHomeCountryPage> {
  String selectedOption = 'Yes';
  String? tin;

  String? reasonDropdownValue;

  String? explainReason;

  bool isReasonFieldEnabled = false;

  bool isExplainReasonEnabled = false;

  bool isValidTIN = false;
  bool isValidReason = false;

  TextEditingController tinController = TextEditingController();
  GlobalKey<FormState> tinFormKey = GlobalKey<FormState>();

  final List<String> reasons = [
    "Please Select",
    "Reason A",
    "Reason B",
    "Reason C",
  ];

  // String? validateTIN(String? value) {
  //   isValidTIN = false;
  //   if(reasonDropdownValue != null) {
  //     isValidTIN = true;
  //     return null;
  //   }
  //   if (value == null || value.isEmpty) {
  //     return "This field is required.";
  //   }
  //   final regex = RegExp(r'^[A-Z0-9 ]+$');
  //   if (!regex.hasMatch(value)) {
  //     return "Only uppercase alphanumeric characters and spaces are allowed.";
  //   }
  //   if (value.length != 19) {
  //     return "TIN must be exactly 19 characters.";
  //   }
  //   isValidTIN = true;
  //   return null;
  // }
  //
  // String? validateReasonDropdown(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return "This field is required.";
  //   }
  //   return null;
  // }

  String? validateExplainReason(String? value) {
    isValidReason = false;

    if (value == null || value.isEmpty) {
      return "This field is required.";
    }
    final regex = RegExp(r'^[A-Za-z ]+$');
    if (!regex.hasMatch(value)) {
      return "Only alphabetic characters and spaces are allowed.";
    }
    if (value.length < 10) {
      return "Minimum 10 characters required.";
    }
    if (value.length > 100) {
      return "Maximum 100 characters allowed.";
    }
    isValidReason = true;
    return null;
  }

  // void handleReasonSelection(String? value) {
  //   setState(() {
  //     reasonDropdownValue = value;
  //     isExplainReasonEnabled = value == "Reason B";
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final tinValidatorNotifier = ref.read(
      tinFormValidatorNotifierProvider.notifier,
    );
    final currentStage = getStageById(ref, "TAX_RESIDENCY_COUNTRY");

    return Scaffold(
      appBar: const UIAppBar.secondary(
        autoLeadingWidget: AutoLeadingWidget(),
        title: "Tax Residency",
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
                      title: "Home Country",
                      description:
                          "Since your home country is Jordan, answer the questions below.",
                    ),
                    const SizedBox(height: 20),

                    const UiTextNew.h4Regular(
                      "Country of Tax Residency",
                      color: DefaultColors.white_800,
                    ),
                    const SizedBox(height: 8),
                    const UiTextNew.customRubik(
                      "Jordan",
                      fontSize: 18,
                      color: DefaultColors.black,
                    ),
                    const SizedBox(height: 20),
                    const UiTextNew.customRubik(
                      "Do you have a tax identification number (or its equivalent)?",
                      fontSize: 16,
                      color: DefaultColors.white_800,
                    ),
                    const SizedBox(height: 16),
                    buildRadioOption("Yes"),
                    if (selectedOption == 'Yes') ...[
                      const SizedBox(height: 16),
                      _buildTINYESField(tinValidatorNotifier),
                    ],
                    const SizedBox(height: 16),
                    buildRadioOption("No"),
                    const SizedBox(height: 16),
                    if (selectedOption == 'No') _buildTINNoField(),

                    //     !isValidTIN ||
                    //     (isExplainReasonEnabled && !isValidReason),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 40,

              child: UIButton.rounded(
                label: 'CONTINUE',
                width: double.infinity,
                isDisabled:
                    (selectedOption == 'Yes' &&
                        (tinController.text.isEmpty ||
                            !tinFormKey.currentState!.validate())) ||
                    (selectedOption == 'No' &&
                        (reasonDropdownValue == null ||
                            reasonDropdownValue!.isEmpty ||
                            (isExplainReasonEnabled && !isValidReason))),
                onPressed: () async {
                  bool value = await ref
                      .read(onboardingSaveStageDataNotifierProvider.notifier)
                      .fetch(
                        custJourneyId: ref.watch(customerJourneyId),
                        stageId: "${currentStage?.stageId}",
                        data: {
                          if (selectedOption == 'Yes') ...{
                            "TIN_Number": tinController.text,
                          },
                          if (selectedOption == 'No') ...{
                            "Reason_Selected": reasonDropdownValue,
                            "Explain_Reason": isExplainReasonEnabled
                                ? explainReason
                                : "",
                          },
                        },
                      );

                  if (value == true) {
                    context.router.push(OnboardingSummaryRoute());
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

  Widget _buildTINYESField(TinFormValidatorNotifier tinValidator) {
    return Form(
      key: tinFormKey,
      child: UIFormTextField.outlined(
        hintText: "Enter TIN",
        maxLength: 19,
        controller: tinController,
        borderColor: DefaultColors.grayE6,
        labelUiText: UiTextNew.h4Regular(
          "Tax Identification Number",
          color: DefaultColors.white_800,
        ),
        labelHintTextStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          fontFamily: 'Rubik',
          color: DefaultColors.grayB3,
        ),

        labelTextStyle: const TextStyle(
          fontSize: 14,
          fontFamily: 'Rubik',
          fontWeight: FontWeight.w500,
          color: DefaultColors.white_800,
        ),
        validator: tinValidator.validateTin,
        onChanged: (value) {
          setState(() {
            tin = value;
          });
        },
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
                tinController.text = '';
                reasonDropdownValue = null;
                isExplainReasonEnabled = false;
                selectedOption = value!;
              });
            },
          ),
          UiTextNew.h5Regular(title, color: DefaultColors.black),
        ],
      ),
    );
  }

  Widget _buildTINNoField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Taxpayer Identification Number (TIN)
        SizedBox(height: 20),
        UiLabelDropdownRetail(
          label: "If no TIN available, reason",
          options: reasons,
          onChanged: (String? value) {
            setState(() {
              reasonDropdownValue = value == 'Please Select' ? '' : value;
              isExplainReasonEnabled = value == "Reason B";
            });
          },
        ),

        // Reason Dropdown
        SizedBox(height: 20),

        // Explain Reason
        if (isExplainReasonEnabled)
          UIFormTextField.outlined(
            hintText: "Enter Reason",
            maxLength: 100,
            borderColor: DefaultColors.grayE6,
            labelUiText: UiTextNew.h4Regular(
              "Explain the reason why you are unable to obtain TIN",
              color: DefaultColors.white_800,
            ),
            labelHintTextStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              fontFamily: 'Rubik',
              color: DefaultColors.grayB3,
            ),

            labelTextStyle: const TextStyle(
              fontSize: 14,
              fontFamily: 'Rubik',
              fontWeight: FontWeight.w500,
              color: DefaultColors.white_800,
            ),
            validator: validateExplainReason,
            onChanged: (value) {
              setState(() {
                explainReason = value;
              });
            },
          ),

        const SizedBox(height: 16),
      ],
    );
  }
}
