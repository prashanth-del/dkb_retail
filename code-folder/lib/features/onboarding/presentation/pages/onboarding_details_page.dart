import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/components.dart';
import 'package:db_uicomponents/src/components/retail/ui_button_retail.dart';
import 'package:db_uicomponents/src/components/retail/ui_input_field_retail.dart';
import 'package:db_uicomponents/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dkb_retail/core/constants/validator/utils/qid_mobile_validator.dart';
import 'package:dkb_retail/core/router/app_router.dart';
import 'package:dkb_retail/core/utils/extensions/locale_extension.dart';
import 'package:dkb_retail/features/onboarding/presentation/controller/notifier/onboarding_retrieve_journey_notifier.dart';
import 'package:dkb_retail/features/onboarding/presentation/controller/notifier/onboarding_save_stage_data_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/asset_path/asset_path.dart';
import '../../../../core/constants/colors.dart';
import '../../../common/components/auto_leading_widget.dart';
import '../../../common/dialog/ui_dialogs.dart';
import '../controller/notifier/onboarding_create_journey_notifier.dart';
import '../controller/notifier/onboarding_stage_sum_notifier.dart';
import '../provider/onboarding_provider.dart';
import '../widget/build_info_message.dart';

@RoutePage()
class OnboardingDetailsPage extends ConsumerStatefulWidget {
  const OnboardingDetailsPage({super.key});

  @override
  ConsumerState<OnboardingDetailsPage> createState() =>
      _OnboardingDetailsPageState();
}

class _OnboardingDetailsPageState extends ConsumerState<OnboardingDetailsPage> {
  late FocusNode qid, mobileNumber, sendCode;
  TextEditingController qidController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  GlobalKey<FormState> qidMobileFormKey = GlobalKey<FormState>();
  bool isCheckBoxEnabled = false;
  bool isCreateJourneyVerified = false;
  // bool isSubmittedRequest = true;

  @override
  void initState() {
    super.initState();
    qid = FocusNode();
    mobileNumber = FocusNode();
    sendCode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    qid.dispose();
    mobileNumber.dispose();
    sendCode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final qidMobileValidatorProvider = ref.read(
      qidMobileValidatorNotifierProvider.notifier,
    );
    final currentStageIndex = ref.watch(
      currentStageProvider,
    ); // Current stage index
    final stageDataProvider = ref.watch(stageSumProvider);
    final currentStage = getStageById(ref, "OPEN_NEW_ACC_DTL");

    final stageSumState = ref.watch(getOnboardingStageSumNotifierProvider);

    // ref.listen(onboardingSaveStageDataNotifierProvider, (previous, next) {
    // if(!(ref.watch(isSubmittedRequestProvider))){
    //   next.maybeWhen(
    //     data: (response) {
    //       // Handle successful response
    //       ref.read(isSubmittedRequestProvider.notifier).state = true;
    //       context.router.push(const OnboardingOtpRoute());
    //     },
    //     error: (error, stackError) =>
    //         UiDialogs.showErrorDialog(
    //           context: context,
    //           description: "$error",
    //           bknOkPressed: () {
    //             context.router.maybePop();
    //           },
    //         ),
    //     loading: () {
    //       // Optionally handle loading state
    //       Center(
    //           child: UiLoader(
    //               loadingText: ref.getLocaleString("submitting",
    //                   defaultValue: "submitting...")));
    //     },
    //     orElse: () {},
    //   );
    // }
    // });

    ref.listen(getOnboardingCreateJourneyNotifierProvider, (previous, next) {
      if (!isCreateJourneyVerified) {
        next.maybeWhen(
          orElse: () {},
          data: (data) async {
            // ref.read(customerJourneyId.notifier).state = data.custJourneyId;
            // ref.read(retrieveJourneyProvider.notifier).state = data;
            isCreateJourneyVerified = true;
            qidMobileFormKey.currentState?.reset();

            // ref.read(isSubmittedRequestProvider.notifier).state = false;
            //
            bool value = await ref
                .read(onboardingSaveStageDataNotifierProvider.notifier)
                .fetch(
                  custJourneyId: ref.watch(customerJourneyId),
                  stageId: "${currentStage?.stageId}",
                  data: {
                    "QID": qidController.text,
                    "Mobile No": mobileController.text,
                    "T & c": "YES",
                  },
                );
            if (value) {
              ref.read(getQidNumber.notifier).state = qidController.text;
              ref.read(getMobileNumber.notifier).state = mobileController.text;

              ref.read(isFromSignatureVerifiedProvider.notifier).state = false;

              context.router.push(const OnboardingOtpRoute());
            } else {
              UiDialogs.showErrorDialog(
                context: context,
                description: "Data Not Saved",
                bknOkPressed: () {
                  qidMobileFormKey.currentState?.reset();
                  context.router.maybePop();
                },
              );
            }
          },
          error: (error, stackError) => UiDialogs.showErrorDialog(
            context: context,
            description: "$error",
            bknOkPressed: () {
              qidMobileFormKey.currentState?.reset();
              context.router.maybePop();
            },
          ),

          loading: () => Center(
            child: UiLoader(
              loadingText: ref.getLocaleString(
                "Loading",
                defaultValue: "Loading...",
              ),
            ),
          ),
        );
      }
    });

    return Scaffold(
      appBar: const UIAppBar.secondary(
        autoLeadingWidget: AutoLeadingWidget(),
        title: "Open New Account",
        appBarColor: DefaultColors.white,
      ),
      body: SizedBox.expand(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Form(
                    key: qidMobileFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeaderText(),
                        const SizedBox(height: 20),
                        SizedBox(
                          child: Column(
                            children: [
                              _buildQidField(qidMobileValidatorProvider),
                              // _buildInputField('QID'),
                              const SizedBox(height: 20),
                              _buildMobileNumberField(
                                qidMobileValidatorProvider,
                              ),
                              // _buildInputField('Mobile Number'),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        buildInfoMessage(
                          "!",
                          "You have 30 days to finish the process.if you aren’t able to finish the process now, you’ll be able to continue it later by inserting your phone number & QID here.",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            _buildAgreeNotes(context),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
              child: _buildActionButtons(context),
            ),
            const UiSpace.vertical(20),
          ],
        ),
      ),
    );
  }

  Widget _buildQidField(QidMobileValidatorNotifier qidMobileValidatorProvider) {
    return UIFormTextField.underlined(
      controller: qidController,
      borderColor: DefaultColors.grayE6,
      // label: "QID",
      labelUiText: const UiTextNew.h4Regular(
        "QID",
        color: DefaultColors.white_800,
      ),
      labelTextStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        fontFamily: 'Rubik',
        color: DefaultColors.white_800,
      ),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 2.0, // Add consistent horizontal padding
      ),
      maxLength: 20,
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^[0-9]*$'))],
      validator: qidMobileValidatorProvider.validateQid,
      textInputType: TextInputType.number,
      hintText: ref.getLocaleString("enter_qid", defaultValue: "Enter QID"),
      focus: qid,
      onFieldSubmitted: (String value) {
        qid.unfocus();
        FocusScope.of(context).requestFocus(mobileNumber);
      },
      onChanged: (String val) {
        setState(() {});
      },
      height: 38,
    );
  }

  Widget _buildMobileNumberField(
    QidMobileValidatorNotifier qidMobileValidatorProvider,
  ) {
    return UIFormTextField.underlined(
      controller: mobileController,
      labelUiText: const UiTextNew.h4Regular(
        "Mobile Number",
        color: DefaultColors.white_800,
      ),
      borderColor: DefaultColors.grayE6,
      contentPadding: const EdgeInsets.symmetric(
        vertical: 9.0,
        horizontal: 2.0, // Add consistent horizontal padding
      ),

      labelTextStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        fontFamily: 'Rubik',
        color: DefaultColors.white_800,
      ),
      maxLength: 20,
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^[0-9]*$'))],
      validator: qidMobileValidatorProvider.validateMobileNumber,
      textInputType: TextInputType.number,
      hintText: ref.getLocaleString(
        "Mobile Number",
        defaultValue: "Enter Mobile Number",
      ),
      focus: mobileNumber,
      onFieldSubmitted: (String value) {
        mobileNumber.unfocus();
        FocusScope.of(context).requestFocus(sendCode);
      },
      onChanged: (String val) {
        setState(() {});
      },
      height: 38,
      prefixIcon: const Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "+974  ",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontFamily: 'Rubik',
                color: DefaultColors.white_800,
              ),
            ),
            SizedBox(height: 10, child: VerticalDivider()),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return UIButton.rounded(
      focus: sendCode,
      backgroundColor: DefaultColors.blue_300,
      margin: const EdgeInsets.symmetric(vertical: 0),
      isDisabled:
          qidController.text.isEmpty ||
          mobileController.text.isEmpty ||
          !isCheckBoxEnabled ||
          !qidMobileFormKey.currentState!.validate(),
      onPressed: () async {
        FocusScope.of(context).requestFocus(FocusNode());
        final form = qidMobileFormKey.currentState;
        if (!form!.validate()) {
          UiToast().showFlagMsg(
            context: context,
            msg: ref.getLocaleString("Validation_Error"),
            level: ToastLevel.error,
          );
          return;
        }
        form.save();
        isCreateJourneyVerified = false;
        await ref
            .read(getOnboardingCreateJourneyNotifierProvider.notifier)
            .fetch(
              nationalId: qidController.text,
              mobileNumber: mobileController.text,
            );
      },
      maxWidth: context.screenWidth,
      height: 40,
      label: ref.getLocaleString("Send Code", defaultValue: "Send Code"),
    );
  }

  Widget _buildAgreeNotes(BuildContext context) {
    return UiAgreeNotes(
      agreeNoteActive: true,
      text: "I agree to terms & conditions",
      substringIndex: 10,
      onUserAgreed: (_) {
        setState(() {
          isCheckBoxEnabled = !isCheckBoxEnabled;
        });
      },
      openTermsAndConditions: () {
        showDialog(
          context: context,
          builder: (context) => SimpleDialog(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 24,
            ),
            children: [
              // const UiSpace.vertical(10),
              Image.asset(
                AssetPath.image.new_logo, // Replace with the actual image path
                height: 43.7,
                alignment: Alignment.center,
              ),
              const UiSpace.vertical(20),
              const UiTextNew.customRubik(
                "Terms and Conditions",
                fontSize: 18,
                color: DefaultColors.white_800,
                textAlign: TextAlign.center,
              ),
              const UiSpace.vertical(20),
              const UiTextNew.h4Regular(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi nec quam a urna egestas mattis. Vivamus sit amet feugiat nulla, sed luctus est. Cras quis sapien congue, eleifend lectus ut, mollis turpis. In eget turpis nisl. Nullam accumsan erat ex, eu euismod purus elementum sit amet. Morbi ut vulputate mauris. In justo ante, dignissim nec odio non, pellentesque pretium ipsum.",
                textAlign: TextAlign.left,
                color: DefaultColors.white_800,
              ),
              const UiSpace.vertical(20),

              const UiTextNew.h4Regular(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi nec quam a urna egestas mattis. Vivamus sit amet feugiat nulla, sed luctus est. Cras quis sapien congue, eleifend lectus ut, mollis turpis. In eget turpis nisl. Nullam accumsan erat ex, eu euismod purus elementum sit amet. Morbi ut vulputate mauris. In justo ante, dignissim nec odio non, pellentesque pretium ipsum.",
                textAlign: TextAlign.left,
                color: DefaultColors.white_800,
              ),
              const UiSpace.vertical(30),

              UIButton.rounded(
                label: "Ok",
                backgroundColor: DefaultColors.blue_300,
                onPressed: () {
                  context.router.maybePop();
                },
                maxWidth: double.maxFinite,
              ),
            ],
          ),
        );
      },
    );
  }

  void _showErrorDialog(String message) {
    UIPopupDialog().showPopup(
      viewModel: UIPopupViewModel(
        image: AssetPath.svg.error,
        context: context,
        imageSize: 80,
        barrierDismissible: false,
        title: ref.getLocaleString("Error"),
        content: message,
        buttonText: ref.getLocaleString("OK"),
        onButtonPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}

Widget _buildHeaderText() {
  return const UiTextNew.customRubik(
    "Insert QID & Phone Number",
    fontSize: 18,
    color: Colors.black,
  );
}

Widget _buildInputField(String label) {
  return UIInputFieldRetail.underlined(
    hintText: label,
    label: label,
    height: 65,
  );
}

Widget _buildSendCodeButton(BuildContext context, ref) {
  return ActionButtonWidget(
    text: "Send Code",
    onPressed: () {
      final data = ref.watch(getOnboardingRetrieveJourneyNotifierProvider);
      context.router.push(const OnboardingOtpRoute());
    },
  );
}
