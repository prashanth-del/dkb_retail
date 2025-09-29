import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:dkb_retail/core/router/app_router.dart';
import 'package:dkb_retail/core/utils/extensions/locale_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/forget_password_providers.dart';
import '../widgets/cardNumberFormatter.dart';

@RoutePage()
class ForgotPasswordScreen extends ConsumerWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cardNumber = ref.watch(cardNumberProvider);
    final cardPin = ref.watch(pinNumberProvider);
    final cardNode = ref.watch(cardFocusNodeProvider);
    final pinNode = ref.watch(pinFocusNodeProvider);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: DefaultColors.white,
      body: SingleChildScrollView(
        child: UiBackgroundWrapper(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UiSpace.vertical(40),
              CommonAuthAppBar(title: "Forget Username/Password?"),
              UiSpace.vertical(16),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: UiTextNew.b14Medium(
                  'Enter Your Card Details',
                  color: DefaultColors.black,
                ),
              ),
              UiSpace.vertical(16),

              /// Card input
              UiTextField(
                label: 'Enter debit/prepaid card number',
                focusNode: cardNode,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  CardNumberFormatter(),
                ],
                maxLength: 16 + 3, // 3 added for spaces
                onTap: () => FocusNode().requestFocus(cardNode),
                keyboardType: const TextInputType.numberWithOptions(),
                onChanged: (value) async {
                  ref.read(cardNumberProvider.notifier).state = value;
                  if (value.length == 19) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      FocusScope.of(context).requestFocus(pinNode);
                    });
                  }
                },
              ),

              UiSpace.vertical(20),

              UiTextField(
                label: 'Enter PIN',
                hintText: '----',
                focusNode: pinNode,
                maxLength: 4,
                obscureText: true,
                keyboardType: const TextInputType.numberWithOptions(),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                onChanged: (value) {
                  ref.read(pinNumberProvider.notifier).state = value;
                },

                onFieldSubmitted: (_) => pinNode.unfocus(),
              ),
            ],
          ),
        ),
      ),

      /// Bottom bar → only shows when card + pin both complete
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
                  txtColor: DefaultColors.white,
                  isDisabled:
                      !((cardPin?.length ?? 0) == 4 &&
                          (cardNumber?.length ?? 0) >= 19),
                  backgroundColor: DefaultColors.blue9D,
                  onPressed: () {
                    context.router.push(
                      CommonOtpRoute(
                        onResend: () {},
                        suffixTap: () {
                          context.router.popUntil(
                            (route) =>
                                route.settings.name == LoginRoute.name ||
                                route.settings.name == WelcomeBackRoute.name,
                          );
                        },
                        onVerify: (value) {
                          context.router.push(
                            ForgotPasswordCreateUsernameRoute(
                              title: "Confirm or Update Username",
                              onSubmit: (value) {
                                context.router.push(
                                  CommonSetPasswordRoute(
                                    title: "Set New Password",
                                    onConfirmed: (value) {
                                      context.router.push(
                                        ForgetPasswordTaskCompleteRoute(),
                                      );
                                    },
                                    buttonLabel: "Confirm Password",
                                  ),
                                );
                              },
                            ),
                          );
                        },

                        onCompleted: (value) {
                          context.router.push(
                            ForgotPasswordCreateUsernameRoute(
                              title: "Confirm or Update Username",
                              onSubmit: (value) {
                                context.router.push(
                                  CommonSetPasswordRoute(
                                    title: "Set New Password",
                                    onConfirmed: (value) {
                                      context.router.push(
                                        ForgetPasswordTaskCompleteRoute(),
                                      );
                                    },
                                    buttonLabel: "Confirm Password",
                                  ),
                                );
                              },
                            ),
                          );
                        },
                        title: ref.getLocaleString(
                          "Enter OTP",
                          defaultValue: "Enter OTP",
                        ),
                        description: ref.getLocaleString(
                          "you will receive the OTP on your mobile number.",
                          defaultValue:
                              "You will receive the OTP on your registered mobile number",
                        ),
                      ),
                    );
                  },
                  label: 'Get OTP',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
