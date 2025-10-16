import 'package:auto_route/auto_route.dart';
import 'package:dkb_retail/features/common/presentation/dialog/ui_dialogs.dart';
import 'package:dkb_retail/features/forgot_password/presentation/providers/forget_password_providers.dart';
import 'package:dkb_retail/features/login/domain/entities/sign_with_credentials_entity/login_response.dart';
import 'package:dkb_retail/features/login/presentation/controller/login_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';

import '../../../../core/constants/app_strings/default_string.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/i18n/controller/i18n_notifiers.dart';
import '../../../../core/router/app_router.dart';
import '../../../../network/network_client_provider.dart';
import '../../../common/presentation/components/common_textfeild_style_2.dart';
import '../../../common/presentation/components/dialogs.dart';
import '../../../login/domain/entities/user.dart';
import '../../../login/presentation/controller/state/login_notifiers.dart';
import '../../../login/presentation/widgets/prayer_time.dart';
import '../controller/welcome_back_providers.dart';

class WelcomeBackBody extends ConsumerStatefulWidget {
  final bool fingerprintAuth;
  const WelcomeBackBody({super.key, this.fingerprintAuth = false});

  @override
  ConsumerState<WelcomeBackBody> createState() => _WelcomeBackBodyState();
}

class _WelcomeBackBodyState extends ConsumerState<WelcomeBackBody> {
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final showAccountBalance = ref.watch(showAccountBalanceProvider);

    final username = ref.watch(localUsernameProvider);

    final isRtl = ref.watch(localePodProvider).languageCode == 'ar';

    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    ref.listen(loginNotifierProvider, (previous, next) {
      next.maybeWhen(
        failure: (message) async {
          _resetForm();
          showErrorDialog(message, context, ref);
        },
        success: (user) async {
          _resetForm();
          _handleLoginSuccess(user!);
        },
        orElse: () {},
      );
    });
    return Column(
      children: [
        const PrayerTimeWidget(),
        SizedBox(height: h * 0.03),

        Container(
          padding: EdgeInsets.all(w * 0.05),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(40),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DefaultString.instance.welcomeBack,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        username,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () => context.router.replace(LoginRoute()),
                    child: Text(
                      DefaultString.instance.switchProfile,
                      style: const TextStyle(
                        color: DefaultColors.white,
                        fontSize: 13,
                        decoration: TextDecoration.underline,
                        decorationColor: DefaultColors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: h * 0.03),

              // UiTextField(
              //   margin: EdgeInsets.zero,
              //   controller: passwordController,
              //   label: DefaultString.instance.enterPassword,
              //   obscureText: true,
              //   cursorColor: Colors.white,
              //   hintTextColor: DefaultColors.white_200,
              //   focusBorderColor: DefaultColors.blue_200,
              //   unfocusBorderColor: DefaultColors.white,
              //   onChanged: (value) {
              //     setState(() {});
              //   },
              // ),
              CustomTextFieldStyle2(
                controller: passwordController,
                onChanged: (value) {
                  setState(() {});
                },
                obscureText: true,
                allowCopyPaste: false,
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'\s')),
                ],
                label: DefaultString.instance.enterPassword,
                floatingLabelBehavior: FloatingLabelBehavior.auto,
              ),

              SizedBox(height: h * 0.02),

              ElevatedButton.icon(
                iconAlignment: IconAlignment.end,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onPressed: () => passwordController.text.isNotEmpty
                    ? _handleLoginPressed()
                    : _authenticate(context, useFingerprint: false),
                icon: passwordController.text.isNotEmpty
                    ? null
                    : Icon(
                        widget.fingerprintAuth
                            ? Icons.fingerprint
                            : Icons.face_retouching_natural,
                      ),
                label: Text(
                  passwordController.text.isNotEmpty
                      ? DefaultString.instance.login
                      : widget.fingerprintAuth
                      ? DefaultString.instance.useFingerprint
                      : DefaultString.instance.useFaceId,
                ),
              ),

              SizedBox(height: h * 0.02),

              InkWell(
                onTap: () => context.router.push(ForgotPasswordRoute()),
                child: Text(
                  DefaultString.instance.forgotUsernamePassword,
                  style: const TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.underline,
                    decorationColor: DefaultColors.white,
                  ),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: h * 0.03),

        Container(
          margin: EdgeInsets.symmetric(horizontal: w * 0.08),
          width: double.infinity,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              iconAlignment: IconAlignment.end,
              backgroundColor: Colors.white,
              animationDuration: const Duration(milliseconds: 500),
              foregroundColor: Colors.black,
              minimumSize: const Size(double.infinity, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            onPressed: () {
              ref.read(showAccountBalanceProvider.notifier).state =
                  !showAccountBalance;
            },
            icon: Icon(
              showAccountBalance
                  ? Icons.visibility
                  : Icons.visibility_off_outlined,
            ),
            label: Text(
              showAccountBalance
                  ? "78699 QAR"
                  : DefaultString.instance.viewAccountBalance,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _authenticate(
    BuildContext context, {
    bool useFingerprint = false,
  }) async {
    final LocalAuthentication auth = LocalAuthentication();

    try {
      final bool isDeviceSupported = await auth.isDeviceSupported();
      final bool canCheckBiometrics = await auth.canCheckBiometrics;

      if (!(isDeviceSupported && canCheckBiometrics)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(DefaultString.instance.biometricNotAvailable)),
        );
        return;
      }

      final List<BiometricType> availableBiometrics = await auth
          .getAvailableBiometrics();

      availableBiometrics.forEach((e) {
        print(e);
      });

      if (useFingerprint) {
        if (availableBiometrics.contains(BiometricType.fingerprint)) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(DefaultString.instance.fingerprintNotAvailable),
            ),
          );
          return;
        }
      } else {
        if (availableBiometrics.contains(BiometricType.face)) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(DefaultString.instance.faceIdNotAvailable)),
          );
          return;
        }
      }

      final bool didAuthenticate = await auth.authenticate(
        localizedReason: useFingerprint
            ? DefaultString.instance.authFingerprintReason
            : DefaultString.instance.authFaceIdReason,
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );

      if (didAuthenticate) {
        if (mounted) {
          context.router.replace(DashboardRoute());
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Authentication error: $e")));
    }
  }

  Future<void> _handleLoginPressed() async {
    if (passwordController.text.trim().isEmpty) {
      UiDialogs.showErrorDialog(
        bknOkPressed: () {
          Navigator.pop(context);
        },
        context: context,
        description: DefaultString.instance.passwordEmptyError,
      );
      return;
    }
    FocusScope.of(context).unfocus();

    final token = ref.read(authTokenProvider);
    if (token != null) {
      ref.read(authTokenProvider.notifier).state = null;
    }

    final username = ref.read(currentUsernameProvider);

    await ref
        .read(loginNotifierProvider.notifier)
        .signWithUsernamePassword(
          customerId: "1207026",
          username: username ?? 'test',
          password: passwordController.text.trim(),
        );
  }

  void _resetForm() {
    passwordController.clear();
  }

  void _handleLoginSuccess(LoginResponse user) {
    context.router.push(LoginOtpRoute(userDetails: user));
  }
}
