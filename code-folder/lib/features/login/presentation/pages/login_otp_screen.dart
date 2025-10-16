import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:dkb_retail/features/login/domain/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_session_timeout/local_session_timeout.dart';
import 'package:pinput/pinput.dart';

import 'package:dkb_retail/core/constants/app_strings/default_string.dart';
import 'package:dkb_retail/features/common/presentation/components/auth_header_wrapper.dart';

import '../../../../core/cache/global_cache.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/services/session_manager/session_manager.dart';
import '../../../common/data/models/otp_generate_models/generate_otp_request.dart';
import '../../../common/data/models/otp_generate_models/generate_otp_request_request_info_dto.dart';
import '../../../common/data/models/otp_validate_models/validate_otp_request.dart';
import '../../../common/data/models/otp_validate_models/validate_otp_request_request_info_dto.dart';
import '../../../common/domain/locators/common_locators.dart';
import '../../../common/presentation/components/dialogs.dart';
import '../../domain/entities/sign_with_credentials_entity/login_response.dart';
import '../controller/state/login_notifiers.dart';

@RoutePage()
class LoginOtpPage extends ConsumerStatefulWidget {
  final LoginResponse userDetails;

  const LoginOtpPage({super.key, required this.userDetails});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CommonOtpPageState();
}

class _CommonOtpPageState extends ConsumerState<LoginOtpPage> {
  late Timer _timer;
  bool canResend = false;
  final FocusNode otpFocusNode = FocusNode();
  late TextEditingController otpController;
  late int _remainingSeconds;
  String otpLenght = '';

  @override
  void initState() {
    super.initState();
    otpController = TextEditingController();
    _startTimer();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(otpFocusNode);
    });
  }

  void _startTimer() {
    _remainingSeconds = 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() => _remainingSeconds--);
      } else {
        _timer.cancel();
        setState(() => canResend = true);
      }
    });
  }

  String get _formattedTime {
    final minutes = (_remainingSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_remainingSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  void dispose() {
    _timer.cancel();
    otpFocusNode.dispose();
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.07,
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: DefaultColors.black,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(12),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: DefaultColors.blue60),
      borderRadius: BorderRadius.circular(12),
    );

    ref.listen(loginNotifierProvider, (previous, next) {
      next.maybeWhen(
        failure: (message) async {
          _resetForm();
          showErrorDialog(message, context, ref);
        },
        otpValid: () async {
          _resetForm();
          _handleOtpSuccess();
        },
        orElse: () {},
      );
    });

    return PopScope(
      canPop: false,

      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  width: double.infinity,
                  child: UIButton.rounded(
                    height: 48,
                    btnCurve: 30,
                    isDisabled: otpController.text.length == 6 ? false : true,
                    backgroundColor: DefaultColors.blue9D,
                    txtColor: Colors.white,
                    onPressed: () {
                      if (otpController.text.length == 6) {
                        verifyOtp(otpController.text);
                      }
                    },
                    label: DefaultString.instance.verify,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: AuthHeaderWrapper(
          headerText: DefaultString.instance.enterOtp,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UiSpace.vertical(20),

              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.04,
                ),
                child: UiTextNew.b1Semibold(
                  DefaultString.instance.otpReceiveMessage,
                  maxLines: 2,
                ),
              ),
              UiSpace.vertical(20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Center(
                  child: Pinput(
                    controller: otpController,
                    focusNode: otpFocusNode,
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: focusedPinTheme,
                    length: 6,
                    onChanged: (value) {
                      if (value.length == 6) {
                        verifyOtp(otpController.text);
                      }
                    },
                  ),
                ),
              ),
              UiSpace.vertical(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  !canResend
                      ? UiTextNew.b14Regular(
                          'Resend in $_formattedTime',
                          color: DefaultColors.grey_05,
                          textAlign: TextAlign.center,
                        )
                      : SizedBox(),
                  canResend
                      ? GestureDetector(
                          onTap: _startTimer,
                          child: UiTextNew.b14Regular(
                            "Resend OTP",
                            decoration: TextDecoration.underline,
                            decorationColor: DefaultColors.blue9D,
                            color: DefaultColors.blue9D,
                            textAlign: TextAlign.center,
                          ),
                        )
                      : SizedBox(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _resetForm() {
    otpController.clear();
  }

  void verifyOtp(String otp) async {
    final request = ValidateOtpRequest(
      requestInfo: ValidateOtpRequestRequestInfoDto(otp: otp),
    );
    await ref.read(commonRepositoryProvider).validateOtp(request: request);
  }

  Future _handleOtpSuccess() async {
    ref.read(sessionStateStreamProvider).add(SessionState.startListening);

    await GlobalCache.instance.setUsername(widget.userDetails.userId);

    if (mounted) {
      context.router.popAndPush(DashboardRoute());
    }
  }
}
