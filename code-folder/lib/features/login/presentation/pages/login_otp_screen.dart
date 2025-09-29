import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_session_timeout/local_session_timeout.dart';
import 'package:pinput/pinput.dart';

import '../../../../core/cache/global_cache.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/services/session_manager/session_manager.dart';
import '../../../../network/domain/models/auth_tokens.dart';
import '../../../../network/network_client_provider.dart';
import '../../../common/components/dialogs.dart';
import '../../domain/entities/user.dart';
import '../controller/state/login_notifiers.dart';

@RoutePage()
class LoginOtpPage extends ConsumerStatefulWidget {
  final User userdetail;
  const LoginOtpPage({super.key, required this.userdetail});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OtpPageState();
}

class _OtpPageState extends ConsumerState<LoginOtpPage> {
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

    ref.listen(loginNotifierProvider, (previous, next) {
      next.maybeWhen(
        failure: (message) async {
          showErrorDialog(message, context, ref);
        },
        maxAttempted: (message) async {
          showErrorDialog(message, context, ref);
        },
        otpValid: () async {
          await _handleOtpSuccess(widget.userdetail);
        },
        orElse: () {},
      );
    });

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: DefaultColors.white,
      body: UiBackgroundWrapper(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UiSpace.vertical(40),
              CommonAuthAppBar(title: 'Enter OTP'),
              UiSpace.vertical(16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: UiTextNew.b14Regular(
                  'You will receive the OTP on your registered mobile number.',
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
                  isDisabled: otpController.text.length == 6 ? false : true,
                  backgroundColor: DefaultColors.blue9D,
                  txtColor: Colors.white,
                  onPressed: () {
                    if (otpController.text.length == 6) {
                      verifyOtp(otpController.text);
                    }
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

  void verifyOtp(String otp) async {
    ref.read(loginNotifierProvider.notifier).validateOtp(otp);
  }

  Future _handleOtpSuccess(User user) async {
    ref.read(sessionStateStreamProvider).add(SessionState.startListening);

    if (user.atkn != null && user.reftkn != null) {
      ref.read(authTokenProvider.notifier).state = AuthTokens(
        atkn: user.atkn!,
        reftkn: user.reftkn!,
      );
    }

    await GlobalCache.instance.setPreferenceSeen();
    print('Username to be saved: ${widget.userdetail.username}');
    await GlobalCache.instance.setUsername(
      widget.userdetail.username ?? 'chetan',
    );

    if (mounted) {
      context.router.popAndPush(DashboardRoute());
    }
  }
}
