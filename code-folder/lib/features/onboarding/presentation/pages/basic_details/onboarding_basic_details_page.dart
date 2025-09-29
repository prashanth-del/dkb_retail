import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/components.dart';
import 'package:db_uicomponents/src/components/retail/ui_header_subheader_retail.dart';
import 'package:db_uicomponents/src/components/retail/ui_label_dropdown_retail.dart';
import 'package:dkb_retail/core/constants/validator/utils/form_validator.dart';
import 'package:dkb_retail/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../common/components/auto_leading_widget.dart';
import '../../../../common/dialog/ui_dialogs.dart';
import '../../controller/notifier/onboarding_save_stage_data_notifier.dart';
import '../../provider/onboarding_provider.dart';
import '../../widget/build_info_message.dart';

@RoutePage()
class OnboardingBasicDetailsPage extends ConsumerStatefulWidget {
  const OnboardingBasicDetailsPage({super.key});

  @override
  ConsumerState<OnboardingBasicDetailsPage> createState() =>
      _OnboardingBasicDetailsPageState();
}

class _OnboardingBasicDetailsPageState
    extends ConsumerState<OnboardingBasicDetailsPage> {
  TextEditingController shortNameController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String selectedBranch = "";
  GlobalKey<FormState> emailFormKey = GlobalKey<FormState>();
  bool disableButton = false;

  void validateForm() {
    setState(() {
      disableButton =
          (selectedBranch.isEmpty ||
              emailController.text.isEmpty ||
              !emailFormKey.currentState!.validate())
          ? true
          : false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentStage = getStageById(ref, "IDENTIFICATION_DTL");

    final formValidatorProvider = ref.read(
      formValidatorNotifierProvider.notifier,
    );
    return Scaffold(
      appBar: UIAppBar.secondary(
        autoLeadingWidget: AutoLeadingWidget(),
        title: "Identification",
        appBarColor: DefaultColors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: emailFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const UiHeaderSubHeaderRetail(
                        title: "Basic Details",
                        description: "Fill out the information below",
                      ),
                      const SizedBox(height: 20),
                      UiLabelDropdownRetail(
                        label: "Salutation or Title",
                        options: const ["Please Select", "Mr", "Ms"],
                        onChanged: (String? value) {
                          selectedBranch = ((value == 'Please Select')
                              ? ''
                              : value)!;
                          validateForm();
                        },
                      ),
                      const SizedBox(height: 20),
                      _buildFieldShortName(),
                      const SizedBox(height: 20),
                      _buildFieldFullName(),
                      const SizedBox(height: 20),
                      _buildFieldEmail(formValidatorProvider),
                      const SizedBox(height: 20),
                      buildInfoMessage(
                        "!",
                        "E-mail Id will be used for further communication with Dukhan Bank",
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 40,
              child: UIButton.rounded(
                label: 'CONTINUE',
                width: double.infinity,
                isDisabled:
                    disableButton, //emailController.text.isEmpty || !emailFormKey.currentState!.validate() || selectedBranch.isEmpty,
                onPressed: () async {
                  bool value = await ref
                      .read(onboardingSaveStageDataNotifierProvider.notifier)
                      .fetch(
                        custJourneyId: ref.watch(customerJourneyId),
                        stageId: "${currentStage?.stageId}",
                        data: {
                          "salutation": selectedBranch,
                          "short_name": shortNameController.text,
                          "full_name": fullNameController.text,
                          "E_mail": emailController.text,
                        },
                      );

                  if (value == true) {
                    context.router.push(OnboardingAdditionalInfoDetailsRoute());
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

  Widget _buildFieldEmail(FormValidatorNotifier formValidatorProvider) {
    return UIFormTextField.outlined(
      controller: emailController,
      hintText: "E-mail",
      labelHintTextStyle: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        fontFamily: 'Rubik',
        color: DefaultColors.grayB3,
      ),
      borderColor: DefaultColors.grayE6,
      labelUiText: const UiTextNew.h4Regular(
        "E-mail",
        color: DefaultColors.white_800,
      ),
      onChanged: (value) {
        emailController.text = value;
        validateForm();
      },
      validator: formValidatorProvider.validateEmail,
      labelTextStyle: const TextStyle(
        fontSize: 14,
        fontFamily: 'Rubik',
        fontWeight: FontWeight.w500,
        color: DefaultColors.white_800,
      ),
    );
  }

  Widget _buildFieldShortName() {
    return UIFormTextField.outlined(
      controller: TextEditingController(
        text: formatShortNameFromSingleString("AAAAA BBBB CCCCC"),
      ),
      readOnly: true,
      hintText: "Short Name",
      labelHintTextStyle: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        fontFamily: 'Rubik',
        color: DefaultColors.grayB3,
      ),
      borderColor: DefaultColors.grayE6,
      labelUiText: const UiTextNew.h4Regular(
        "Short Name",
        color: DefaultColors.white_800,
      ),
      labelTextStyle: const TextStyle(
        fontSize: 14,
        fontFamily: 'Rubik',
        fontWeight: FontWeight.w500,
        color: DefaultColors.white_800,
      ),
    );
  }

  Widget _buildFieldFullName() {
    return UIFormTextField.outlined(
      controller: TextEditingController(
        text: formatFullName(
          "Ali Mohammed Ahmed Faisal Al Thani",
          isQatari: true,
        ),
      ),
      hintText: "Full Name",
      readOnly: true,
      labelHintTextStyle: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        fontFamily: 'Rubik',
        color: DefaultColors.grayB3,
      ),
      borderColor: DefaultColors.grayE6,
      labelUiText: const UiTextNew.h4Regular(
        "Full Name",
        color: DefaultColors.white_800,
      ),
      labelTextStyle: const TextStyle(
        fontSize: 14,
        fontFamily: 'Rubik',
        fontWeight: FontWeight.w500,
        color: DefaultColors.white_800,
      ),
    );
  }

  static String formatShortNameFromSingleString(String fullName) {
    // Split the name into parts
    List<String> nameParts = fullName.split(" ");

    String firstName = "";
    String secondName = "";
    String lastName = "";

    if (nameParts.length >= 3) {
      firstName = nameParts[0]; // First Name
      secondName = nameParts[1]; // Second Name
      lastName = nameParts[nameParts.length - 1]; // Last Name
    } else if (nameParts.length == 2) {
      firstName = nameParts[0];
      lastName = nameParts[1];
    } else if (nameParts.length == 1) {
      firstName = nameParts[0];
    }

    // Concatenate names
    String concatenatedName = "$firstName $secondName $lastName".trim();

    // If length exceeds 30 characters, take the initial of the second name
    if (concatenatedName.length > 30 && secondName.isNotEmpty) {
      secondName = "${secondName[0]}."; // Take the initial of the second name
      concatenatedName = "$firstName $secondName $lastName".trim();
    }

    return concatenatedName;
  }

  static String formatFullName(String fullName, {bool isQatari = false}) {
    // Split the full name into parts
    List<String> nameParts = fullName.split(" ");

    if (nameParts.isEmpty) {
      return "Invalid Name";
    }

    if (isQatari) {
      // For Qatari names, concatenate all parts
      String formattedName = nameParts.join(" ");

      // If the length exceeds 60 characters, take initials for middle parts
      if (formattedName.length > 60) {
        for (int i = 1; i < nameParts.length - 1; i++) {
          nameParts[i] = "${nameParts[i][0]}.";
        }
        formattedName = nameParts.join(" ");
      }

      return formattedName;
    } else {
      // For Expats, handle First Name, Middle Name, and Last Name
      String firstName = nameParts[0];
      String lastName = nameParts.length > 1 ? nameParts.last : "";
      String middleName = nameParts.length > 2
          ? nameParts.sublist(1, nameParts.length - 1).join(" ")
          : "";

      // Concatenate names
      String formattedName = "$firstName $middleName $lastName".trim();

      // If the length exceeds 60 characters, take initials for the middle name
      if (formattedName.length > 60 && middleName.isNotEmpty) {
        middleName = "${middleName[0]}.";
        formattedName = "$firstName $middleName $lastName".trim();
      }

      return formattedName;
    }
  }
}
