import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/components.dart';
import 'package:db_uicomponents/src/components/retail/ui_header_subheader_retail.dart';
import 'package:db_uicomponents/utils.dart';
import 'package:dkb_retail/features/onboarding/presentation/provider/onboarding_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../common/components/auto_leading_widget.dart';
import '../../../../common/dialog/ui_dialogs.dart';
import '../../controller/notifier/onboarding_save_stage_data_notifier.dart';

@RoutePage()
class OnboardingWorkHomeAddressPage extends ConsumerStatefulWidget {
  const OnboardingWorkHomeAddressPage({super.key});

  @override
  ConsumerState<OnboardingWorkHomeAddressPage> createState() =>
      _OnboardingWorkHomeAddressPageState();
}

class _OnboardingWorkHomeAddressPageState
    extends ConsumerState<OnboardingWorkHomeAddressPage> {
  bool isCheckedSameAddress = false;
  TextEditingController areaNumberController = TextEditingController();
  TextEditingController poBoxController = TextEditingController();
  TextEditingController streetNameController = TextEditingController();
  TextEditingController area2NumberController = TextEditingController();
  TextEditingController poBox2Controller = TextEditingController();
  TextEditingController streetName2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final currentStage = getStageById(ref, "IDENTIFICATION_ADDRESS");

    return Scaffold(
      appBar: UIAppBar.secondary(
        autoLeadingWidget: AutoLeadingWidget(),
        title: "Identification",
        appBarColor: DefaultColors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const UiHeaderSubHeaderRetail(
                title: "Work and Home Country / Residence / Mailing Address",
              ),
              const SizedBox(height: 24),
              const UiTextNew.customRubik(
                "Work Address",
                fontSize: 16,
                color: DefaultColors.white_800,
              ).vertical(16.0),
              _buildAreaNumberField(false, areaNumberController),
              const SizedBox(height: 20),
              _buildStreetNameField(false, streetNameController),
              const SizedBox(height: 20),
              _buildPOBoxField(false, poBoxController),
              const SizedBox(height: 20),
              _buildCountryField(false),
              // setCountrySearchField(),
              const SizedBox(height: 20),

              const UiHeaderSubHeaderRetail(
                title: "Home Country / Residence / Mailing Address",
              ),
              _buildCheckBoxWithLabel(),
              _buildAreaNumberField(
                isCheckedSameAddress,
                area2NumberController,
              ),
              const SizedBox(height: 20),
              _buildStreetNameField(
                isCheckedSameAddress,
                streetName2Controller,
              ),
              const SizedBox(height: 20),
              _buildPOBoxField(isCheckedSameAddress, poBox2Controller),
              const SizedBox(height: 20),
              _buildCountryField(isCheckedSameAddress),
              // setCountrySearchField(),
              const SizedBox(height: 20),

              SizedBox(
                width: MediaQuery.of(context).size.width - 40,
                child: UIButton.rounded(
                  label: 'CONTINUE',
                  width: double.infinity,
                  isDisabled:
                      areaNumberController.text.isEmpty ||
                      streetNameController.text.isEmpty ||
                      poBoxController.text.isEmpty ||
                      (!isCheckedSameAddress &&
                          (area2NumberController.text.isEmpty ||
                              streetName2Controller.text.isEmpty ||
                              poBox2Controller.text.isEmpty)),
                  onPressed: () async {
                    bool value = await ref
                        .read(onboardingSaveStageDataNotifierProvider.notifier)
                        .fetch(
                          custJourneyId: ref.watch(customerJourneyId),
                          stageId: "${currentStage?.stageId}",
                          data: {
                            "Area_number": areaNumberController.text,
                            "Street_name": streetNameController.text,
                            "PO_Box": poBoxController,
                            "Country": "Qatar",
                            "Same_As_Personal_Address": isCheckedSameAddress,
                            if (!isCheckedSameAddress) ...{
                              "Area_number_2": area2NumberController.text,
                              "Street_name_2": streetName2Controller.text,
                              "PO_Box_2": poBox2Controller,
                              "Country_2": "Qatar",
                            },
                          },
                        );

                    if (value == true) {
                      //context.router.push(OnboardingPassportInfoRoute());
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
      ),
    );
  }

  Widget _buildAreaNumberField(
    bool isDisabled,
    TextEditingController controller,
  ) {
    return UIFormTextField.outlined(
      hintText: "Enter Area Number",
      maxLength: 20,
      readOnly: isDisabled,
      controller: controller,
      borderColor: DefaultColors.grayE6,
      labelUiText: UiTextNew.h4Regular(
        "Area",
        color: isDisabled ? DefaultColors.grayB3 : DefaultColors.white_800,
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
      onChanged: (value) {
        setState(() {
          controller.text = value;
        });
      },
      validator: (value) {
        if (isDisabled) {
          controller.text = "";
          return null;
        }
        if (value == null || value.isEmpty) {
          return "This field is required";
        }
        if (!RegExp(r'^[a-zA-Z0-9]*$').hasMatch(value)) {
          return "No special characters are allowed including space.";
        }

        return null;
      },
    );
  }

  Widget _buildStreetNameField(
    bool isDisabled,
    TextEditingController controller,
  ) {
    return UIFormTextField.outlined(
      hintText: "Enter Street Name",
      maxLength: 10,
      controller: controller,
      readOnly: isDisabled,
      borderColor: DefaultColors.grayE6,
      labelUiText: UiTextNew.h4Regular(
        "Street",
        color: isDisabled ? DefaultColors.grayB3 : DefaultColors.white_800,
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
      onChanged: (value) {
        setState(() {
          controller.text = value;
        });
      },
      validator: (value) {
        if (isDisabled) {
          controller.text = "";
          return null;
        }

        if (value == null || value.isEmpty) {
          return "This field is required";
        }
        if (!RegExp(r'^[a-zA-Z0-9]*$').hasMatch(value)) {
          return "No special characters are allowed including space.";
        }

        return null;
      },
    );
  }

  Widget _buildPOBoxField(bool isDisabled, TextEditingController controller) {
    return UIFormTextField.outlined(
      hintText: "Enter P.O. Box Number",
      maxLength: 6,
      controller: controller,
      readOnly: isDisabled,
      borderColor: DefaultColors.grayE6,
      labelUiText: UiTextNew.h4Regular(
        "P.O. Box",
        color: isDisabled ? DefaultColors.grayB3 : DefaultColors.white_800,
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
      onChanged: (value) {
        setState(() {
          controller.text = value;
        });
      },
      validator: (value) {
        if (isDisabled) {
          controller.text = "";
          return null;
        }

        if (value == null || value.isEmpty) {
          return "This field is required";
        }
        if (!RegExp(r'^[a-zA-Z0-9]*$').hasMatch(value)) {
          return "No special characters are allowed including space.";
        }

        return null;
      },
    );
  }

  Widget _buildCountryField(bool isDisabled) {
    isDisabled = ref.watch(getEmploymentStatusForStudHomeRetired) == true
        ? true
        : isDisabled;
    return UIFormTextField.outlined(
      hintText: "Please Select",
      readOnly: isDisabled,
      borderColor: DefaultColors.grayE6,
      labelUiText: UiTextNew.h4Regular(
        "Country",
        color: isDisabled ? DefaultColors.grayB3 : DefaultColors.white_800,
      ),
      labelHintTextStyle: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        fontFamily: 'Rubik',
        color: DefaultColors.grayB3,
      ),
      controller: TextEditingController(text: isDisabled ? "" : "Qatar"),
      labelTextStyle: const TextStyle(
        fontSize: 14,
        fontFamily: 'Rubik',
        fontWeight: FontWeight.w500,
        color: DefaultColors.white_800,
      ),
    );
  }

  // Widget _setFormInputField(String label, String hintText) {
  //   return  UIFormTextField.outlined(
  //     hintText: hintText,
  //     borderColor: DefaultColors.grayE6,
  //     labelUiText: UiTextNew.h4Regular(
  //       label,
  //       color: DefaultColors.white_800,
  //     ),
  //     labelTextStyle: const TextStyle(
  //         fontSize: 14,
  //         fontFamily: 'Rubik',
  //         fontWeight: FontWeight.w500,
  //         color: DefaultColors.white_800
  //     ),
  //   );
  //
  // }

  _buildCheckBoxWithLabel() {
    return Transform.translate(
      offset: const Offset(-10, 0), // Moves the checkbox slightly left
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Checkbox(
            value: isCheckedSameAddress,
            onChanged: (value) {
              setState(() {
                isCheckedSameAddress = value!;
              });
            },
            side: const BorderSide(
              color: DefaultColors.gray8A, // Change border color here
              width: 2.0, // Adjust the border width
            ),
          ),
          const UiTextNew.h4Regular(
            "Same as Personal Address",
            color: DefaultColors.black,
          ),
        ],
      ),
    );
  }

  setCountrySearchField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const UiTextNew.h4Regular(
          "Country",
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
