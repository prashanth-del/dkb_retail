import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:dkb_retail/common/utils.dart';
import 'package:dkb_retail/core/constants/asset_path/asset_path.dart';
import 'package:dkb_retail/core/router/app_router.dart';
import 'package:dkb_retail/core/utils/extensions/locale_extension.dart';
import 'package:dkb_retail/features/registration/presentation/controller/registration_active_controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class CreatePinPage extends ConsumerStatefulWidget {
  const CreatePinPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreatePinPageState();
}

class _CreatePinPageState extends ConsumerState<CreatePinPage> {
  final pinTextController = TextEditingController();
  final confirmPinTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isMatch = ref.watch(isConfirmPINProvider);
    final password = ref.watch(pinProvider);
    final confirmPassword = ref.watch(confirmPINProvider);
    final isPinVisible = ref.watch(pinVisibleProvider);
    final isConfirmPinVisible = ref.watch(confirmpinVisibleProvider);

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
                  "Create PIN",
                  defaultValue: "Create PIN",
                ),
              ),
              UiSpace.vertical(16),
              UiTextField(
                autoFocus: true,
                maxLength: 4,
                obscureText: !isPinVisible,
                controller: pinTextController,
                suffix: GestureDetector(
                  onTap: () {
                    ref.read(pinVisibleProvider.notifier).state = !isPinVisible;
                  },
                  child: Icon(
                    isPinVisible
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                  ),
                ),
                label: ref.getLocaleString(
                  'Enter PIN',
                  defaultValue: 'Enter PIN',
                ),
                keyboardType: TextInputType.numberWithOptions(),
                onChanged: (value) {
                  ref.read(pinProvider.notifier).state = value;
                },

                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
              ),

              UiSpace.vertical(16),

              UiTextField(
                isReadOnly: password.isEmpty,
                maxLength: 4,
                obscureText: !isConfirmPinVisible,
                controller: confirmPinTextController,

                suffix: confirmPassword.isEmpty
                    ? null
                    : GestureDetector(
                        onTap: () {
                          ref.read(confirmpinVisibleProvider.notifier).state =
                              !isConfirmPinVisible;
                        },
                        child: Icon(
                          isConfirmPinVisible
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                      ),
                onChanged: (value) {
                  ref.read(confirmPINProvider.notifier).state = value;
                },

                label: ref.getLocaleString(
                  'Confirm PIN',
                  defaultValue: 'Confirm PIN',
                ),
                keyboardType: TextInputType.numberWithOptions(),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
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
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                width: double.infinity,
                child: UIButton.rounded(
                  height: 48,
                  btnCurve: 30,
                  isDisabled: !isMatch,
                  backgroundColor: DefaultColors.blue9D,
                  onPressed: () {
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
                          consoleLog('otp: $otp');

                          // UIPopupDialog().showPopup(
                          //   viewModel: UIPopupViewModel(
                          //     barrierDismissible: false,
                          //     context: context,
                          //     title: ref.getLocaleString(
                          //       'Successfully',
                          //       defaultValue: 'Successfully',
                          //     ),
                          //     content: ref.getLocaleString(
                          //       'Card Activated',
                          //       defaultValue: 'Card Activated',
                          //     ),
                          //   ),
                          // );
                          showDialog(
                            context: context,
                            builder: (_) {
                              return AlertDialog(
                                contentPadding: EdgeInsets.zero,
                                content: SizedBox(
                                  height: 300,
                                  child: Stack(
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Image.asset(
                                          AssetPath.image.vectorleft,
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerRight,
                                        child: Image.asset(
                                          AssetPath.image.vectorright,
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Center(
                                            child: UiTextNew.h2Semibold(
                                              'Card Activated\nSuccessfully',
                                              textAlign: TextAlign.center,
                                              color: DefaultColors.blue9D,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );

                          Future.delayed(Duration(seconds: 2), () {
                            Navigator.of(context, rootNavigator: true).pop();
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
                          });
                        },
                        onCompleted: (value) {
                          showDialog(
                            context: context,
                            builder: (_) {
                              return AlertDialog(
                                contentPadding: EdgeInsets.zero,
                                content: SizedBox(
                                  height: 300,
                                  child: Stack(
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Image.asset(
                                          AssetPath.image.vectorleft,
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerRight,
                                        child: Image.asset(
                                          AssetPath.image.vectorright,
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Center(
                                            child: UiTextNew.h2Semibold(
                                              'Card Activated\nSuccessfully',
                                              textAlign: TextAlign.center,
                                              color: DefaultColors.blue9D,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );

                          Future.delayed(Duration(seconds: 2), () {
                            Navigator.of(context, rootNavigator: true).pop();
                            context.router.push(CreateUsernameRoute());
                          });
                        },
                        onResend: () {
                          //Resend OTP API call
                        },
                        verifyButtonLabel: ref.getLocaleString(
                          "Verify",
                          defaultValue: "Verify",
                        ),
                        // nextRouteName: SetPasswordRoute(),
                      ),
                    );
                  },
                  label: ref.getLocaleString(
                    'Confirm PIN',
                    defaultValue: 'Confirm PIN',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
