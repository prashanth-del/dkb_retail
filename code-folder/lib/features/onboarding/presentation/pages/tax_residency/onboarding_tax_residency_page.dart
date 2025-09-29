import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/components.dart';
import 'package:db_uicomponents/src/components/retail/ui_header_subheader_retail.dart';
import 'package:flutter/material.dart';
import 'package:dkb_retail/core/constants/validator/utils/tin_form_validator.dart';
import 'package:dkb_retail/core/router/app_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../common/components/auto_leading_widget.dart';
import '../../../../common/dialog/ui_dialogs.dart';
import '../../controller/notifier/onboarding_save_stage_data_notifier.dart';
import '../../provider/onboarding_provider.dart';

@RoutePage()
class OnboardingTaxResidencyPage extends ConsumerStatefulWidget {
  OnboardingTaxResidencyPage({super.key});

  @override
  ConsumerState<OnboardingTaxResidencyPage> createState() =>
      _OnboardingTaxResidencyPageState();
}

class _OnboardingTaxResidencyPageState
    extends ConsumerState<OnboardingTaxResidencyPage> {
  TextEditingController countryTaxResidencyController = TextEditingController(
    text: "United States of America",
  );
  TextEditingController tinController = TextEditingController();

  // final _formKey = GlobalKey<FormState>();

  bool isValidTIN = false;
  bool isValidReason = false;
  GlobalKey<FormState> tinFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final tinValidatorNotifier = ref.read(
      tinFormValidatorNotifierProvider.notifier,
    );
    final currentStage = getStageById(ref, "TAX_RESIDENCY");

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
                      title: "Nationality",
                      description:
                          "Since your nationality is in the United States of America, answer the questions below.",
                    ),
                    const SizedBox(height: 20),
                    const UiTextNew.h4Regular(
                      "Country of Tax Residency",
                      color: DefaultColors.white_800,
                    ),
                    const SizedBox(height: 3),
                    const UiTextNew.customRubik(
                      "United States of America",
                      fontSize: 18,
                      color: DefaultColors.black,
                    ),

                    // _setFormInputFieldUnderlined("Country of Tax Residency", "United States of America"),
                    const SizedBox(height: 20),
                    _buildTINField(tinValidatorNotifier),
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
                    tinController.text.isEmpty ||
                    !tinFormKey.currentState!.validate(),
                onPressed: () async {
                  bool value = await ref
                      .read(onboardingSaveStageDataNotifierProvider.notifier)
                      .fetch(
                        custJourneyId: ref.watch(customerJourneyId),
                        stageId: "${currentStage?.stageId}",
                        data: {"TIN_Number": tinController.text},
                      );

                  if (value == true) {
                    context.router.push(OnboardingTaxOtherCountriesRoute());
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

  Widget _setFormInputFieldUnderlined(String label, String hintText) {
    return UIFormTextField.underlined(
      hintText: hintText,
      controller: countryTaxResidencyController,
      borderColor: DefaultColors.transparent,
      labelUiText: UiTextNew.h4Regular(label, color: DefaultColors.white_800),
      labelTextStyle: const TextStyle(
        fontSize: 16,
        fontFamily: 'Rubik',
        fontWeight: FontWeight.w500,
        color: DefaultColors.white_800,
      ),
    );
  }

  Widget _buildTINField(TinFormValidatorNotifier tinValidator) {
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
            // tin = value;
          });
        },
      ),
    );
  }
}
