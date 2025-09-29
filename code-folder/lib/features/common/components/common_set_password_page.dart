import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:dkb_retail/common/utils.dart';
import 'package:dkb_retail/core/utils/extensions/locale_extension.dart';
import 'package:dkb_retail/features/registration/data/modals/password_validation.dart';
import 'package:dkb_retail/features/registration/presentation/controller/password_notifier.dart';
import 'package:dkb_retail/features/registration/presentation/controller/registration_active_controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  final FocusNode setPassNode = FocusNode();
  final FocusNode confirmSetPassNode = FocusNode();
  final PasswordValidation validation = PasswordValidation();
  List rules = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(setPassNode);
    });
  }

  @override
  void dispose() {
    setPasswordController.dispose();
    confirmPasswordController.dispose();
    setPassNode.dispose();
    confirmSetPassNode.dispose();
    super.dispose();
  }

  String getPasswordStrength(String password) {
    final specialChars = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
    final numbers = RegExp(r'[0-9]');
    final letters = RegExp(r'[A-Za-z]');

    int specialCount = specialChars.allMatches(password).length;
    int numberCount = numbers.allMatches(password).length;
    bool hasLetter = letters.hasMatch(password);

    // Conditions
    if (password.length < 8) {
      return "Weak";
    } else if (password.length == 8 && specialCount <= 1 && numberCount <= 1) {
      return "Moderate";
    } else if (password.length > 8 && specialCount >= 2 && numberCount >= 2) {
      return "Strong";
    } else {
      return "Moderate";
    }
  }

  String ifModerateMsg = '';

  @override
  Widget build(BuildContext context) {
    final validation = ref.watch(validatePasswordProvider);
    final isMatch = ref.watch(isConfirmPasswordProvider);
    final isSetPassVisible = ref.watch(issetPasswordVisible);
    final isSetConfirmPassVisible = ref.watch(issetConfirmPasswordVisible);
    // rules = [
    //   ("At least 8 characters", validation.hasMinLength),
    //   ("Upper case letters (A-Z)", validation.hasUppercase),
    //   ("Lower case letters (a-z)", validation.hasLowercase),
    //   ("Contains numbers", validation.hasNumber),
    //   ("1 special character (!@#\$&*)", validation.hasSpecialChar),
    // ];
    // double progressValue = 0.0;
    // Color strengthColor = Colors.red;
    if (validation.strengthText == 'Medium') {
      ifModerateMsg =
          'Avoid common words or patterns to create a stronger password';
    } else {
      ifModerateMsg = '';
    }

    consoleLog('message: $ifModerateMsg');

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: DefaultColors.white,
      body: SingleChildScrollView(
        child: UiBackgroundWrapper(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UiSpace.vertical(40),
                  CommonAuthAppBar(title: widget.title),

                  if (widget.description != null) ...[
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: UiTextNew.b14Regular(
                        widget.description ?? '',
                        maxLines: 2,
                      ),
                    ),
                  ],
                  const SizedBox(height: 16),

                  UiTextField(
                    autoFocus: true,
                    obscureText: !isSetPassVisible,
                    controller: setPasswordController,
                    label: ref.getLocaleString(
                      'Enter Valid Password',
                      defaultValue: 'Enter Valid Password',
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    suffix: GestureDetector(
                      onTap: () {
                        ref.read(issetPasswordVisible.notifier).state =
                            !isSetPassVisible;
                      },
                      child: Icon(
                        isSetPassVisible
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                    ),
                    onChanged: (value) {
                      ref
                          .read(validatePasswordProvider.notifier)
                          .validate(value);
                      ref.read(passwordControllerProvider.notifier).state =
                          value;
                    },
                    inputFormatters: [NoSpaceInputFormatter()],
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: LinearProgressIndicator(
                            // value: rules.where((e) => e.$2).length / rules.length,
                            value: validation.progress,
                            backgroundColor: Colors.grey.shade300,
                            valueColor: AlwaysStoppedAnimation(
                              validation.strengthColor,
                            ),
                          ),
                        ),
                        UiSpace.horizontal(6),
                        setPasswordController.text.isEmpty
                            ? SizedBox()
                            : UiTextNew.h5Regular(
                                validation.strengthText,
                                color: validation.strengthColor,
                              ),
                      ],
                    ),

                    // child: ValueListenableBuilder(
                    //   valueListenable: setPasswordController,
                    //   builder: (context, value, child) {
                    //     final password = setPasswordController.text;
                    //     String strengthText = getPasswordStrength(password);
                    //     // Color textColor;
                    //     // if (password.length < 8) {
                    //     //   // Weak
                    //     //   strengthText = "Weak";
                    //     //   strengthColor = Colors.red;
                    //     //   progressValue = 0.33;
                    //     // } else if (password.length == 8) {
                    //     //   // Moderate
                    //     //   strengthText = "Moderate";
                    //     //   strengthColor = Colors.orange;
                    //     //   progressValue = 0.66;
                    //     // } else if (password.length > 8 && strengthRatio == 1.0) {
                    //     //   // Strong
                    //     //   strengthText = "Strong";
                    //     //   strengthColor = Colors.green;
                    //     //   progressValue = 1.0;
                    //     // } else {
                    //     //   // Fallback = Moderate
                    //     //   strengthText = "Moderate";
                    //     //   strengthColor = Colors.orange;
                    //     //   progressValue = 0.66;
                    //     // }

                    //     switch (strengthText) {
                    //       case "Weak":
                    //         strengthColor = Colors.red;
                    //         progressValue = 0.33;
                    //         ifModerateMsg = '';
                    //         consoleLog('in weak');
                    //         break;

                    //       case "Moderate":
                    //         strengthColor = Colors.orange;
                    //         progressValue = 0.66;
                    //         ifModerateMsg =
                    //             'Avoid common words or patterns to create a stronger password';
                    //         consoleLog('in msg moderate');
                    //         break;
                    //       case "Strong":
                    //         strengthColor = Colors.green;
                    //         progressValue = 1.0;
                    //         ifModerateMsg = '';
                    //         consoleLog('in strong');
                    //         break;
                    //       default:
                    //         strengthColor = Colors.grey;
                    //         progressValue = 0.0;
                    //         ifModerateMsg = '';
                    //         consoleLog('in default');
                    //     }

                    //     return Row(
                    //       children: [
                    //         Expanded(
                    //           child: LinearProgressIndicator(
                    //             // value: rules.where((e) => e.$2).length / rules.length,
                    //             value: validation.progress,
                    //             backgroundColor: Colors.grey.shade300,
                    //             valueColor: AlwaysStoppedAnimation(validation.strengthColor),
                    //           ),
                    //         ),
                    //         UiSpace.horizontal(6),
                    //         UiTextNew.h5Regular(
                    //           validation.strengthText,
                    //           color: validation.strengthColor,
                    //         ),
                    //       ],
                    //     );
                    //   },
                    // ),
                  ),

                  const SizedBox(height: 12),

                  UiTextField(
                    controller: confirmPasswordController,
                    label: ref.getLocaleString(
                      'Confirm Password',
                      defaultValue: 'Confirm Password',
                    ),
                    suffix: ref.watch(confirmPasswordControllerProvider).isEmpty
                        ? SizedBox()
                        : GestureDetector(
                            onTap: () {
                              ref
                                      .read(
                                        issetConfirmPasswordVisible.notifier,
                                      )
                                      .state =
                                  !isSetConfirmPassVisible;
                            },
                            child: Icon(
                              isSetConfirmPassVisible
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                            ),
                          ),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: !isSetConfirmPassVisible,

                    inputFormatters: [NoSpaceInputFormatter()],
                    onChanged: (value) =>
                        ref
                                .read(
                                  confirmPasswordControllerProvider.notifier,
                                )
                                .state =
                            value,
                  ),
                  UiSpace.vertical(12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _buildValidationUI(validation),
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Center(
                  child: UiTextNew.h5Medium(
                    ifModerateMsg,
                    color: DefaultColors.red_0,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                width: double.infinity,
                child: UIButton.rounded(
                  height: 48,
                  btnCurve: 30,
                  txtColor: Colors.white,
                  isDisabled: !isMatch,
                  backgroundColor: DefaultColors.blue9D,
                  onPressed: () {
                    widget.onConfirmed(setPasswordController.text);
                  },
                  label: widget.buttonLabel,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildValidationUI(PasswordValidation validation) {
    final rules = [
      ("At least 8 characters", validation.hasMinLength),
      ("At least 1 uppercase letter", validation.hasUppercase),
      ("At least 1 lowercase letter", validation.hasLowercase),
      ("At least 1 number", validation.hasNumber),
      ("At least 1 special character", validation.hasSpecialChar),
    ];

    return Wrap(
      runSpacing: 6,
      spacing: 12,
      children: rules.map((r) => _buildRule(r.$1, r.$2)).toList(),
    );
  }

  Widget _buildRule(String text, bool isValid) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          isValid ? Icons.check_circle : Icons.cancel,
          color: isValid ? Colors.green : Colors.red,
          size: 18,
        ),
        const SizedBox(width: 6),
        // UiTextNew.b4Medium(text, color: isValid ? Colors.green : Colors.red),
        Text(
          text,
          style: TextStyle(
            color: isValid ? Colors.green : Colors.red,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class NoSpaceInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Remove all spaces
    final newText = newValue.text.replaceAll(' ', '');

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
