import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:dkb_retail/common/utils.dart';
import 'package:dkb_retail/core/constants/app_strings/default_string.dart';
import 'package:dkb_retail/core/router/app_router.dart';
import 'package:dkb_retail/features/common/presentation/components/auth_header_wrapper.dart';
import 'package:dkb_retail/features/registration/presentation/controller/registration_active_controllers.dart';
import 'package:dkb_retail/features/registration/presentation/controller/registration_controller.dart';
import 'package:dkb_retail/features/registration/presentation/controller/registration_notifiers.dart';
import 'package:dkb_retail/features/registration/presentation/widget/card_number_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/data/models/otp_validate_models/validate_otp_request.dart';
import '../../../common/data/models/otp_validate_models/validate_otp_request_request_info_dto.dart';
import '../../../common/domain/locators/common_locators.dart';
import '../../../common/presentation/components/dialogs.dart';

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
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() {
      ref.watch(registrationNotifierProvider.notifier).getCardValidations();
    });
  }

  @override
  Widget build(BuildContext context) {
    final cardController = ref.watch(cardNumberControllerProvider);
    final pinController = ref.watch(pinNumberControllerProvider);
    final cardNode = ref.watch(cardFocusNodeProvider);
    final pinNode = ref.watch(pinFocusNodeProvider);
    final isVisible = ref.watch(isVisibleProvider);
    final isCardValid = ref.watch(isCardValidProvider);
    final cardValidator = ref.watch(regCardValidatorProvider);
    final isValid = _formKey.currentState?.validate() ?? false;
    consoleLog("isvalid $isValid ");

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: AuthHeaderWrapper(
        headerText: DefaultString.instance.registrationCard,
        onBack: () {
          if (isVisible && isCardValid) {
            ref.watch(isVisibleProvider.notifier).state = false;
            ref.watch(isCardValidProvider.notifier).state = false;
            ref.watch(pinNumberControllerProvider).clear();
            cardController.clear();
          } else {
            context.router.maybePop();
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UiSpace.vertical(30),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: UiTextNew.b1Semibold(
                DefaultString.instance.enterYourDebitOrPrepaidCardNumber,
              ),
            ),
            UiSpace.vertical(30),
            Form(
              key: _formKey,
              child: UiTextField(
                autoFocus: true,
                isReadOnly: isCardValid,
                controller: cardController,
                label: DefaultString.instance.enterDebitPerpaidCardNumber,
                maxLength: 19,
                keyboardType: TextInputType.numberWithOptions(),
                validator: cardValidator.validate,
                onChanged: (value) async {
                  setState(() {});
                  if (value.length == 19) {
                    ref.read(isVisibleProvider.notifier).state = true;
                    if (value == '1234 5678 9876 5432') {
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
            ),

            UiSpace.vertical(20),
            isVisible
                ? isCardValid
                      ? UiTextField(
                          obscureText: true,
                          controller: pinController,
                          label: DefaultString.instance.enterPin,
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
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              isVisible
                  ? isValid
                        ? RichText(
                            text: TextSpan(
                              style: TextStyle(
                                color: DefaultColors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                              text: DefaultString.instance.acceptTermsMessage,
                              children: [
                                TextSpan(
                                  style: TextStyle(
                                    color: DefaultColors.blue60,
                                    decoration: TextDecoration.underline,
                                  ),
                                  text:
                                      DefaultString.instance.termsAndConditions,
                                ),
                              ],
                            ),
                          )
                        : SizedBox()
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
                      : !isValid || cardController.text.length < 19,
                  backgroundColor: DefaultColors.blue9D,
                  onPressed: () {
                    // context.router.push(RegisterationOtpRoute());
                    if (isCardValid) {
                      context.router.push(
                        CommonOtpRoute(
                          title: DefaultString.instance.enterOtp,
                          description: DefaultString.instance.otpReceiveMessage,
                          otpLength: 6,
                          timerDuration: const Duration(seconds: 60),
                          // suffixTap: () {
                          //   context.router.replaceAll([LoginRoute()]);
                          // },
                          onVerify: (otp) async {
                            // validate OTP API call
                            consoleLog('otp submitted');
                            final request = ValidateOtpRequest(
                              requestInfo: ValidateOtpRequestRequestInfoDto(
                                  otp: otp
                              ),
                            );
                            final result = await ref.read(commonRepositoryProvider).validateOtp(request: request);

                            result.fold(
                              (failure) => showErrorDialog(
                                failure.description.toString(),
                                context,
                                ref,
                              ),
                              (otpValidate) {
                                context.router.replace(CreateUsernameRoute());
                              },
                            );
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
                          onCompleted: (otp) async {
                            final request = ValidateOtpRequest(
                              requestInfo: ValidateOtpRequestRequestInfoDto(
                                  otp: otp
                              ),
                            );
                            final result = await ref.read(commonRepositoryProvider).validateOtp(request: request);

                            result.fold(
                              (failure) => showErrorDialog(
                                failure.description.toString(),
                                context,
                                ref,
                              ),
                              (otpValidate) {
                                context.router.replace(CreateUsernameRoute());
                              },
                            );
                            consoleLog('otp completed');
                          },

                          onResend: () {
                            //Resend OTP API call
                          },
                          suffixTap: () {
                            context.router.replaceAll([LoginRoute()]);
                          },

                          verifyButtonLabel: DefaultString.instance.verify,
                          // nextRouteName: CreateUsernameRoute(),
                        ),
                      );
                    } else {
                      context.router.push(RegistrationCardInactiveRoute());
                    }
                  },
                  label: DefaultString.instance.nextTitle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
