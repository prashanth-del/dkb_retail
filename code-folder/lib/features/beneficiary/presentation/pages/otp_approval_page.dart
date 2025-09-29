import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:dkb_retail/core/constants/asset_path/asset_path.dart';
import 'package:dkb_retail/core/i18n/controller/i18n_providers.dart';
import 'package:dkb_retail/core/utils/extensions/locale_extension.dart';
import 'package:dkb_retail/features/common/components/auto_leading_widget.dart';
import 'package:dkb_retail/features/login/presentation/widgets/resend_otp_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class OtpApprovalPage extends ConsumerStatefulWidget {
  final VoidCallback onSubmit;

  const OtpApprovalPage({super.key, required this.onSubmit});

  @override
  ConsumerState<OtpApprovalPage> createState() => _OtpPageState();
}

class _OtpPageState extends ConsumerState<OtpApprovalPage> {
  final TextEditingController otpController = TextEditingController();
  int otpAttempts = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String attemptString = "Attempt # of ##";
    attemptString = attemptString.replaceFirst("#", "$otpAttempts");
    attemptString = attemptString.replaceFirst("##", "6");

    maxCall(String msg) async {
      UiToast().showFlagMsg(
        context: context,
        msg: msg,
        level: ToastLevel.error,
      );
    }

    void onSuccess() {
      widget.onSubmit();
      context.router.back();
    }

    void beneSuccess() {
      widget.onSubmit();
      context.router.back();
    }

    void onFailure(String error) {
      setState(() {
        otpAttempts++;
      });

      if (otpAttempts == 6) {
        maxCall("");
      } else {
        UiToast().showFlagMsg(
          context: context,
          msg: error,
          level: ToastLevel.error,
        );
      }
    }

    void onOtpResent() {
      UiToast().showFlagMsg(
        context: context,
        msg: ('OTP resent successfully!'),
        level: ToastLevel.success,
      );
    }

    UIAppBar buildAppBar() {
      return const UIAppBar.secondary(
        title: "OTP Authentication",
        autoLeadingWidget: AutoLeadingWidget(),
        iconWidth: 20,
        iconHeight: 20,
      );
    }

    Widget buildOtpInputField() {
      return UIOtpField(
        pinPutController: otpController,
        length: 6,
        onChanged: (val) {
          setState(() {});
        },
      );
    }

    Widget buildSubmitButton() {
      return UIButton.rounded(
        backgroundColor: DefaultColors.blue60,
        isDisabled: otpController.text.length != 6,
        height: 40,
        onPressed: () {
          widget.onSubmit();
        },
        label: "SUBMIT",
        maxWidth: double.infinity,
      );
    }

    Widget buildOtpIcon() {
      return SvgPicture.asset(AssetPath.icon.otp).vertical(20);
    }

    Widget buildOtpInstructionText(BuildContext context) {
      return const UiTextNew.b2Regular(
        "e-OTP has been sent to your registered mobile number/email. Please enter the same to proceed further.",
        textAlign: TextAlign.center,
        lineHeight: 1.2,
        color: DefaultColors.gray2D,
      );
    }

    Widget buildOtpTimer(BuildContext context) {
      return ResendOtpTimer(
        onResend: () async {
          otpController.clear();
        },
        isPaused: false,
      );
    }

    Widget buildAttemptInfoText(BuildContext context) {
      return SizedBox(
        height: 16,
        child: UiTextNew.b2Medium(
          "Current attempt #$otpAttempts",
          lineHeight: 1,
          spacing: 0,
          color: DefaultColors.gray54,
        ),
      );
    }

    Widget buildBody(BuildContext context) {
      return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 50).copyWith(top: 50),
        child: Center(
          child: Column(
            children: [
              buildOtpIcon(),
              buildOtpInstructionText(context).vertical(30),
              buildOtpInputField(),
              buildSubmitButton().vertical(15),
              buildOtpTimer(context).vertical(10),
              buildAttemptInfoText(context).vertical(5),
              _buildMaxAttemptsInfoText(context, attemptString),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: DefaultColors.white_f3,
      appBar: buildAppBar(),
      body: buildBody(context),
    );
  }

  Widget _buildMaxAttemptsInfoText(BuildContext context, String text) {
    return const SizedBox(
      height: 16,
      child: UiTextNew.b2Medium(
        "(Note:Maximum 3 attempts only)",
        spacing: 0,
        lineHeight: 1,
        color: DefaultColors.gray54,
      ),
    );
  }
}
