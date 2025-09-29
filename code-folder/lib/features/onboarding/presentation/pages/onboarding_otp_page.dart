import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:flutter/material.dart';
import 'package:dkb_retail/core/router/app_router.dart';
import 'package:dkb_retail/core/utils/extensions/locale_extension.dart';
import 'package:dkb_retail/features/onboarding/data/model/onboarding_stage_sum_model.dart';
import 'package:dkb_retail/features/onboarding/presentation/provider/onboarding_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/asset_path/asset_path.dart';
import '../../../common/components/auto_leading_widget.dart';
import '../../../common/dialog/ui_dialogs.dart';
import '../../../login/presentation/controller/login_providers.dart';
import '../../../login/presentation/controller/state/login_notifiers.dart';
import '../../../login/presentation/widgets/resend_otp_timer.dart';
import '../controller/notifier/onboarding_save_stage_data_notifier.dart';

@RoutePage()
class OnboardingOtpPage extends ConsumerStatefulWidget {
  // final TransactionDetailsParam transactionDetailsParam;

  const OnboardingOtpPage({super.key,});

  @override
  ConsumerState<OnboardingOtpPage> createState() => _OnboardingOtpPageState();
}

class _OnboardingOtpPageState extends ConsumerState<OnboardingOtpPage> {
  final TextEditingController otpController = TextEditingController();
  int otpAttempts = 1;

  @override
  Widget build(BuildContext context) {
    // final isLoading = ref.watch(approalOtpLoadingProvider);
    _listenToOtpNotifier(); // Listen to state changes
    final currentStage = getStageById(ref, "OPEN_NEW_ACC_DTL");

    return UiProgressHud(
      inAsyncCall: false,
      progressIndicator: UiLoader(
          loadingText:
          ref.getLocaleString("Loading", defaultValue: "Loading...")),
      child: Scaffold(
        backgroundColor: DefaultColors.white_f3,
        appBar: _buildAppBar(),
        body: _buildBody(context),
      ),
    );
  }

  // Method to listen to the approval OTP notifier
  void _listenToOtpNotifier() {
    // ref.listen(loginNotifierProvider, (previous, state) {
    //   state.maybeWhen(
    //     orElse: () {},
    //     success: () ,
    //     failure: (error) => _onFailure(error),
    //     otpResent: () => _onOtpResent(),
    //     maxAttempted: (msg) async {
    //       // UiToast()
    //       //     .showFlagMsg(context: context, msg: msg, level: ToastLevel.error);
    //       // await ref.read(loginNotifierProvider.notifier).logout();
    //       // final logoutStatus = ref.watch(logoutStatusProvider);
    //       // if (logoutStatus == LogoutStatus.success && mounted) {
    //       //   context.router.popUntil((route) => route.isFirst);
    //       // }
    //     },
    //     loading: () {},
    //   );
    // });
    ref.listen(loginNotifierProvider, (_, state) {
      state.maybeWhen(
          orElse: () {},
          failure: (message) {
            otpController.clear();
            otpAttempts++;
            // UiToast().showFlagMsg(
            //     context: context, msg: message, level: ToastLevel.error);
          },
          otpValid: () {
            if(ref.read(isFromSignatureVerifiedProvider)) {
              ref.read(isFromSignatureVerifiedProvider.notifier).state = false;
              context.router.push(const OnboardingCreatingAccountRoute());
            }
            else {
              context.router.push(const OnboardingSelectBranchRoute());

            }

          },
          maxAttempted: (msg) async {
            UiToast().showFlagMsg(
                context: context, msg: msg, level: ToastLevel.error);
            },
          otpResent: () {
            UiToast().showFlagMsg(
                context: context,
                msg: ref.getLocaleString("OTP_resent_successfully!"),
                level: ToastLevel.success);
          });
    });

  }

  // Navigation on success
  void _onSuccess() {
    // context.router.popAndPush(StatusRoute(
    //   transactionDetailsParam: widget.transactionDetailsParam,
    // ));
  }

  // Show error message on failure
  void _onFailure(String error) {
    otpAttempts++;
    UiToast().showFlagMsg(
      context: context,
      msg: error,
      level: ToastLevel.error,
    );
  }

  // Show success message on OTP resent
  void _onOtpResent() {
    UiToast().showFlagMsg(
      context: context,
      msg: 'OTP_resent_successfully!',
      level: ToastLevel.success,
    );
  }

  // Build the app bar
  UIAppBar _buildAppBar() {
    return const UIAppBar.secondary(
      title: "OTP Authentication",
      autoLeadingWidget: AutoLeadingWidget(),
      iconWidth: 20,
      iconHeight: 20,
    );
  }

  // Build the main body of the page
  Widget _buildBody(BuildContext context) {
    final currentStage1 = getStageById(ref, "VALIADATE_OTP");
    final currentStage2 = getStageById(ref, "OTP");

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 50),
      child: Center(
        child: Column(
          children: [
            _buildOtpIcon(),
            _buildOtpInstructionText(context).vertical(30),
            _buildOtpInputField().vertical(20),
            _buildSubmitButton(currentStage1!, currentStage2!).vertical(15),
            _buildOtpTimer(context).vertical(20),
            _buildAttemptInfoText(context).vertical(5),
            // _buildMaxAttemptsInfoText(context), // Uncomment to show max attempt text
          ],
        ),
      ),
    );
  }

  // Build the OTP input field
  Widget _buildOtpInputField() {
    return UIOtpField(
      pinPutController: otpController,
      length: 6,
      onChanged: (val) {
        setState(() {});
      },
    );
  }

  Widget _buildSubmitButton(StageData currentStage1, StageData currentStage2) {
    final isLoading = ref.watch(loadingProvider);
    return UIButton.rounded(
      isDisabled: otpController.text.length != 6,
      height: 40,
      backgroundColor: DefaultColors.blue_300,
      onPressed: false
          ? null
          : ()async {
        // ref.read(isSubmittedRequestProvider.notifier).state = false;
        //
        if(ref.read(isFromSignatureVerifiedProvider)) {
          bool value = await ref.read(onboardingSaveStageDataNotifierProvider.notifier).fetch(
              custJourneyId: ref.watch(customerJourneyId),
              stageId: currentStage2.stageId,
              data: {
                "OTP":"YES",
              });
          if(value == true) {
            // ref.read(isFromSignatureVerifiedProvider.notifier).state = false;
            context.router.push(const OnboardingCreatingAccountRoute());
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
          bool value = await ref.read(onboardingSaveStageDataNotifierProvider.notifier).fetch(
              custJourneyId: ref.watch(customerJourneyId),
              stageId: currentStage1.stageId,
              data: {
                "Validate_OTP":"YES",
              });
          if(value == true) {
              context.router.push(const OnboardingSelectBranchRoute());
          } else {
            UiDialogs.showErrorDialog(
              context: context,
              description: "Error Caught",
              bknOkPressed: () {
                context.router.maybePop();
              },
            );
          }

        }


        // ref
        //     .read(loginNotifierProvider.notifier)
        //     .validateOtp(otpController.text);
      },
      label: "Submit",
      maxWidth: double.infinity,
    );
  }

  Widget _buildOtpIcon() {
    return SvgPicture.asset(
      AssetPath.icon.otpRetailIcon,
    ).vertical(20);
  }

  Widget _buildOtpInstructionText(BuildContext context) {
    return const UiTextNew.h4Regular(
      "e-OTP has been sent to your registered mobile number/email. Please enter the same to proceed further.",
      textAlign: TextAlign.center,
      lineHeight: 1.2,
      color: DefaultColors.white_800,
    );
  }

  Widget _buildOtpTimer(BuildContext context) {
    return ResendOtpTimer(
      onResend: () async {
        otpController.clear();
        // await ref.read(approvalOtpNotifierProvider.notifier).resendOtp();
      },
      isPaused: false,
    );
  }

  Widget _buildAttemptInfoText(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          UiTextNew.h4Regular(
          "${"Current attempt"} #$otpAttempts",
          lineHeight: 1,
          spacing: 0,
          color: DefaultColors.gray8A,
        ),
          const SizedBox(height: 20,),
          const UiTextNew.h4Regular(
            "(Note:Maximum 3 attempts only)",
            lineHeight: 1,
            spacing: 0,
            color: DefaultColors.gray8A,
          ),
      ]
      ),
    );
  }
}
