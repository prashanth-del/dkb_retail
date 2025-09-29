import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/components.dart';
import 'package:dkb_retail/features/common/dialog/custom_sheet.dart';
import 'package:dkb_retail/features/reach_us/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/validator/utils/form_validator.dart';
import '../../../../core/utils/ui_components/auto_leading_widget.dart';
import '../widgets/callback_request_sheet.dart';
import '../widgets/reason_sheet_widget.dart';

@RoutePage(name: "RequestCallbackPageRoute")
class RequestCallbackPage extends ConsumerStatefulWidget {
  const RequestCallbackPage({super.key});
  @override
  ConsumerState<RequestCallbackPage> createState() =>
      _RequestCallbackPageState();
}

class _RequestCallbackPageState extends ConsumerState<RequestCallbackPage> {
  late TextEditingController nameController;
  late TextEditingController mobileNumberController;
  late TextEditingController emailController;
  late TextEditingController reasonController;
  bool isReasonDropdownOpen = false;

  GlobalKey<FormState> abFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    mobileNumberController = TextEditingController();
    emailController = TextEditingController();
    reasonController = TextEditingController();
    nameController.addListener(() => setState(() {}));
    mobileNumberController.addListener(() => setState(() {}));
    emailController.addListener(() => setState(() {}));
    reasonController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    nameController.dispose();
    mobileNumberController.dispose();
    emailController.dispose();
    reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final validate = ref.watch(formValidatorNotifierProvider);

    final isRequiredFilled =
        nameController.text.isNotEmpty &&
        mobileNumberController.text.isNotEmpty &&
        reasonController.text.isNotEmpty;

    // validate email if not empty
    final isEmailValid =
        emailController.text.isEmpty ||
        (abFormKey.currentState?.validate() ?? false);

    final isFormReady = isRequiredFilled && isEmailValid;

    return Scaffold(
      backgroundColor: DefaultColors.white,
      appBar: UIAppBar.secondary(
        autoLeadingWidget: LeadingWidget(title: "Request CallBack"),
        title: '',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Form(
          key: abFormKey,
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  ////
                  children: [
                    UiTextField(
                      //  maxLength: 8,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      obscureText: false,
                      controller: nameController,
                      label: "Full Name",
                      validator: (val) {
                        if (val != null && val.isNotEmpty) {
                          return validate.fullNameValidation(val);
                        }
                      },
                    ),
                    const SizedBox(height: 12),
                    UiTextField(
                      maxLength: 8,
                      keyboardType: TextInputType.number,
                      controller: mobileNumberController,
                      label: "Mobile Number",
                      prefix: UiTextNew.customRubik(
                        "+974",
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                      obscureText: false,

                      // ✅ Allow paste/copy but restrict to digits only
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],

                      validator: (val) {
                        if (val != null && val.isNotEmpty) {
                          return validate.qatarMobileNumberValidation(val);
                        }
                        return null;
                      },
                    ),

                    // UiTextField(
                    //   maxLength: 8,
                    //   keyboardType: TextInputType.number,
                    //   controller: mobileNumberController,
                    //   label: "Mobile Number",
                    //   prefix: UiTextNew.customRubik(
                    //     "+974-",
                    //     fontSize: 15,
                    //     fontWeight: FontWeight.w500,
                    //   ),
                    //
                    //   //  inputFormatters: [QatarPhoneFormatter()],
                    //   obscureText: false,
                    //
                    //   validator: (val) {
                    //     if (val != null && val.isNotEmpty) {
                    //       return validate.qatarMobileNumberValidation(val);
                    //     }
                    //     return null;
                    //   },
                    // ),
                    const SizedBox(height: 12),
                    UiTextField(
                      controller: emailController,
                      label: "Email (Optional)",
                      obscureText: false,
                      validator: (val) {
                        // only validate if not empty
                        if (val != null && val.isNotEmpty) {
                          return validate.emailValidation(val);
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    UiTextField(
                      onTap: () {
                        setState(() => isReasonDropdownOpen = true);
                        CustomSheet.show(
                          context: context,
                          child: ReasonSheetWidget(
                            currentReason: reasonController.text,
                            reasonSelected: (val) {
                              if (val != null) {
                                reasonController.text = val;
                                print(reasonController.text);
                                setState(() {
                                  isReasonDropdownOpen = false;
                                });
                              }
                            },
                          ),
                        ).then((_) {
                          setState(() => isReasonDropdownOpen = false);
                        });
                      },
                      isReadOnly: true,
                      controller: reasonController,
                      label: "Reason",
                      suffix: Icon(
                        isReasonDropdownOpen
                            ? Icons.keyboard_arrow_up_outlined
                            : Icons.keyboard_arrow_down_outlined,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              CustomButtonNewWidget(
                onPress: () {
                  if (isFormReady) {
                    // Run a full validation pass
                    if (abFormKey.currentState?.validate() ?? false) {
                      CustomSheet.show(
                        context: context,
                        child: CallbackRequestSheet(),
                      );
                    }
                  }
                },
                title: "Next",
                buttonColor: isFormReady
                    ? DefaultColors.blueBase
                    : DefaultColors.grayMedBase,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

// 1️⃣ Create a custom formatter class

// class QatartPhoneFormatter extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(
//     TextEditingValue oldValue,
//     TextEditingValue newValue,
//   ) {
//     String text = newValue.text;
//
//     // Ensure it always starts with +971
//     if (!text.startsWith('+974')) {
//       text = '+974' + text.replaceAll('+974', '');
//     }
//
//     return TextEditingValue(
//       text: text,
//       selection: TextSelection.collapsed(offset: text.length),
//     );
//   }
// }

class QatarPhonePrefixFormatter extends TextInputFormatter {
  final String prefix = '+974-';

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text = newValue.text;

    // If the user deletes the prefix, re-add it
    if (!text.startsWith(prefix)) {
      text = prefix + text.replaceAll(prefix, '');
    }

    // Remove any non-digit characters after the prefix
    String afterPrefix = text
        .substring(prefix.length)
        .replaceAll(RegExp(r'[^0-9]'), '');
    text = prefix + afterPrefix;

    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
