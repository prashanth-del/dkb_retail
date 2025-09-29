import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:dkb_retail/common/utils.dart';
import 'package:dkb_retail/core/router/app_router.dart';
import 'package:dkb_retail/core/utils/extensions/locale_extension.dart';
import 'package:dkb_retail/features/registration/presentation/controller/registration_active_controllers.dart';
import 'package:dkb_retail/features/registration/presentation/widget/card_number_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class RegisterationUsingActiveCardPage extends ConsumerStatefulWidget {
  const RegisterationUsingActiveCardPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RegisterationUsingActiveCardPageState();
}

class _RegisterationUsingActiveCardPageState
    extends ConsumerState<RegisterationUsingActiveCardPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cardController = ref.watch(cardNumberControllerProvider);
    final pinController = ref.watch(pinNumberControllerProvider);
    final cardNode = ref.watch(cardFocusNodeProvider);
    final pinNode = ref.watch(pinFocusNodeProvider);
    final isVisible = ref.watch(isVisibleProvider);
    final isCardValid = ref.watch(isCardValidProvider);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: DefaultColors.white,
      body: SingleChildScrollView(
        child: UiBackgroundWrapper(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UiSpace.vertical(40),
              CommonAuthAppBar(
                title: ref.getLocaleString(
                  "Register Using Your Card",
                  defaultValue: "Register Using Your Card",
                ),
                onBack: () {
                  if (isVisible && isCardValid) {
                    ref.watch(isVisibleProvider.notifier).state = false;
                    ref.watch(isCardValidProvider.notifier).state = false;
                    ref.watch(pinNumberControllerProvider).clear();
                  } else {
                    context.router.maybePop();
                  }
                },
              ),
              UiSpace.vertical(16),
              UiTextField(
                autoFocus: true,
                isReadOnly: isCardValid,
                controller: cardController,
                label: ref.getLocaleString(
                  'Enter Debit/Perpaid Card Number',
                  defaultValue: 'Enter Debit/Perpaid Card Number',
                ),
                maxLength: 19,
                keyboardType: TextInputType.numberWithOptions(),
                onChanged: (value) async {
                  setState(() {});
                  if (value.length == 19) {
                    ref.read(isVisibleProvider.notifier).state = true;
                    if (value == '1234 1234 1234 1234') {
                      ref.read(isCardValidProvider.notifier).state = true;
                    }
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      FocusScope.of(context).nextFocus();
                    });
                    await Future.delayed(Duration(milliseconds: 100), () {
                      setState(() {});
                    });
                  } else {
                    ref.read(isVisibleProvider.notifier).state = false;
                    ref.read(isCardValidProvider.notifier).state = false;
                  }
                },
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  CardNumberFormatter(),
                ],
              ),

              UiSpace.vertical(20),
              isVisible
                  ? isCardValid
                        ? UiTextField(
                            obscureText: true,
                            controller: pinController,
                            label: ref.getLocaleString(
                              "Enter PIN",
                              defaultValue: "Enter PIN",
                            ),
                            keyboardType: TextInputType.numberWithOptions(),
                            maxLength: 4,
                            onChanged: (value) {
                              setState(() {});
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9]'),
                              ), // Allow only digits
                            ],
                          )
                        : SizedBox()
                  : SizedBox(),
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
              isVisible
                  ? RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: DefaultColors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        text: ref.getLocaleString(
                          'By clicking on Next you accept our ',
                          defaultValue: 'By clicking on Next you accept our ',
                        ),
                        children: [
                          TextSpan(
                            style: TextStyle(
                              color: DefaultColors.blue60,
                              decoration: TextDecoration.underline,
                            ),
                            text: ref.getLocaleString(
                              'Terms and Conditions',
                              defaultValue: 'Terms and Conditions',
                            ),
                          ),
                        ],
                      ),
                    )
                  : SizedBox(),
              // UiSpace.vertical(12),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                width: double.infinity,
                child: UIButton.rounded(
                  height: 48,
                  btnCurve: 30,
                  isDisabled: isCardValid
                      ? cardController.text.isEmpty ||
                                cardController.text.length < 19 ||
                                pinController.text.length < 4
                            ? true
                            : false
                      : cardController.text.isEmpty ||
                            cardController.text.length < 19,
                  backgroundColor: DefaultColors.blue9D,
                  onPressed: () {
                    // context.router.push(RegisterationOtpRoute());
                    if (isCardValid) {
                      context.router.push(
                        CommonOtpRoute(
                          title: ref.getLocaleString(
                            "Enter OTP",
                            defaultValue: "Enter OTP",
                          ),
                          description: ref.getLocaleString(
                            "You will receive the OTP on your registered mobile number.",
                            defaultValue:
                                "You will receive the OTP on your registered mobile number.",
                          ),
                          otpLength: 6,
                          timerDuration: const Duration(seconds: 60),
                          suffixTap: () {
                            context.router.replaceAll([LoginRoute()]);
                          },
                          onVerify: (otp) {
                            // validate OTP API call
                            consoleLog('otp submitted');
                            context.router.push(CreateUsernameRoute());
                            // context.router.push(
                            //   CommonCreateUsernameRoute(
                            //     title: 'Create Username',
                            //     onSubmit: (username) {
                            //       context.router.push(
                            //         CommonSetPasswordRoute(
                            //           title: ref.getLocaleString(
                            //             "Set New Password",
                            //             defaultValue: "Set New Password",
                            //           ),
                            //           // description:,
                            //           buttonLabel: ref.getLocaleString(
                            //             "Confirm Password",
                            //             defaultValue: "Confirm Password",
                            //           ),
                            //           onConfirmed: (password) {
                            //             context.router.push(
                            //               UserInterestsRoute(),
                            //             );
                            //           },
                            //         ),
                            //       );
                            //     },
                            //   ),
                            // );
                          },
                          onCompleted: (value) {
                            context.router.push(CreateUsernameRoute());
                            consoleLog('otp completed');
                          },

                          onResend: () {
                            //Resend OTP API call
                          },

                          verifyButtonLabel: ref.getLocaleString(
                            "Verify",
                            defaultValue: "Verify",
                          ),
                          // nextRouteName: CreateUsernameRoute(),
                        ),
                      );
                    } else {
                      context.router.push(RegistrationCardInactiveRoute());
                    }
                  },
                  label: ref.getLocaleString('Next', defaultValue: 'Next'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
