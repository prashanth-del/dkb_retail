import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/components.dart';
import 'package:db_uicomponents/src/components/retail/ui_header_subheader_retail.dart';
import 'package:dkb_retail/core/utils/extensions/locale_extension.dart';
import 'package:dkb_retail/features/onboarding/presentation/controller/notifier/onboarding_update_account_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/constants/asset_path/asset_path.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/validator/utils/form_validator.dart';
import '../../../../../core/constants/validator/utils/input_formatters/avoid_spceial_character_formatter.dart';
import '../../../../../core/router/app_router.dart';
import '../../../../common/components/auto_leading_widget.dart';
import '../../../../common/dialog/ui_dialogs.dart';
import '../../controller/notifier/onboarding_save_stage_data_notifier.dart';
import '../../provider/onboarding_provider.dart';
// import 'package:db_uicomponents/src/components/retail/ui_button.dart';

@RoutePage()
class OnboardingSetUsernamePasswordPage extends ConsumerStatefulWidget {
  const OnboardingSetUsernamePasswordPage({super.key});

  @override
  ConsumerState<OnboardingSetUsernamePasswordPage> createState() =>
      _OnboardingSetUsernamePasswordPageState();
}

class _OnboardingSetUsernamePasswordPageState
    extends ConsumerState<OnboardingSetUsernamePasswordPage> {
  bool obscure1 = true;
  bool obscure2 = true;

  late FocusNode userName, pwd, confirmPwd, submit;
  TextEditingController userNameController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  TextEditingController confirmPwdController = TextEditingController();
  final setPasswordFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    userName = FocusNode();
    pwd = FocusNode();
    confirmPwd = FocusNode();
    submit = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    userName.dispose();
    pwd.dispose();
    confirmPwd.dispose();
    submit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formValidatorProvider = ref.read(
      formValidatorNotifierProvider.notifier,
    );
    final currentStage = getStageById(ref, "USER_NAME_PWD");

    return Scaffold(
      appBar: UIAppBar.secondary(
        autoLeadingWidget: AutoLeadingWidget(),
        title: "New Account",
        appBarColor: DefaultColors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: setPasswordFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const UiHeaderSubHeaderRetail(
                        title: "  Choose your Username and Password",
                        description:
                            "   Please define your username and password.",
                      ),
                      const SizedBox(height: 30),
                      const UiTextNew.h4Regular(
                        "   Username",
                        color: DefaultColors.white_800,
                      ),
                      const SizedBox(height: 8),
                      _buildUsernameField(formValidatorProvider),
                      // _setFormInputField("", "Enter Username", userNameController, userName, false),
                      const SizedBox(height: 20),
                      const UiTextNew.h4Regular(
                        "   Password",
                        color: DefaultColors.white_800,
                      ),
                      const SizedBox(height: 8),
                      _buildPasswordField(formValidatorProvider),

                      // _setFormInputField("", "Enter Password", pwdController, pwd, obscure1),
                      const SizedBox(height: 20),
                      const UiTextNew.h4Regular(
                        "   Confirm Password",
                        color: DefaultColors.white_800,
                      ),
                      const SizedBox(height: 8),

                      _buildConfirmPasswordField(formValidatorProvider),
                      // _setFormInputField("", "Enter Confirm Password", confirmPwdController, confirmPwd, obscure2),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: UIButton.rounded(
                onPressed:
                    userNameController.text.isEmpty ||
                        pwdController.text.isEmpty ||
                        confirmPwdController.text.isEmpty ||
                        !setPasswordFormKey.currentState!.validate()
                    ? null
                    : () async {
                        // GlobalCache.instance.setPrimaryUser(true);
                        // context.router.pushNamed(ResetPasswordPage.routeName);

                        FocusScope.of(context).requestFocus(FocusNode());
                        if (pwdController.text != confirmPwdController.text) {
                          UiToast().showFlagMsg(
                            context: context,
                            msg: ref.getLocaleString(
                              'newpassword_confirmpassword',
                              defaultValue:
                                  'Password and ConfirmPassword must be same',
                            ),
                            level: ToastLevel.error,
                          );
                          return;
                        }
                        bool value = await ref
                            .read(
                              onboardingSaveStageDataNotifierProvider.notifier,
                            )
                            .fetch(
                              custJourneyId: ref.watch(customerJourneyId),
                              stageId: "${currentStage?.stageId}",
                              data: {
                                "Username": userNameController.text,
                                "password": pwdController.text,
                                "Confirm_password": confirmPwdController.text,
                              },
                            );
                        if (value == true) {
                          bool updatedAccount = await ref
                              .read(
                                onboardingUpdateAccountNotifierProvider
                                    .notifier,
                              )
                              .fetch(
                                custJourneyId: ref.watch(customerJourneyId),
                                accountNumber: "",
                              );
                          if (updatedAccount == true) {
                            context.router.push(
                              OnboardingAccountCreatedRoute(),
                            );
                          } else {
                            UiDialogs.showErrorDialog(
                              context: context,
                              description: "Account not updated",
                              bknOkPressed: () {
                                context.router.maybePop();
                              },
                            );
                          }
                        } else {
                          UiDialogs.showErrorDialog(
                            context: context,
                            description: "Error Caught",
                            bknOkPressed: () {
                              context.router.maybePop();
                            },
                          );
                        }
                      },
                // height: 40,
                // focus: submit,
                isDisabled:
                    userNameController.text.isEmpty ||
                    pwdController.text.isEmpty ||
                    confirmPwdController.text.isEmpty,
                label: ref.getLocaleString(
                  "CREATE ACCOUNT",
                  defaultValue: 'CREATE ACCOUNT',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _setFormInputField(
    String label,
    String hintText,
    TextEditingController controller,
    FocusNode node,
    bool obscure,
  ) {
    return UIFormTextField.underlined(
      hintText: hintText,
      borderColor: DefaultColors.grayE6,
      controller: controller,
      focus: node,
      obscure: obscure,
      onChanged: (String val) {
        setState(() {});
      }, // labelUiText: UiTextNew.h4Regular(
      //   label,
      //   color: DefaultColors.white_800,
      // ),
      suffixIcon: (hintText == "Enter Username")
          ? null
          : Padding(
              padding: const EdgeInsets.all(10),
              child: InkWell(
                onTap: () {
                  setState(() {
                    if ((hintText == "Enter Password")) obscure1 = !obscure1;
                    if ((hintText == "Enter Confirm Password"))
                      obscure2 = !obscure2;
                  });
                },
                child: UISvgIcon(
                  assetPath: obscure
                      ? AssetPath.icon.retailVisibilityOffIcon
                      : AssetPath.icon.retailVisibilityIcon,
                  fit: BoxFit.contain,
                  color: DefaultColors.gray8A,
                  width: 24,
                  height: 24,
                ),
              ),
            ),
      onFieldSubmitted: (String value) {
        node.unfocus();
        if ((hintText == "Enter Username")) {
          FocusScope.of(context).requestFocus(pwd);
        }
        if ((hintText == "Enter Password"))
          FocusScope.of(context).requestFocus(confirmPwd);
        if ((hintText == "Enter Confirm Password"))
          FocusScope.of(context).requestFocus(submit);
      },

      labelTextStyle: const TextStyle(
        fontSize: 14,
        fontFamily: 'Rubik',
        fontWeight: FontWeight.w500,
        color: DefaultColors.white_800,
      ),
    );
  }

  Widget _buildUsernameField(FormValidatorNotifier formValidatorProvider) {
    return UIFormTextField.underlined(
      hintText: "Enter Username",
      borderColor: DefaultColors.grayE6,
      focus: userName,
      controller: userNameController,
      validator: formValidatorProvider.validateUsername,
      textInputType: TextInputType.text,
      maxLength: 12,
      inputFormatters: [AvoidSpecialCharacterFormatter()],
      height: 38,
      onChanged: (String val) {
        setState(() {});
      },
      onFieldSubmitted: (String value) {
        userName.unfocus();
        FocusScope.of(context).requestFocus(pwd);
      },
      labelTextStyle: const TextStyle(
        fontSize: 14,
        fontFamily: 'Rubik',
        fontWeight: FontWeight.w500,
        color: DefaultColors.white_800,
      ),
    );
  }

  Widget _buildPasswordField(FormValidatorNotifier formValidatorProvider) {
    return UIFormTextField.underlined(
      hintText: "Enter Password",
      borderColor: DefaultColors.grayE6,
      obscure: obscure1,
      focus: pwd,
      controller: pwdController,
      validator: formValidatorProvider.validatePassword,
      textInputType: TextInputType.text,
      onChanged: (String val) {
        setState(() {});
      },
      inputFormatters: [AvoidSpecialCharacterFormatter()],
      onFieldSubmitted: (String value) {
        pwd.unfocus();
        FocusScope.of(context).requestFocus(confirmPwd);
      },
      labelTextStyle: const TextStyle(
        fontSize: 14,
        fontFamily: 'Rubik',
        fontWeight: FontWeight.w500,
        color: DefaultColors.white_800,
      ),
      suffixIcon: Padding(
        padding: const EdgeInsets.all(10),
        child: InkWell(
          onTap: () {
            setState(() {
              obscure1 = !obscure1;
            });
          },
          child: UISvgIcon(
            assetPath: obscure1
                ? AssetPath.icon.visibility_off
                : AssetPath.icon.visibility,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  Widget _buildConfirmPasswordField(
    FormValidatorNotifier formValidatorProvider,
  ) {
    return UIFormTextField.underlined(
      hintText: "Enter Confirm Password",
      borderColor: DefaultColors.grayE6,
      obscure: obscure2,
      focus: confirmPwd,
      controller: confirmPwdController,
      validator: formValidatorProvider.validatePassword,
      textInputType: TextInputType.text,
      onChanged: (String val) {
        setState(() {});
      },
      inputFormatters: [AvoidSpecialCharacterFormatter()],
      onFieldSubmitted: (String value) {
        confirmPwd.unfocus();
        FocusScope.of(context).requestFocus(submit);
      },
      labelTextStyle: const TextStyle(
        fontSize: 14,
        fontFamily: 'Rubik',
        fontWeight: FontWeight.w500,
        color: DefaultColors.white_800,
      ),
      suffixIcon: Padding(
        padding: const EdgeInsets.all(10),
        child: InkWell(
          onTap: () {
            setState(() {
              obscure2 = !obscure2;
            });
          },
          child: UISvgIcon(
            assetPath: obscure2
                ? AssetPath.icon.visibility_off
                : AssetPath.icon.visibility,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
