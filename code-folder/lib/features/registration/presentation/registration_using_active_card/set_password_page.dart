import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:dkb_retail/core/router/app_router.dart';
import 'package:dkb_retail/features/registration/data/modals/password_validation.dart';
import 'package:dkb_retail/features/registration/presentation/controller/password_notifier.dart';
import 'package:dkb_retail/features/registration/presentation/controller/registration_active_controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class SetPasswordPage extends ConsumerStatefulWidget {
  const SetPasswordPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SetPasswordPageState();
}

class _SetPasswordPageState extends ConsumerState<SetPasswordPage> {
  FocusNode setPassNode = FocusNode();
  FocusNode confirmSetPassNode = FocusNode();
  final setPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(setPassNode);
    });
  }

  void validatePassword(String password, WidgetRef ref) {
    final validation = PasswordValidation(
      hasMinLength: password.length >= 8 && password.length <= 32,
      hasUppercase: password.contains(RegExp(r'[A-Z]')),
      hasLowercase: password.contains(RegExp(r'[a-z]')),
      hasNumber: password.contains(RegExp(r'[0-9]')),
      hasSpecialChar: password.contains(RegExp(r'[!@#\$%\^&\*\-_\.]')),
    );

    ref.read(passwordValidationProvider.notifier).state = validation;
  }

  @override
  Widget build(BuildContext context) {
    // final setPassword = ref.watch(passwordControllerProvider);
    // final confirmPassword = ref.watch(confirmPasswordControllerProvider);
    final validation = ref.watch(validatePasswordProvider);
    final isMatch = ref.watch(isConfirmPasswordProvider);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: DefaultColors.white,
      body: SingleChildScrollView(
        child: Stack(
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
            Column(
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
                    'Set Password',
                    color: DefaultColors.blue9D,
                  ),
                ),
                UiSpace.vertical(16),
                UiTextField(
                  autoFocus: true,
                  obscureText: true,
                  controller: setPasswordController,
                  label: 'Enter Valid Password',
                  keyboardType: TextInputType.name,
                  suffix: Icon(Icons.visibility_outlined),
                  onFieldSubmitted: (value) async {
                    if (validation.hasMinLength &&
                        validation.hasUppercase &&
                        validation.hasLowercase &&
                        validation.hasNumber &&
                        validation.hasSpecialChar) {
                      // WidgetsBinding.instance.addPostFrameCallback((_) {
                      //   FocusScope.of(context).requestFocus(confirmSetPassNode);
                      // });
                      // await Future.delayed(Duration(milliseconds: 100), () {
                      //   setState(() {});
                      // });
                    } else {
                      UiToast().showToast('Enter Valid Password');
                    }
                  },
                  onChanged: (value) {
                    ref.read(validatePasswordProvider.notifier).validate(value);
                    ref.read(passwordControllerProvider.notifier).state = value;
                  },
                ),

                UiSpace.vertical(10),

                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: LinearProgressIndicator(
                        value:
                            ([
                              validation.hasMinLength,
                              validation.hasUppercase,
                              validation.hasLowercase,
                              validation.hasNumber,
                              validation.hasSpecialChar,
                            ].where((e) => e).length /
                            5),
                        backgroundColor: DefaultColors.gray96,
                        valueColor: AlwaysStoppedAnimation(
                          validation.isStrong ? Colors.green : Colors.red,
                        ),
                      ),
                    ),
                    UiSpace.vertical(10),
                    _buildRule(
                      "At least 8 characters",
                      validation.hasMinLength,
                    ),
                    _buildRule(
                      "Upper case letters (A-Z)",
                      validation.hasUppercase,
                    ),
                    _buildRule(
                      "Lower case letters (a-z)",
                      validation.hasLowercase,
                    ),
                    _buildRule("Contains numbers", validation.hasNumber),
                    _buildRule(
                      "1 special character (!@#\$&*)",
                      validation.hasSpecialChar,
                    ),
                  ],
                ),
                UiSpace.vertical(16),
                UiTextField(
                  controller: confirmPasswordController,
                  label: 'Confirm Password',
                  keyboardType: TextInputType.name,
                  obscureText: true,
                  onChanged: (value) =>
                      ref
                              .read(confirmPasswordControllerProvider.notifier)
                              .state =
                          value,
                ),
              ],
            ),
          ],
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
                  isDisabled: !isMatch,
                  backgroundColor: DefaultColors.blue9D,
                  onPressed: () {
                    context.router.replace(UserInterestsRoute());
                  },
                  label: 'Confirm Password',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRule(String text, bool isValid) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      child: Row(
        children: [
          Icon(
            isValid ? Icons.check_circle : Icons.cancel,
            color: isValid ? Colors.green : Colors.red,
            size: 18,
          ),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              color: isValid ? Colors.green : Colors.red,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
