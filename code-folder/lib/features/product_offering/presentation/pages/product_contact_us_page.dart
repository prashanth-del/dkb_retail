import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:dkb_retail/common/utils.dart';
import 'package:dkb_retail/core/constants/app_strings/default_string.dart';
import 'package:dkb_retail/core/constants/validator/utils/form_validator.dart';
import 'package:dkb_retail/core/router/app_router.dart';
import 'package:dkb_retail/extensions/context_extension.dart';
import 'package:dkb_retail/features/common/data/models/otp_generate_models/generate_otp_request.dart';
import 'package:dkb_retail/features/common/data/models/otp_generate_models/generate_otp_request_request_info_dto.dart';
import 'package:dkb_retail/features/common/data/models/otp_validate_models/validate_otp_request.dart';
import 'package:dkb_retail/features/common/data/models/otp_validate_models/validate_otp_request_request_info_dto.dart';
import 'package:dkb_retail/features/common/domain/locators/common_locators.dart';
import 'package:dkb_retail/features/common/presentation/components/auth_header_wrapper.dart';
import 'package:dkb_retail/features/common/presentation/components/dialogs.dart';
import 'package:dkb_retail/features/product_offering/data/models/create_lead_apply_products_request.dart';
import 'package:dkb_retail/features/product_offering/data/models/create_lead_apply_products_request_lead_info_dto.dart';
import 'package:dkb_retail/features/product_offering/domain/entities/contact_us_modal_payload_item.dart';
import 'package:dkb_retail/features/product_offering/presentation/controller/create_lead_apply_products_notifier.dart';
import 'package:dkb_retail/features/product_offering/presentation/controller/product_offering_providers.dart';
import 'package:dkb_retail/features/product_offering/presentation/controller/state/product_contact_us_notifier.dart';
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
  // bool isValid = false;

  final _formKeyNew = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {};
  String mobileNumber = '';

  List contactUsList = [
    {
      "key": "fullName",
      "label": "Full Name",
      "type": "text",
      "required": true,
      "minLength": 10,
      "maxLength": 30,
    },
    {
      "key": "mobileNumber",
      "label": "Mobile Number",
      "type": "number",
      "required": true,
      "minLength": 8,
      "maxLength": 8,
    },
  ];
  //  late List<dynamic> fields;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.watch(productContactUsNotifierProvider.notifier).getContatcUsFields();
    });

    for (var field in contactUsList) {
      final controller = TextEditingController();
      controllers[field['key']] = controller;

      controller.addListener(_validateForm); // track changes
    }

    _validateForm();
  }

  // void _validateForm() {
  //   // Check if all required fields are filled
  //   bool allFilled = contactUsList.every((field) {
  //     if (field['required'] == true) {
  //       return controllers[field['key']]!.text.trim().isNotEmpty;
  //     }
  //     return true;
  //   });

  //   isFormValid.value = allFilled;
  // }

  void _validateForm() {
    bool allValid = contactUsList.every((field) {
      final text = controllers[field['key']]!.text.trim();

      // Required field check
      if (field['required'] == true && text.isEmpty) {
        return false;
      }

      // Number validation
      if (field['type'] == "number") {
        final minLength = field['minLength'] ?? 0;
        final maxLength = field['maxLength'] ?? 99;

        if (text.length < minLength || text.length > maxLength) {
          return false;
        }
        if (!RegExp(r'^[0-9]+$').hasMatch(text)) {
          return false; // only digits allowed
        }
        final firstDigit = text[0];
        consoleLog('no:$firstDigit ');
        if (!["3", "5", "6", "7"].contains(firstDigit)) {
          return false;
        }
      }

      // Text validation
      if (field['type'] == "text") {
        final minLength = field['minLength'] ?? 0;
        final maxLength = field['maxLength'] ?? 999;

        if (text.length < minLength || text.length > maxLength) {
          return false;
        }
      }

      return true; // passed all checks
    });

    isFormValid.value = allValid;
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

  void createLeadApiCall() {
    _formKeyNew.currentState!.save();
    debugPrint('Form Data: $_formData');
    final jsonBody = jsonEncode(_formData);

    debugPrint('Form Data to dynamic json: $jsonBody');
    final request = CreateLeadApplyProductsRequestLeadInfoDto.fromJson(
      _formData,
    );

    final createLeadApplyProductsRequest = CreateLeadApplyProductsRequest()
        .copyWith(requestInfo: request);

    consoleLog('leadinfo++ : $createLeadApplyProductsRequest ');

    ref
        .read(createLeadApplyProductsNotifierProvider.notifier)
        .createLeadApplyProducts(request: _formData);
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    // final fontSize = size.width * 0.045; // ~4.5% of screen width
    final validate = ref.watch(formValidatorNotifierProvider);
    final asyncFields = ref.watch(productContactUsNotifierProvider);
    final isValid = ref.watch(productsformisValidProvider);

    ref.listen(createLeadApplyProductsNotifierProvider, (previous, next) {
      next.maybeWhen(
        loading: () {
          consoleLog('islOading..');
        },
        success: (data) {
          // UiToast().showToast(data.first.returnCodeDescProvider);
          consoleLog('lead data.. $data');

          showModalBottomSheet(
            isScrollControlled: true,
            isDismissible: false,
            context: context,
            backgroundColor: DefaultColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            builder: (BuildContext context) {
              return SizedBox(
                height: context.height(65),
                child: ContactSuccessSheet(),
              );
            },
          );

          // context.router.push(
          //   CommonOtpRoute(
          //     title: DefaultString.instance.enterOtp,
          //     description: DefaultString.instance.otpReceiveMessage,
          //     otpLength: 6,
          //     timerDuration: const Duration(seconds: 15),
          //     onVerify: (otp) {
          //       // validate OTP API call
          //       // context.router.push(CreateUsernameRoute());
          //       // showModalBottomSheet(
          //       //   context: context,
          //       //   builder: (context, builder) {
          //       //     return Container();
          //       //   },
          //       // );

          //     },
          //     onCompleted: (value) {
          //       showModalBottomSheet(
          //         isScrollControlled: true,
          //         isDismissible: false,
          //         context: context,
          //         backgroundColor: DefaultColors.white,
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadiusGeometry.only(
          //             topLeft: Radius.circular(24),
          //             topRight: Radius.circular(24),
          //           ),
          //         ),
          //         builder: (BuildContext context) {
          //           return SizedBox(
          //             height: context.height(65),
          //             child: ContactSuccessSheet(),
          //           );
          //         },
          //       );
          //     },
          //     suffixTap: () {
          //       context.router.replaceAll([LoginRoute()]);
          //     },
          //     onResend: () {
          //       //Resend OTP API call
          //     },
          //     verifyButtonLabel: DefaultString.instance.verify,
          //     // nextRouteName: CreateUsernameRoute(),
          //   ),
          // );
        },
        failure: (value) {
          UiToast().showToast(value);
        },
        orElse: () {},
      );
    });

    // return Scaffold(
    //   resizeToAvoidBottomInset: true,
    //   body: AuthHeaderWrapper(
    //     headerText: DefaultString.instance.contactDetails,
    //     child: Column(
    //       children: [
    //         UiSpace.vertical(30),
    //         Padding(
    //           padding: const EdgeInsets.only(left: 16),
    //           child: UiTextNew.b1Semibold(
    //             DefaultString
    //                 .instance
    //                 .provideYourDetailsAndWeWillCallYouToExplainTheProduct,
    //             maxLines: 2,
    //           ),
    //         ),
    //         UiSpace.vertical(10),
    //         Form(
    //           key: _formKey,
    //           child: ListView(
    //             shrinkWrap: true,
    //             children: [
    //               ...contactUsList.map((field) {
    //                 // return Padding(
    //                 //   padding: const EdgeInsets.only(bottom: 16),
    //                 //   child: TextFormField(
    //                 //     controller: controllers[field['key']],
    //                 //     keyboardType: field['type'] == "number"
    //                 //         ? TextInputType.number
    //                 //         : TextInputType.text,
    //                 //     decoration: InputDecoration(
    //                 //       labelText: field['label'],
    //                 //       border: const OutlineInputBorder(),
    //                 //     ),
    //                 //     validator: (value) => _validator(field, value),
    //                 //   ),
    //                 // );
    //                 return Padding(
    //                   padding: const EdgeInsets.only(bottom: 16),
    //                   child: UiTextField(
    //                     maxLength: field['maxLength'],
    //                     controller: controllers[field['key']]!,
    //                     label: field['label'],
    //                     prefix: field['type'] == "number"
    //                         ? UiTextNew.customRubik(
    //                             "+974-",
    //                             fontSize: 14,
    //                             fontWeight: FontWeight.w600,
    //                           )
    //                         : null,
    //                     keyboardType: field['type'] == "number"
    //                         ? TextInputType.number
    //                         : TextInputType.text,
    //                     validator: (val) {
    //                       if (val != null && val.isNotEmpty) {
    //                         return field['type'] == "number"
    //                             ? qatarMobileValidator(val)
    //                             : validate.fullNameValidation(val);
    //                       }
    //                       return null;
    //                     },
    //                     // inputFormatters: [
    //                     //   field['type'] == "number"
    //                     //       ? QatartPhoneFormatter()
    //                     //       : FilteringTextInputFormatter.allow('[a-zA-Z]'),
    //                     // ],
    //                   ),
    //                 );
    //               }),
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    //   bottomNavigationBar: SafeArea(
    //     child: Padding(
    //       padding: EdgeInsets.only(
    //         bottom: MediaQuery.of(context).viewInsets.bottom,
    //       ),
    //       child: Container(
    //         margin: EdgeInsets.symmetric(horizontal: 16),
    //         width: double.infinity,
    //         child: ValueListenableBuilder(
    //           valueListenable: isFormValid,
    //           builder: (context, value, child) {
    //             return UIButton.rounded(
    //               height: 48,
    //               btnCurve: 30,
    //               isDisabled: !value,
    //               backgroundColor: DefaultColors.blue9D,
    //               onPressed: () {
    //                 // context.router.push(RegisterationOtpRoute());
    //                 context.router.push(
    //                   CommonOtpRoute(
    //                     title: DefaultString.instance.enterOtp,
    //                     description: DefaultString.instance.otpReceiveMessage,
    //                     otpLength: 6,
    //                     timerDuration: const Duration(seconds: 15),
    //                     onVerify: (otp) {
    //                       // validate OTP API call
    //                       // context.router.push(CreateUsernameRoute());
    //                       // showModalBottomSheet(
    //                       //   context: context,
    //                       //   builder: (context, builder) {
    //                       //     return Container();
    //                       //   },
    //                       // );
    //                       showModalBottomSheet(
    //                         isScrollControlled: true,
    //                         isDismissible: false,
    //                         context: context,
    //                         backgroundColor: DefaultColors.white,
    //                         shape: RoundedRectangleBorder(
    //                           borderRadius: BorderRadiusGeometry.only(
    //                             topLeft: Radius.circular(24),
    //                             topRight: Radius.circular(24),
    //                           ),
    //                         ),
    //                         builder: (BuildContext context) {
    //                           return SizedBox(
    //                             height: context.height(60),
    //                             child: ContactSuccessSheet(),
    //                           );
    //                         },
    //                       );
    //                     },
    //                     onCompleted: (value) {
    //                       showModalBottomSheet(
    //                         isScrollControlled: true,
    //                         isDismissible: false,
    //                         context: context,
    //                         backgroundColor: DefaultColors.white,
    //                         shape: RoundedRectangleBorder(
    //                           borderRadius: BorderRadiusGeometry.only(
    //                             topLeft: Radius.circular(24),
    //                             topRight: Radius.circular(24),
    //                           ),
    //                         ),
    //                         builder: (BuildContext context) {
    //                           return SizedBox(
    //                             height: context.height(65),
    //                             child: ContactSuccessSheet(),
    //                           );
    //                         },
    //                       );
    //                     },
    //                     suffixTap: () {
    //                       context.router.replaceAll([LoginRoute()]);
    //                     },
    //                     onResend: () {
    //                       //Resend OTP API call
    //                     },
    //                     verifyButtonLabel: DefaultString.instance.verify,
    //                     // nextRouteName: CreateUsernameRoute(),
    //                   ),
    //                 );
    //               },
    //               label: DefaultString.instance.nextTitle,
    //             );
    //           },
    //         ),
    //       ),
    //     ),
    //   ),
    // );

    return Scaffold(
      // appBar: AppBar(title: const Text('Dynamic Form')),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            width: double.infinity,
            child: UIButton.rounded(
              height: 48,
              btnCurve: 30,
              isDisabled: !isValid,
              backgroundColor: DefaultColors.blue9D,
              onPressed: () {
                // context.router.push(RegisterationOtpRoute());
                // final jsonBody = jsonEncode(_formData);
                // debugPrint('Form Data to dynamic json: $jsonBody');
                //createLeadApiCall();
                context.router.push(
                  CommonOtpRoute(
                    generateOtpBefore: true,
                    mobileNumber: '+97433333335',
                    action: 'login',
                    onGenerateOtp: (result) async{
                      if (!result['success']) {
                        context.router.maybePop();
                        showErrorDialog(result['errorMessage'] ?? "Failed to generate OTP", context, ref);
                      }
                    },
                    title: DefaultString.instance.enterOtp,
                    description: DefaultString.instance.otpReceiveMessage,
                    otpLength: 6,
                    timerDuration: const Duration(seconds: 15),
                    onVerify: (otp) async {
                      final request = ValidateOtpRequest(
                        requestInfo: ValidateOtpRequestRequestInfoDto(otp: otp),
                      );
                      final result = await ref
                          .read(commonRepositoryProvider)
                          .validateOtp(request: request);

                      result.fold(
                        (failure) => showErrorDialog(
                          failure.description.toString(),
                          context,
                          ref,
                        ),
                        (otpValidate) {
                          createLeadApiCall();
                          // showModalBottomSheet(
                          //   isScrollControlled: true,
                          //   isDismissible: false,
                          //   context: context,
                          //   backgroundColor: DefaultColors.white,
                          //   shape: RoundedRectangleBorder(
                          //     borderRadius: BorderRadiusGeometry.only(
                          //       topLeft: Radius.circular(24),
                          //       topRight: Radius.circular(24),
                          //     ),
                          //   ),
                          //   builder: (BuildContext context) {
                          //     return SizedBox(
                          //       height: context.height(60),
                          //       child: ContactSuccessSheet(),
                          //     );
                          //   },
                          // );
                        },
                      );
                    },
                    onCompleted: (otp) async {
                      final request = ValidateOtpRequest(
                        requestInfo: ValidateOtpRequestRequestInfoDto(otp: otp),
                      );
                      final result = await ref
                          .read(commonRepositoryProvider)
                          .validateOtp(request: request);

                      result.fold(
                        (failure) => showErrorDialog(
                          failure.description.toString(),
                          context,
                          ref,
                        ),

                        (otpValidate) {
                          createLeadApiCall();
                        },
                      );
                    },
                    suffixTap: () {
                      context.router.replaceAll([LoginRoute()]);
                    },
                    onResend: () async {
                      final request = GenerateOtpRequest(
                        requestInfo: GenerateOtpRequestRequestInfoDto(
                          action: "login",
                          mobileNumber: "+97433333333",
                        ),
                      );
                      ref
                          .read(commonRepositoryProvider)
                          .generateOtp(request: request);
                    },
                    verifyButtonLabel: DefaultString.instance.verify,
                    // nextRouteName: CreateUsernameRoute(),
                  ),
                );
              },
              label: DefaultString.instance.nextTitle,
              // onPressed: () {
              //   // context.router.push(RegisterationOtpRoute());
              //   _formKeyNew.currentState!.save();
              //   debugPrint('Form Data: $_formData');

              //   final request =
              //       CreateLeadApplyProductsRequestLeadInfoDto.fromJson(
              //         _formData,
              //       );

              //   final createLeadApplyProductsRequest =
              //       CreateLeadApplyProductsRequest().copyWith(
              //         leadInfo: request,
              //       );

              //   consoleLog('leadinfo++ : $createLeadApplyProductsRequest ');

              //   ref
              //       .read(createLeadApplyProductsNotifierProvider.notifier)
              //       .createLeadApplyProducts(
              //         request: createLeadApplyProductsRequest,
              //       );
              // },
              // label: DefaultString.instance.nextTitle,
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: asyncFields.when(
        data: (fields) {
          fields.sort(
            (a, b) => (a.sequence as int).compareTo(b.sequence as int),
          );

          return AuthHeaderWrapper(
            headerText: DefaultString.instance.contactDetails,
            child: Column(
              children: [
                UiSpace.vertical(30),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: UiTextNew.b1Semibold(
                    DefaultString
                        .instance
                        .provideYourDetailsAndWeWillCallYouToExplainTheProduct,
                    maxLines: 2,
                  ),
                ),
                Form(
                  key: _formKeyNew,
                  child: ListView(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    // padding: const EdgeInsets.all(16),
                    children: [
                      // ...fields.map((field) => _buildFormField(field)),
                      ...(fields?.isNotEmpty ?? false)
                          ? fields!
                                .map((field) => _buildFormField(field))
                                .toList()
                          : [const SizedBox.shrink()],

                      // const SizedBox(height: 20),
                      // ElevatedButton(
                      //   onPressed: () {
                      //     if (_formKeyNew.currentState!.validate()) {
                      //       _formKeyNew.currentState!.save();
                      //       debugPrint('Form Data: $_formData');
                      //     }
                      //   },
                      //   child: const Text('Submit'),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: UiLoader()),
        error: (err, _) => Center(child: Text(err.toString())),
      ),
    );
  }

  Widget _buildFormField(ContactUsModalPayloadItem field) {
    final isMandatory = field.fieldOption.toLowerCase() == 'mandatory';

    // Dropdown field
    if (field.fieldOptions != null &&
        field.fieldOptions is List &&
        (field.fieldOptions as List).isNotEmpty) {
      final List options = field.fieldOptions as List;
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: DropdownButtonFormField<String>(
          onChanged: (value) {},
          decoration: InputDecoration(
            labelText: field.fieldName,
            border: const OutlineInputBorder(),
          ),
          items: options
              .map(
                (opt) =>
                    DropdownMenuItem(value: opt.toString(), child: Text(opt)),
              )
              .toList(),
          validator: (val) {
            if (isMandatory && (val == null || val.isEmpty)) {
              return '${field.fieldName} is required';
            }

            return null;
          },
          onSaved: (val) => _formData[field.fieldName] = val,
        ),
      );
    }

    // Text field
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: UiTextField(
        label: isMandatory
            ? field.fieldName
            : '${field.fieldName} (${field.fieldOption})',
        onChanged: (value) {
          _formData[field.fieldKey] = value;
          // setState(() {
          //   isValid = _formKeyNew.currentState?.validate() ?? false;
          // });
          if (field.fieldType == 'numeric') {
            mobileNumber = value;
          }
          ref.read(productsformisValidProvider.notifier).state =
              _formKeyNew.currentState?.validate() ?? false;
        },
        maxLength: int.tryParse(field.fieldLength),
        prefix: field.fieldType == 'numeric'
            ? UiTextNew.customRubik(
                "+974-",
                fontSize: 14,
                fontWeight: FontWeight.w600,
              )
            : null,
        keyboardType: field.fieldType == 'numeric'
            ? TextInputType.numberWithOptions()
            : TextInputType.name,
        validator: (val) {
          // if (isMandatory) {
          //   return '${field.fieldName} is required';
          // }
          if (isMandatory && (val == null || val.isEmpty)) {
            return '${field.fieldName} is required';
          }
          if (field.fieldType == 'numeric') {
            // Ensure input is numeric and matches the expected length
            final expectedLength =
                int.tryParse(field.fieldLength) ??
                8; // Default to 10 if parsing fails
            if (val != null && val.length != expectedLength) {
              return '${field.fieldName} must be $expectedLength digits';
            }
          }

          if (field.fieldValidations.isNotEmpty) {
            if (isMandatory) {
              try {
                final regex = RegExp(field.fieldValidations);
                if (!regex.hasMatch(val ?? '')) {
                  return 'Invalid ${field.fieldName}';
                }
              } catch (_) {
                debugPrint(
                  'Invalid regex for ${field.fieldName}: ${field.fieldValidations}',
                );
              }
            }
          }

          return null;
        },
        onFieldSubmitted: (val) => _formData[field.fieldKey] = val,
      ),
    );
  }
}
