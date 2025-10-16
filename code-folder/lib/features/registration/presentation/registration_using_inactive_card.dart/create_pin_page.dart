import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:dkb_retail/common/utils.dart';
import 'package:dkb_retail/core/constants/app_strings/default_string.dart';
import 'package:dkb_retail/core/router/app_router.dart';
import 'package:dkb_retail/features/common/presentation/components/auth_header_wrapper.dart';
import 'package:dkb_retail/features/registration/presentation/controller/registration_active_controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/data/models/otp_validate_models/validate_otp_request.dart';
import '../../../common/data/models/otp_validate_models/validate_otp_request_request_info_dto.dart';
import '../../../common/domain/locators/common_locators.dart';
import '../../../common/presentation/components/dialogs.dart';

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
      body: AuthHeaderWrapper(
        headerText: DefaultString.instance.createPin,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UiSpace.vertical(30),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: UiTextNew.b1Semibold(
                DefaultString.instance.createNewPinToActivateYourCard,
              ),
            ),
            UiSpace.vertical(30),
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
              label: DefaultString.instance.enterPin,
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

              label: DefaultString.instance.confirmPin,
              keyboardType: TextInputType.numberWithOptions(),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
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
                          final request = ValidateOtpRequest(
                            requestInfo: ValidateOtpRequestRequestInfoDto(
                                otp: otp
                            ),
                          );
                          final result = await ref.read(commonRepositoryProvider).validateOtp(request: request);

                          result.fold(
                            (failure) =>
                                showErrorDialog(failure.description.toString(), context, ref),
                            (otpValidate) {
                              // validate OTP API call
                              consoleLog('otp: $otp');
                              // showDialog(
                              //   context: context,
                              //   barrierDismissible: false,
                              //   builder: (_) {
                              //     return AlertDialog(
                              //       contentPadding: EdgeInsets.zero,
                              //       content: SizedBox(
                              //         height: 300,
                              //         child: Stack(
                              //           children: [
                              //             Container(
                              //               alignment: Alignment.centerLeft,
                              //               child: Image.asset(
                              //                 AssetPath.image.vectorleft,
                              //               ),
                              //             ),
                              //             Container(
                              //               alignment: Alignment.centerRight,
                              //               child: Image.asset(
                              //                 AssetPath.image.vectorright,
                              //               ),
                              //             ),
                              //             Column(
                              //               mainAxisAlignment:
                              //                   MainAxisAlignment.center,
                              //               children: [
                              //                 Center(
                              //                   child: UiTextNew.h2Semibold(
                              //                     DefaultString
                              //                         .instance
                              //                         .cardActivatedSuccessfully,
                              //                     textAlign: TextAlign.center,
                              //                     color: DefaultColors.blue9D,
                              //                     maxLines: 2,
                              //                   ),
                              //                 ),
                              //               ],
                              //             ),
                              //           ],
                              //         ),
                              //       ),
                              //     );
                              //   },
                              // );

                              // Future.delayed(Duration(seconds: 2), () {
                              //   Navigator.of(context, rootNavigator: true).pop();
                              //   context.router.replace(CreateUsernameRoute());

                              // });

                              context.router.push(
                                CommonTaskCompleteRoute(
                                  title: DefaultString
                                      .instance
                                      .cardActivatedSuccessfully,
                                  disableBack: true,
                                  countdownSeconds: 3,
                                  titleStyle: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: DefaultColors.white,
                                  ),
                                  onCountdownComplete: () {
                                    context.router.replace(
                                      CreateUsernameRoute(),
                                    );
                                  },
                                ),
                              );
                            },
                          );
                        },
                        onCompleted: (otp) async {
                          final request = ValidateOtpRequest(
                            requestInfo: ValidateOtpRequestRequestInfoDto(
                                otp: otp
                            ),
                          );
                          final result = await ref.read(commonRepositoryProvider).validateOtp(request: request);

                          result.fold(
                            (failure) =>
                                showErrorDialog(failure.description.toString(), context, ref),
                            (otpValidate) {
                              // showDialog(
                              //   barrierDismissible: false,
                              //   context: context,
                              //   builder: (_) {
                              //     return AlertDialog(
                              //       contentPadding: EdgeInsets.zero,
                              //       content: SizedBox(
                              //         height: 300,
                              //         child: Stack(
                              //           children: [
                              //             Container(
                              //               alignment: Alignment.centerLeft,
                              //               child: Image.asset(
                              //                 AssetPath.image.vectorleft,
                              //               ),
                              //             ),
                              //             Container(
                              //               alignment: Alignment.centerRight,
                              //               child: Image.asset(
                              //                 AssetPath.image.vectorright,
                              //               ),
                              //             ),
                              //             Column(
                              //               mainAxisAlignment:
                              //                   MainAxisAlignment.center,
                              //               children: [
                              //                 Center(
                              //                   child: UiTextNew.h2Semibold(
                              //                     DefaultString
                              //                         .instance
                              //                         .cardActivatedSuccessfully,
                              //                     textAlign: TextAlign.center,
                              //                     color: DefaultColors.blue9D,
                              //                   ),
                              //                 ),
                              //               ],
                              //             ),
                              //           ],
                              //         ),
                              //       ),
                              //     );
                              //   },
                              // );

                              // Future.delayed(Duration(seconds: 2), () {
                              //   Navigator.of(context, rootNavigator: true).pop();
                              //   context.router.replace(CreateUsernameRoute());
                              // });

                              context.router.push(
                                CommonTaskCompleteRoute(
                                  title: DefaultString
                                      .instance
                                      .cardActivatedSuccessfully,
                                  disableBack: true,
                                  countdownSeconds: 3,
                                  titleStyle: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: DefaultColors.white,
                                  ),
                                  onCountdownComplete: () {
                                    context.router.replace(
                                      CreateUsernameRoute(),
                                    );
                                  },
                                ),
                              );
                            },
                          );
                        },
                        onResend: () {
                          //Resend OTP API call
                        },
                        suffixTap: () {
                          context.router.replaceAll([LoginRoute()]);
                        },
                        verifyButtonLabel: DefaultString.instance.verify,
                        // nextRouteName: SetPasswordRoute(),
                      ),
                    );
                  },
                  label: DefaultString.instance.confirmPin,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
