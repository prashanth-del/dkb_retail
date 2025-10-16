import 'package:auto_route/auto_route.dart';
import 'package:dkb_retail/core/router/app_router.dart';
import 'package:dkb_retail/core/utils/extensions/locale_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // 👈 needed for inputFormatters
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/presentation/components/common_textfeild_style_2.dart';
import '../../../../core/constants/app_strings/default_string.dart';

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
    final size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        color: DefaultColors.white.withAlpha(50),
        borderRadius: BorderRadius.circular(size.aspectRatio * 60),
      ),
      padding: EdgeInsets.all(size.aspectRatio * 40),
      margin: EdgeInsets.zero,
      child: Form(
        key: loginFormKey,
        child: Column(
          children: [
            UiSpace.vertical(size.height * 0.03),
            // Username / Email
            CustomTextFieldStyle2(
              controller: userController,
              inputFormatters: [
                FilteringTextInputFormatter.deny(RegExp(r'\s')), // ❌ no spaces
              ],
              label: DefaultString.instance.userNameTextField,
              floatingLabelBehavior: FloatingLabelBehavior.auto,
            ),

            const SizedBox(height: 16),
            CustomTextFieldStyle2(
              controller: passwordController,
              obscureText: !isPasswordVisible,
              inputFormatters: [
                FilteringTextInputFormatter.deny(RegExp(r'\s')),
              ],
              label: DefaultString.instance.passwordTextField,
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              allowCopyPaste: false,
              suffixIcon: GestureDetector(
                onTap: onTogglePassword,
                child: Icon(
                  isPasswordVisible
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: DefaultColors.white,
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
                  DefaultString.instance.forgotUsernamePassword,

                  decoration: TextDecoration.underline,
                  decorationColor: DefaultColors.blue_200,
                  color: DefaultColors.blue_200,
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
              label: DefaultString.instance.login,
              btnCurve: 20,
              backgroundColor: DefaultColors.white,
              txtColor: DefaultColors.black,
              margin: EdgeInsets.zero,
            ),
            const SizedBox(height: 16),

            _buildRegisterSection(ref: ref),
            UiSpace.vertical(size.height * 0.03),
          ],
        ),
      ),
    );
  }

  Widget _buildRegisterSection({required WidgetRef ref}) {
    return GestureDetector(
      onTap: onRegisterPressed,
      child: UiTextNew.b11Regular(
        DefaultString.instance.registerNow,
        decoration: TextDecoration.underline,
        decorationColor: DefaultColors.white,
        color: Colors.white,
      ),
    );
  }
}
