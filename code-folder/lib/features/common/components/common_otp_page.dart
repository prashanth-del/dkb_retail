import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:dkb_retail/core/utils/extensions/locale_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';

@RoutePage()
class CommonOtpPage extends ConsumerStatefulWidget {
  final String title;
  final String description;
  final int otpLength;
  final Duration timerDuration;
  final VoidCallback onResend;
  final ValueChanged<String> onVerify;
  final ValueChanged<String>? onCompleted;
  final VoidCallback? suffixTap;
  final String verifyButtonLabel;

  const CommonOtpPage({
    super.key,
    required this.title,
    required this.description,
    this.otpLength = 6,
    this.timerDuration = const Duration(seconds: 30),
    required this.onResend,
    required this.onVerify,
    this.suffixTap,
    this.onCompleted,
    this.verifyButtonLabel = "Verify",
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CommonOtpPageState();
}

class _CommonOtpPageState extends ConsumerState<CommonOtpPage> {
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
    _remainingSeconds = widget.timerDuration.inSeconds;
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

    return PopScope(
      canPop: false,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,

        body: SingleChildScrollView(
          child: UiBackgroundWrapper(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UiSpace.vertical(40),
                CommonAuthAppBar(
                  title: widget.title ?? 'Enter OTP',
                  showBackButton: false,
                  suffix: InkWell(
                    onTap: widget.suffixTap,
                    child: Text(
                      'cancel',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.aspectRatio * 35,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                UiSpace.vertical(16),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.04,
                  ),
                  child: UiTextNew.b1Regular(
                    widget.description ??
                        'You will receive otp on your register mobile number',
                    maxLines: 2,
                  ),
                ),
                UiSpace.vertical(20),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.04,
                  ),
                  child: Center(
                    child: Pinput(
                      obscureText: true,
                      controller: otpController,
                      focusNode: otpFocusNode,
                      defaultPinTheme: defaultPinTheme,
                      focusedPinTheme: focusedPinTheme,
                      length: widget.otpLength,
                      onSubmitted: widget.onVerify,
                      onCompleted: widget.onCompleted,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      onChanged: (value) {
                        otpLenght = value;
                        setState(() {});
                      },
                    ),
                  ),
                ),
                UiSpace.vertical(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    !canResend
                        ? Text(
                            "Resend in $_formattedTime",
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              setState(() => canResend = false);
                              _startTimer();
                              otpController.clear();
                              widget.onResend();
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                FocusScope.of(
                                  context,
                                ).requestFocus(otpFocusNode);
                              });
                            },
                            child: Text(
                              ref.getLocaleString(
                                "Resend OTP",
                                defaultValue: "Resend OTP",
                              ),
                              style: TextStyle(
                                color: DefaultColors.blue9D,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w500,
                                decorationColor: DefaultColors.blue9D,
                              ),
                            ),
                          ),
                  ],
                ),
              ],
            ),
          ),
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
                    isDisabled:
                        otpController.text.isEmpty || otpLenght.length < 6
                        ? true
                        : false,
                    txtColor: Colors.white,
                    onPressed: otpController.text.isNotEmpty
                        ? () {
                            widget.onVerify(otpController.text);
                          }
                        : null,
                    label: widget.verifyButtonLabel,
                    backgroundColor: DefaultColors.blue98,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
