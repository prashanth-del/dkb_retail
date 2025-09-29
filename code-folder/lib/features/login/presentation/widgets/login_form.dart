import 'package:auto_route/auto_route.dart';
import 'package:dkb_retail/core/router/app_router.dart';
import 'package:dkb_retail/core/utils/extensions/locale_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // 👈 needed for inputFormatters
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginFormWidget extends ConsumerWidget {
  final GlobalKey<FormState> loginFormKey;
  final TextEditingController userController;
  final TextEditingController passwordController;
  final bool isPasswordVisible;
  final VoidCallback onTogglePassword;
  final VoidCallback onLoginPressed;
  final VoidCallback onRegisterPressed;

  const LoginFormWidget({
    super.key,
    required this.loginFormKey,
    required this.userController,
    required this.passwordController,
    required this.isPasswordVisible,
    required this.onTogglePassword,
    required this.onLoginPressed,
    required this.onRegisterPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => FocusScope.of(context).unfocus(), // close keyboard
      child: Form(
        key: loginFormKey,
        child: Column(
          children: [
            // Username / Email
            TextField(
              controller: userController,
              cursorColor: Colors.white,
              inputFormatters: [
                FilteringTextInputFormatter.deny(RegExp(r'\s')), // ❌ no spaces
              ],
              style: const TextStyle(
                color: DefaultColors.white,
                fontWeight: FontWeight.normal,
                fontSize: 16,
              ),
              decoration: InputDecoration(
                labelText: 'Email or Phone number',
                labelStyle: const TextStyle(
                  color: DefaultColors.white,
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                filled: true,
                fillColor: DefaultColors.white.withAlpha(30),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: DefaultColors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: DefaultColors.white),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Password
            TextField(
              controller: passwordController,
              obscureText: !isPasswordVisible,
              cursorColor: Colors.white,
              inputFormatters: [
                FilteringTextInputFormatter.deny(RegExp(r'\s')),
              ],
              style: const TextStyle(
                color: DefaultColors.white,
                fontWeight: FontWeight.normal,
                fontSize: 16,
              ),
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: const TextStyle(
                  color: DefaultColors.white,
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                suffixIcon: GestureDetector(
                  onTap: onTogglePassword,
                  child: Icon(
                    isPasswordVisible
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: DefaultColors.white,
                  ),
                ),
                filled: true,
                fillColor: DefaultColors.white.withAlpha(30),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: DefaultColors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: DefaultColors.white),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Forgot Password link
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () => context.router.push(ForgotPasswordRoute()),
                child: UiTextNew.b11Regular(
                  "Forgot Username/Password ?",
                  decoration: TextDecoration.underline,
                  decorationColor: DefaultColors.white,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Login Button
            UIButton.rounded(
              onPressed: onLoginPressed,
              isRoundedButton: true,
              maxWidth: MediaQuery.of(context).size.width,
              height: 45,
              label: ref.getLocaleString("Login", defaultValue: "Login"),
              btnCurve: 20,
              backgroundColor: DefaultColors.white,
              txtColor: DefaultColors.black,
              margin: EdgeInsets.zero,
            ),
            const SizedBox(height: 16),

            _buildRegisterSection(ref: ref),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildRegisterSection({required WidgetRef ref}) {
    return GestureDetector(
      onTap: onRegisterPressed,
      child: UiTextNew.b11Regular(
        "Register Now",
        decoration: TextDecoration.underline,
        decorationColor: DefaultColors.white,
        color: Colors.white,
      ),
    );
  }
}
