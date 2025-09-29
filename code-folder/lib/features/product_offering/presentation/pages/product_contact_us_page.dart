import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:dkb_retail/core/constants/validator/utils/form_validator.dart';
import 'package:dkb_retail/core/router/app_router.dart';
import 'package:dkb_retail/core/utils/extensions/locale_extension.dart';
import 'package:dkb_retail/features/product_offering/presentation/widgets/contact_success_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class ProductContactUsPage extends ConsumerStatefulWidget {
  const ProductContactUsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProductContactUsPageState();
}

class _ProductContactUsPageState extends ConsumerState<ProductContactUsPage> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> controllers = {};
  final ValueNotifier<bool> isFormValid = ValueNotifier(false);

  List contactUsList = [
    {
      "key": "fullName",
      "label": "Full Name",
      "type": "text",
      "required": true,
      "minLength": 20,
      "maxLength": 30,
    },
    {
      "key": "mobileNumber",
      "label": "Mobile Number",
      "type": "number",
      "required": true,
      "minLength": 10,
      "maxLength": 10,
    },
  ];
  //  late List<dynamic> fields;

  @override
  void initState() {
    super.initState();
    for (var field in contactUsList) {
      final controller = TextEditingController();
      controllers[field['key']] = controller;

      controller.addListener(_validateForm); // track changes
    }

    _validateForm();
  }

  void _validateForm() {
    // Check if all required fields are filled
    bool allFilled = contactUsList.every((field) {
      if (field['required'] == true) {
        return controllers[field['key']]!.text.trim().isNotEmpty;
      }
      return true;
    });

    isFormValid.value = allFilled;
  }

  @override
  void dispose() {
    for (var controller in controllers.values) {
      controller.dispose();
    }
    isFormValid.dispose();
    super.dispose();
  }

  String? _validator(Map field, String? value) {
    if (field['required'] == true && (value == null || value.isEmpty)) {
      return "${field['label']} is required";
    }
    if (field['minLength'] != null && value!.length < field['minLength']) {
      return "${field['label']} must be at least ${field['minLength']} characters";
    }
    if (field['maxLength'] != null && value!.length > field['maxLength']) {
      return "${field['label']} must be at most ${field['maxLength']} characters";
    }
    if (field['type'] == "email" && value!.isNotEmpty) {
      final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
      if (!emailRegex.hasMatch(value)) {
        return "Enter a valid email";
      }
    }
    return null;
  }

  bool? isEmpty(Map field) {
    if (controllers[field['key']]!.text.isEmpty) {
      return true;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fontSize = size.width * 0.045; // ~4.5% of screen width
    final validate = ref.watch(formValidatorNotifierProvider);
    return Scaffold(
      backgroundColor: DefaultColors.white,
      body: UiBackgroundWrapper(
        child: Column(
          children: [
            UiSpace.vertical(40),
            CommonAuthAppBar(
              title: ref.getLocaleString(
                "Contact Details",
                defaultValue: "Contact Details",
              ),
            ),
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    ...contactUsList.map((field) {
                      // return Padding(
                      //   padding: const EdgeInsets.only(bottom: 16),
                      //   child: TextFormField(
                      //     controller: controllers[field['key']],
                      //     keyboardType: field['type'] == "number"
                      //         ? TextInputType.number
                      //         : TextInputType.text,
                      //     decoration: InputDecoration(
                      //       labelText: field['label'],
                      //       border: const OutlineInputBorder(),
                      //     ),
                      //     validator: (value) => _validator(field, value),
                      //   ),
                      // );
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: UiTextField(
                          maxLength: field['maxLength'],
                          controller: controllers[field['key']]!,
                          label: field['label'],
                          prefix: field['type'] == "number"
                              ? UiTextNew.customRubik(
                                  "+974",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                )
                              : null,
                          keyboardType: field['type'] == "number"
                              ? TextInputType.number
                              : TextInputType.text,
                          validator: (val) {
                            if (val != null && val.isNotEmpty) {
                              return field['type'] == "number"
                                  ? validate.qatarMobileNumberValidation(val)
                                  : validate.fullNameValidation(val);
                            }
                            return null;
                          },
                          // inputFormatters: [
                          //   field['type'] == "number"
                          //       ? QatartPhoneFormatter()
                          //       : FilteringTextInputFormatter.allow('[a-zA-Z]'),
                          // ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            width: double.infinity,
            child: ValueListenableBuilder(
              valueListenable: isFormValid,
              builder: (context, value, child) {
                return UIButton.rounded(
                  height: 48,
                  btnCurve: 30,
                  isDisabled: !value,
                  backgroundColor: DefaultColors.blue9D,
                  onPressed: () {
                    // context.router.push(RegisterationOtpRoute());
                    context.router.push(
                      CommonOtpRoute(
                        title: ref.getLocaleString(
                          "Enter OTP",
                          defaultValue: "Enter OTP",
                        ),
                        description: ref.getLocaleString(
                          "you will receive the OTP on your mobile number.",
                          defaultValue:
                              "you will receive the OTP on your mobile number.",
                        ),
                        otpLength: 6,
                        timerDuration: const Duration(seconds: 15),
                        onVerify: (otp) {
                          // validate OTP API call
                          // context.router.push(CreateUsernameRoute());
                          // showModalBottomSheet(
                          //   context: context,
                          //   builder: (context, builder) {
                          //     return Container();
                          //   },
                          // );
                          showModalBottomSheet(
                            isDismissible: false,
                            context: context,
                            builder: (BuildContext context) {
                              return ContactSuccessSheet();
                            },
                          );
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
                  },
                  label: ref.getLocaleString('Next', defaultValue: 'Next'),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
