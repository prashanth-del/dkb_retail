import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:dkb_retail/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';

@RoutePage()
class RegisterationOtpPage extends ConsumerStatefulWidget {
  const RegisterationOtpPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RegisterationOtpPageState();
}

class _RegisterationOtpPageState extends ConsumerState<RegisterationOtpPage> {
  late Timer _timer;
  bool canResend = false;
  final FocusNode otpFocusNode = FocusNode();
  TextEditingController otpController = TextEditingController();
  int _remainingSeconds = 0;

  @override
  void initState() {
    super.initState();
    startTimer();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(otpFocusNode);
    });
  }

  void startTimer() {
    _remainingSeconds = 15;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      canResend = false;
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        _timer.cancel();
        canResend = true;
        setState(() {});
      }
    });
  }

  String get _formattedTime {
    final minutes = (_remainingSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_remainingSeconds % 60).toString().padLeft(2, '0');
    return '$minutes: $seconds';
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
      width: 56,
      height: 56,
      textStyle: TextStyle(
        fontSize: 16,
        color: DefaultColors.blue9D,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: DefaultColors.grey_05),
        borderRadius: BorderRadius.circular(12),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: DefaultColors.blue60),
      borderRadius: BorderRadius.circular(12),
    );

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: DefaultColors.white,
      body: Stack(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.topCenter,
                radius: 2,
                colors: [Color.fromARGB(255, 216, 231, 247), Colors.white],
                stops: [0.0, 0.5],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UiSpace.vertical(20),

                SizedBox(
                  height: kToolbarHeight,
                  child: IconButton(
                    onPressed: () {
                      context.router.maybePop();
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: UiTextNew.h2Semibold(
                    'Enter OTP',
                    color: DefaultColors.blue9D,
                  ),
                ),
                UiSpace.vertical(16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: UiTextNew.b14Regular(
                    'You will receive the OTP on your registered mobile number.',
                    maxLines: 2,
                  ),
                ),
                UiSpace.vertical(20),
                Center(
                  child: Pinput(
                    controller: otpController,
                    focusNode: otpFocusNode,
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: focusedPinTheme,
                    length: 6,
                    onSubmitted: (value) {
                      context.router.replace(CreateUsernameRoute());
                    },
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
                            onTap: startTimer,
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
        ],
      ),
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
                  isDisabled: otpController.text.isEmpty ? true : false,
                  backgroundColor: DefaultColors.blue9D,
                  onPressed: () {
                    context.router.push(
                      CommonCreateUsernameRoute(
                        title: 'Create Username',
                        onSubmit: (username) {
                          context.router.push(
                            CommonSetPasswordRoute(
                              title: "Set New Password",
                              buttonLabel: "Confirm Password",
                              onConfirmed: (password) {
                                context.router.push(UserInterestsRoute());
                              },
                            ),
                          );
                        },
                      ),
                    );
                  },
                  label: 'Verify',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
