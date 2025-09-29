import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/db_uicomponents.dart' hide DefaultColors;
import 'package:dkb_retail/core/constants/colors.dart';
import 'package:dkb_retail/core/router/app_router.dart';
import 'package:dkb_retail/features/common/dialog/custom_sheet.dart';
import 'package:dkb_retail/features/login/presentation/widgets/login_app_bar.dart';
import 'package:dkb_retail/features/login/presentation/widgets/login_bottom_bar.dart';
import 'package:dkb_retail/features/login/presentation/widgets/prayer_time.dart';
import 'package:dkb_retail/features/rashid/presentation/pages/rashid_widget.dart';
import 'package:dkb_retail/features/welcome_back/presentation/controller/welcome_back_providers.dart';
import 'package:dkb_retail/features/welcome_back/presentation/widgets/enter_mpin_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_session_timeout/local_session_timeout.dart';

import '../../../../core/constants/asset_path/asset_path.dart';
import '../../../../core/services/session_manager/session_manager.dart';
import '../../../../network/domain/models/auth_tokens.dart';
import '../../../../network/network_client_provider.dart';
import '../../../common/components/dialogs.dart';
import '../../../common/dialog/ui_dialogs.dart';
import '../../../login/domain/entities/user.dart';
import '../../../login/presentation/controller/state/login_notifiers.dart';

@RoutePage()
class WelcomeBackScreen extends ConsumerStatefulWidget {
  final bool fingerprintAuth;
  const WelcomeBackScreen({super.key, this.fingerprintAuth = false});

  @override
  ConsumerState<WelcomeBackScreen> createState() => _WelcomeBackScreenState();
}

class _WelcomeBackScreenState extends ConsumerState<WelcomeBackScreen> {
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final showAccountBalance = ref.watch(showAccountBalanceProvider);

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
          _handleLoginSuccess(user);
        },
        orElse: () {},
      );
    });

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => FocusScope.of(context).unfocus(), // dismiss keyboard
      child: Scaffold(
        floatingActionButton: rashid(context),
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AssetPath.image.background),
              fit: BoxFit.cover,
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: w * 0.04,
            vertical: h * 0.015,
          ),
          child: SafeArea(
            child: Column(
              children: [
                // Top bar
                LoginAppBar(animatedProfile: true),

                SizedBox(height: h * 0.075),
                const PrayerTimeWidget(),
                SizedBox(height: h * 0.03),

                // Card container for password + FaceID + Forgot
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
                            children: const [
                              Text(
                                "Welcome back,",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                "Sarahahmed",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () => context.router.replace(LoginRoute()),
                            child: const Text(
                              "Switch Profile",
                              style: TextStyle(
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

                      // Password Input
                      UiTextField(
                        margin: EdgeInsets.zero,
                        controller: passwordController,
                        label: "Enter your Password",
                        obscureText: true,
                        cursorColor: Colors.white,
                        hintTextColor: DefaultColors.white_200,
                        focusBorderColor: DefaultColors.blue_200,
                        unfocusBorderColor: DefaultColors.white,
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),

                      SizedBox(height: h * 0.02),

                      // Face ID Button
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
                            ? context.router.push(DashboardRoute())
                            : _authenticate(useFingerprint: false, context),
                        icon: passwordController.text.isNotEmpty
                            ? null
                            : Icon(
                                widget.fingerprintAuth
                                    ? Icons.fingerprint
                                    : Icons.face_retouching_natural,
                              ),
                        label: Text(
                          passwordController.text.isNotEmpty
                              ? "Login"
                              : widget.fingerprintAuth
                              ? "Use fingerprint"
                              : "Use Face ID",
                        ),
                      ),

                      SizedBox(height: h * 0.02),

                      // Forgot password link
                      InkWell(
                        onTap: () => context.router.push(ForgotPasswordRoute()),
                        child: const Text(
                          "Forgot Username/Password?",
                          style: TextStyle(
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

                // View Balance
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
                      showAccountBalance ? "78699 QAR" : "View Account Balance",
                    ),
                  ),
                ),

                const Spacer(),
                Container(child: loginBottomBar(context)),
              ],
            ),
          ),
        ),
      ),
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
          const SnackBar(
            content: Text("Biometric authentication not available"),
          ),
        );
        return;
      }

      // Get the list of available biometrics
      final List<BiometricType> availableBiometrics = await auth
          .getAvailableBiometrics();

      availableBiometrics.forEach((e) {
        print(e);
      });

      // Check condition based on bool
      if (useFingerprint) {
        if (availableBiometrics.contains(BiometricType.fingerprint)) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Fingerprint not available on this device"),
            ),
          );
          return;
        }
      } else {
        if (availableBiometrics.contains(BiometricType.face)) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Face ID not available on this device"),
            ),
          );
          return;
        }
      }

      final bool didAuthenticate = await auth.authenticate(
        localizedReason: useFingerprint
            ? "Authenticate with Fingerprint to login"
            : "Authenticate with Face ID to login",
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );

      if (didAuthenticate) {
        CustomSheet.show(context: context, child: enterMpinWidget(context));
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Authentication error: $e")));
    }
  }

  /// Validates & processes login button press
  Future<void> _handleLoginPressed() async {
    if (passwordController.text.trim().isEmpty) {
      UiDialogs.showErrorDialog(
        bknOkPressed: () {
          Navigator.pop(context);
        },
        context: context,
        description: "Password cannot be empty.",
      );
      return;
    }
    FocusScope.of(context).unfocus();

    final token = ref.read(authTokenProvider);
    if (token != null) {
      ref.read(authTokenProvider.notifier).state = null;
    }

    await ref
        .read(loginNotifierProvider.notifier)
        .signInWithPassword(password: passwordController.text.trim());
  }

  /// Resets text controllers & form state
  void _resetForm() {
    passwordController.clear();
  }

  /// Handles successful login flow
  void _handleLoginSuccess(User user) {
    context.router.push(LoginOtpRoute(userdetail: user));
  }
}
