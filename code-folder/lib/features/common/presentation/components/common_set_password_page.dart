import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:dkb_retail/core/constants/app_strings/default_string.dart';
import 'package:dkb_retail/features/common/domain/entities/password_rules_entites/password_rules.dart';
import 'package:dkb_retail/features/common/presentation/controllers/common_notifier.dart';
import 'package:dkb_retail/features/common/presentation/components/auth_header_wrapper.dart';
import 'package:dkb_retail/features/registration/presentation/controller/registration_active_controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common_controllers.dart';
import '../controllers/set_password_notifier.dart';

@RoutePage()
class CommonSetPasswordPage extends ConsumerStatefulWidget {
  final String title;
  final String buttonLabel;
  final void Function(String password) onConfirmed;
  final String? description;

  const CommonSetPasswordPage({
    super.key,
    required this.title,
    required this.buttonLabel,
    required this.onConfirmed,
    this.description,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CommonSetPasswordPageState();
}

class _CommonSetPasswordPageState extends ConsumerState<CommonSetPasswordPage> {
  final setPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(commonNotifierProvider.notifier).getPasswordRules();
    });
  }

  @override
  void dispose() {
    setPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final rules = ref.watch(passwordRulesProvider);
    final validation = ref.watch(passwordValidationNotifierProvider);
    final isMatch = ref.watch(isConfirmPasswordProvider);
    final isSetPassVisible = ref.watch(issetPasswordVisible);
    final isSetConfirmPassVisible = ref.watch(issetConfirmPasswordVisible);

    final password = setPasswordController.text;

    final specialCharCount = RegExp(
      r'[!@#\$%^&*(),.?":{}|<>]',
    ).allMatches(password).length;
    final hasTwoSpecials = specialCharCount >= 2;
    final hasLength8 = password.length > 8;

    /// 🧠 Determine password strength level
    String passwordStrength = '';
    Color strengthColor = Colors.grey;
    double progressValue = 0;

    if (password.isEmpty) {
      passwordStrength = '';
      strengthColor = Colors.grey.shade400;
      progressValue = 0.0;
    } else if (validation.isValid && hasTwoSpecials && hasLength8) {
      passwordStrength = "Strong";
      strengthColor = Colors.green;
      progressValue = 1.0;
    } else if (validation.isValid) {
      passwordStrength = "Medium";
      strengthColor = Colors.amber;
      progressValue = 0.7;
    } else {
      passwordStrength = "Weak";
      strengthColor = Colors.red;
      progressValue = 0.4;
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: DefaultColors.white,
      body: AuthHeaderWrapper(
        headerText: widget.title,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UiSpace.vertical(20),
            if (widget.description != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: UiTextNew.b14Regular(widget.description ?? ''),
              ),
            const SizedBox(height: 16),

            /// 🟢 Password Input
            UiTextField(
              autoFocus: true,
              obscureText: !isSetPassVisible,
              controller: setPasswordController,
              label: DefaultString.instance.enterValidPassword,
              keyboardType: TextInputType.visiblePassword,
              suffix: GestureDetector(
                onTap: () => ref.read(issetPasswordVisible.notifier).state =
                    !isSetPassVisible,
                child: Icon(
                  isSetPassVisible
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
              ),
              onChanged: (value) {
                ref
                    .read(passwordValidationNotifierProvider.notifier)
                    .validate(value, rules);
                ref.read(passwordControllerProvider.notifier).state = value;
              },
            ),

            const SizedBox(height: 12),

            /// 🟡 Strength Bar with dynamic color and length
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: LinearProgressIndicator(
                      value: progressValue,
                      backgroundColor: Colors.grey.shade300,
                      valueColor: AlwaysStoppedAnimation(strengthColor),
                      minHeight: 6,
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                  UiSpace.horizontal(8),
                  if (passwordStrength.isNotEmpty)
                    UiTextNew.h5Regular(passwordStrength, color: strengthColor),
                ],
              ),
            ),

            const SizedBox(height: 12),

            /// 🟢 Confirm Password
            UiTextField(
              controller: confirmPasswordController,
              label: DefaultString.instance.confirmPassword,
              suffix: confirmPasswordController.text.isEmpty
                  ? const SizedBox()
                  : GestureDetector(
                      onTap: () =>
                          ref.read(issetConfirmPasswordVisible.notifier).state =
                              !isSetConfirmPassVisible,
                      child: Icon(
                        isSetConfirmPassVisible
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                    ),
              keyboardType: TextInputType.visiblePassword,
              obscureText: !isSetConfirmPassVisible,
              onChanged: (value) =>
                  ref.read(confirmPasswordControllerProvider.notifier).state =
                      value,
            ),

            UiSpace.vertical(12),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _buildValidationUI(rules, validation),
            ),
          ],
        ),
      ),

      /// 🟦 Bottom Button
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                width: double.infinity,
                child: UIButton.rounded(
                  height: 48,
                  btnCurve: 30,
                  txtColor: Colors.white,
                  isDisabled: !isMatch || !validation.isValid,
                  backgroundColor: DefaultColors.blue9D,
                  onPressed: () =>
                      widget.onConfirmed(setPasswordController.text),
                  label: widget.buttonLabel,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildValidationUI(
    List<PasswordRules> rules,
    PasswordValidationState validation,
  ) {
    final setPasswordValue = setPasswordController.text;
    return Wrap(
      runSpacing: 6,
      spacing: 12,
      children: rules.map((rule) {
        final isValid = setPasswordValue == '' || setPasswordValue.isEmpty
            ? false
            : !validation.failedRules.contains(rule.ruleDescription);
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isValid ? Icons.check_circle : Icons.cancel,
              color: isValid ? Colors.green : Colors.red,
              size: 18,
            ),
            const SizedBox(width: 6),
            Text(
              rule.ruleDescription,
              style: TextStyle(
                color: isValid ? Colors.green : Colors.red,
                fontSize: 12,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}

class NoSpaceInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final newText = newValue.text.replaceAll(' ', '');
    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
