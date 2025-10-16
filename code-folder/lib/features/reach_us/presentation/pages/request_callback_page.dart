import 'package:async_ui/async_ui.dart';
import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/components.dart';
import 'package:dkb_retail/features/common/presentation/components/dialogs.dart';
import 'package:dkb_retail/features/common/presentation/dialog/custom_sheet.dart';
import 'package:dkb_retail/features/reach_us/data/models/fetch_callback_fields_request.dart';
import 'package:dkb_retail/features/reach_us/presentation/state/fetch_callback_fields_state.dart';
import 'package:dkb_retail/features/reach_us/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_strings/default_string.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/validator/utils/form_validator.dart';
import '../../../../core/constants/validator/utils/validators/form_validator.dart';
import '../../../common/presentation/components/auth_header_wrapper.dart';
import '../../data/models/fetch_call_back_request_request.dart';
import '../../domain/entities/callback_fields.dart';
import '../controller/fetch_call_back_request_notifier.dart';
import '../controller/fetch_callback_fields_notifier.dart';
import '../state/fetch_call_back_request_state.dart';
import '../widgets/callback_request_sheet.dart';
import '../widgets/empty_widget.dart';
import '../widgets/reason_sheet_widget.dart';

@RoutePage(name: "RequestCallbackPageRoute")
class RequestCallbackPage extends ConsumerStatefulWidget {
  const RequestCallbackPage({super.key});

  @override
  ConsumerState<RequestCallbackPage> createState() =>
      _RequestCallbackPageState();
}

class _RequestCallbackPageState extends ConsumerState<RequestCallbackPage> {
  final Map<String, TextEditingController> fieldControllers = {};
  bool isDropdownOpen = false;
  GlobalKey<FormState> abFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    fieldControllers.values.forEach((c) => c.dispose());
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      // todo add this for new structrure
      ref
          .read(fetchCallbackFieldsNotifierProvider.notifier)
          .fetchCallbackFields(
            request: FetchCallbackFieldsRequest(/* add required params */),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final validate = ref.watch(formValidatorNotifierProvider);
    ref.listen<FetchCallBackRequestState>(
      // listener apis when i implement apis on button
      fetchCallBackRequestNotifierProvider,
      (previous, next) {
        next.maybeWhen(
          success: (_) {
            CustomSheet.show(
              isDismissible: false,
              context: context,
              child: CallbackRequestSheet(),
            );
          },
          failure: (err) {
            showErrorDialog(err, context, ref);
          },
          orElse: () {},
        );
      },
    );

    //final asyncState = ref.watch(fieldCallbackNotifierProvider);
    return Scaffold(
      backgroundColor: DefaultColors.white,
      body: AuthHeaderWrapper(
        withScroll: false,
        headerText: DefaultString.instance.requestCallback,
        child: RxView<FetchCallbackFieldsState, List<CallbackFields>>(
          stateProvider: fetchCallbackFieldsNotifierProvider,
          map: (FetchCallbackFieldsState state) {
            return state.when(
              initial: () {
                return AsyncValue.data([]);
              },
              loading: () {
                return AsyncValue.loading();
              },
              success: (value) {
                return AsyncValue.data(value);
              },

              failure: (error) {
                return AsyncValue.error(error, StackTrace.current);
              },
            );
          },
          data: (BuildContext context, List<CallbackFields> data) {
            for (var field in data) {
              if (!fieldControllers.containsKey(field.fieldKey)) {
                final controller = TextEditingController();
                controller.addListener(() => setState(() {}));
                fieldControllers[field.fieldKey] = controller;
              }
            }
            final isFormReady = data.every((f) {
              final controller = fieldControllers[f.fieldKey]!;
              final val = controller.text;

              if (f.fieldOption.toLowerCase() == "mandatory" && val.isEmpty) {
                return false;
              }
              if (f.fieldType.toLowerCase() == "email" && val.isNotEmpty) {
                final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                if (!emailRegex.hasMatch(val)) return false;
              }
              if (f.fieldValidations != null && val.isNotEmpty) {
                final regex = RegExp(f.fieldValidations!);
                if (!regex.hasMatch(val)) return false;
              }

              return true;
            });

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Form(
                key: abFormKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: UiTextNew.customRubik(
                        DefaultString.instance.bookAnAppointment,
                        fontSize: 14,
                        maxLines: 2,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: data.map((field) {
                          final controller = fieldControllers[field.fieldKey]!;

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: buildDynamicField(
                              field: field,
                              controller: controller,
                              validate: validate,
                              context: context,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    CustomButtonNewWidget(
                      onPress: () async {
                        if (!abFormKey.currentState!.validate()) return;
                        if (isFormReady) {
                          final requestCallbackBody = <String, dynamic>{};
                          fieldControllers.forEach((key, controller) {
                            if (controller.text.isNotEmpty) {
                              requestCallbackBody[key] = controller.text;
                            }
                          });

                          // ✅ Simply trigger notifier - no result handling here
                          ref
                              .read(
                                fetchCallBackRequestNotifierProvider.notifier,
                              )
                              .fetchCallBackRequest(
                                request: FetchCallBackRequestRequest().copyWith(
                                  dynamicFields: requestCallbackBody,
                                ),
                              );
                        }
                      },
                      title: DefaultString.instance.nextTitle,
                      buttonColor: isFormReady
                          ? DefaultColors.blueBase
                          : DefaultColors.grayMedBase,
                    ),

                    // CustomButtonNewWidget(
                    //   onPress: () async {
                    //     if (!abFormKey.currentState!.validate()) return;
                    //     if (isFormReady) {
                    //       final requestCallbackBody = <String, dynamic>{};
                    //       fieldControllers.forEach((key, controller) {
                    //         if (controller.text.isNotEmpty) {
                    //           requestCallbackBody[key] = controller.text;
                    //         }
                    //       });
                    //       final notifier = ref.read(
                    //         requestCallbackNotifierProvider.notifier,
                    //       );
                    //       final result = await AsyncValue.guard(
                    //         () => notifier.fetchCallBackRequest(
                    //           requestCallbackBody: requestCallbackBody,
                    //         ),
                    //       );
                    //
                    //       if (!mounted) return;
                    //       result.when(
                    //         data: (_) {
                    //           CustomSheet.show(
                    //             isDismissible: false,
                    //             context: context,
                    //             child: CallbackRequestSheet(),
                    //           );
                    //         },
                    //         error: (err, _) {
                    //           UiToast().showFlagMsg(
                    //             context: context,
                    //             msg: "$err",
                    //             level: ToastLevel.error,
                    //           );
                    //         },
                    //         loading: () {},
                    //       );
                    //     }
                    //   },
                    //   title: DefaultString.instance.nextTitle,
                    //   buttonColor: isFormReady
                    //       ? DefaultColors.blueBase
                    //       : DefaultColors.grayMedBase,
                    // ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            );
          },
          error: (context, error, stack) => ErrorCommonWidget(
            error: error.toString(),
            onPressed: () {
              ref
                  .read(fetchCallbackFieldsNotifierProvider.notifier)
                  .fetchCallbackFields(request: FetchCallbackFieldsRequest());
            },
          ),
        ),
      ),
    );
  }

  Widget buildDynamicField({
    required CallbackFields field,
    required TextEditingController controller,
    required FormValidator validate,
    required BuildContext context,
  }) {
    final isMandatory = field.fieldOption.toLowerCase() == "mandatory";

    // Dropdown field
    if (field.fieldType.toLowerCase() == "combo" && field.fieldList != null) {
      return StatefulBuilder(
        builder: (context, setLocalState) {
          return UiTextField(
            isReadOnly: true,
            controller: controller,
            label: field.fieldName + (isMandatory ? " *" : ""),
            onTap: () {
              setLocalState(() => isDropdownOpen = true);
              CustomSheet.show(
                context: context,
                child: FieldSheetWidget(
                  titleSheet: field.fieldName,
                  controllerText: controller.text,
                  options: field.fieldList!,
                  itemSelected: (val) {
                    controller.text = val;
                    setLocalState(() => isDropdownOpen = false);
                  },
                ),
              ).then((_) => setLocalState(() => isDropdownOpen = false));
            },
            suffix: Icon(
              isDropdownOpen
                  ? Icons.keyboard_arrow_up_outlined
                  : Icons.keyboard_arrow_down_outlined,
              color: Colors.black,
            ),
            validator: (val) {
              if (isMandatory && (val == null || val.isEmpty)) {
                return "${field.fieldName} is required";
              }
              return null;
            },
          );
        },
      );
    }

    // Text field
    return UiTextField(
      controller: controller,
      label: field.fieldName + (isMandatory ? " *" : ""),
      maxLength: int.tryParse(field.fieldLength) ?? null,
      obscureText: false,
      keyboardType: field.fieldType.toLowerCase() == "email"
          ? TextInputType.emailAddress
          : TextInputType.text,
      inputFormatters: field.fieldType == "alphaNumeric"
          ? []
          : [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]'))],
      validator: (val) {
        try {
          if (isMandatory && (val == null || val.isEmpty)) {
            return "${field.fieldName} is required";
          }
          // if (field.fieldType.toLowerCase() == "email" && val!.isNotEmpty) {
          //   final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
          //   if (!emailRegex.hasMatch(val)) return "Invalid ${field.fieldName}";
          // }
          if (field.fieldValidations != null && val!.isNotEmpty) {
            //final regex = RegExp(field.fieldValidations!);
            final rawPattern = field.fieldValidations!;
            final cleanedPattern =
                rawPattern // todo these check validation with backendteam
                    .replaceAll(
                      '\\\\\\\\',
                      '\\\\',
                    ) // handles cases with 4 slashes from JSON escaping
                    .replaceAll(
                      '\\\\.',
                      '\\.',
                    ); // converts escaped dot to real regex dot

            final regex = RegExp(cleanedPattern);
            if (!regex.hasMatch(val)) return "Invalid ${field.fieldName}";
          }
          return null;
        } catch (e) {}
      },
    );
  }
}

// class _RequestCallbackPageState extends ConsumerState<RequestCallbackPage> {
//   late TextEditingController nameController;
//   late TextEditingController mobileNumberController;
//   late TextEditingController emailController;
//   late TextEditingController reasonController;
//   bool isReasonDropdownOpen = false;
//   bool isDropdownOpen = false;
//
//   GlobalKey<FormState> abFormKey = GlobalKey<FormState>();
//
//   @override
//   void initState() {
//     super.initState();
//     nameController = TextEditingController();
//     mobileNumberController = TextEditingController();
//     emailController = TextEditingController();
//     reasonController = TextEditingController();
//     nameController.addListener(() => setState(() {}));
//     mobileNumberController.addListener(() => setState(() {}));
//     emailController.addListener(() => setState(() {}));
//     reasonController.addListener(() => setState(() {}));
//   }
//
//   @override
//   void dispose() {
//     nameController.dispose();
//     mobileNumberController.dispose();
//     emailController.dispose();
//     reasonController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final validate = ref.watch(formValidatorNotifierProvider);
//     final asyncState = ref.watch(fieldCallbackNotifierProvider);
//
//     final isRequiredFilled =
//         nameController.text.isNotEmpty &&
//         mobileNumberController.text.isNotEmpty &&
//         reasonController.text.isNotEmpty;
//
//     // validate email if not empty
//     final isEmailValid =
//         emailController.text.isEmpty ||
//         (abFormKey.currentState?.validate() ?? false);
//
//     final isFormReady = isRequiredFilled && isEmailValid;
//
//     return Scaffold(
//       backgroundColor: DefaultColors.white,
//       // appBar: UIAppBar.secondary(
//       //   autoLeadingWidget: LeadingWidget(
//       //     title: DefaultString.instance.requestCallback,
//       //   ),
//       //   title: '',
//       // ),
//       body: AuthHeaderWrapper(
//         withScroll: false,
//         headerText: DefaultString.instance.requestCallback,
//         child: asyncState.when(
//           loading: () => const LoadingWidget(),
//           error: (err, _) => const EmptyWidget(),
//           data: (fieldRequest) {
//             final FieldCallbackEntity fieldCallbackEntity = fieldRequest;
//             return Padding(
//               padding: const EdgeInsets.symmetric(vertical: 16),
//               child: Form(
//                 key: abFormKey,
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16),
//                       child: UiTextNew.customRubik(
//                         DefaultString.instance.bookAnAppointment,
//                         fontSize: 14,
//                         maxLines: 2,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     // SizedBox(height: 32),
//                     Expanded(
//                       child: ListView(
//                         padding: EdgeInsets.zero,
//                         children: fieldCallbackEntity.data.map((field) {
//                           final controller = TextEditingController();
//                           return Padding(
//                             padding: const EdgeInsets.symmetric(vertical: 5),
//                             child: buildDynamicField(
//                               field: field,
//                               controller: controller,
//                               validate: validate,
//                               context: context,
//                             ),
//                           );
//                         }).toList(),
//                       ),
//
//                       // ListView(
//                       //   padding: EdgeInsets.zero,
//                       //   children: [
//                       //     Padding(
//                       //       padding: const EdgeInsets.symmetric(horizontal: 16),
//                       //       child: UiTextNew.customRubik(
//                       //         DefaultString.instance.bookAnAppointment,
//                       //         fontSize: 14,
//                       //         maxLines: 2,
//                       //         fontWeight: FontWeight.w600,
//                       //       ),
//                       //     ),
//                       //     SizedBox(height: 32),
//                       //
//                       //     UiTextField(
//                       //       //  maxLength: 8,
//                       //       padding: EdgeInsets.symmetric(horizontal: 16),
//                       //       obscureText: false,
//                       //       controller: nameController,
//                       //       label: DefaultString.instance.fullName,
//                       //       validator: (val) {
//                       //         if (val != null && val.isNotEmpty) {
//                       //           return validate.fullNameValidation(val);
//                       //         }
//                       //       },
//                       //     ),
//                       //     SizedBox(height: 12),
//                       //     UiTextField(
//                       //       maxLength: 8,
//                       //       keyboardType: TextInputType.number,
//                       //       controller: mobileNumberController,
//                       //       label: DefaultString.instance.mobileNum,
//                       //       prefix: UiTextNew.customRubik(
//                       //         "+974",
//                       //         fontSize: 15,
//                       //         fontWeight: FontWeight.w500,
//                       //       ),
//                       //       obscureText: false,
//                       //
//                       //       // ✅ Allow paste/copy but restrict to digits only
//                       //       inputFormatters: [
//                       //         FilteringTextInputFormatter.digitsOnly,
//                       //       ],
//                       //
//                       //       validator: (val) {
//                       //         if (val != null && val.isNotEmpty) {
//                       //           return validate.qatarMobileNumberValidation(
//                       //             val,
//                       //           );
//                       //         }
//                       //         return null;
//                       //       },
//                       //     ),
//                       //
//                       //     const SizedBox(height: 12),
//                       //     UiTextField(
//                       //       maxLength: 30,
//                       //       controller: emailController,
//                       //       label: DefaultString.instance.emailOptional,
//                       //       obscureText: false,
//                       //       validator: (val) {
//                       //         // only validate if not empty
//                       //         if (val != null && val.isNotEmpty) {
//                       //           return validate.emailValidation(val);
//                       //         }
//                       //         return null;
//                       //       },
//                       //     ),
//                       //     const SizedBox(height: 12),
//                       //     UiTextField(
//                       //       onTap: () {
//                       //         setState(() => isReasonDropdownOpen = true);
//                       //         CustomSheet.show(
//                       //           context: context,
//                       //           child: ReasonSheetWidget(
//                       //             currentReason: reasonController.text,
//                       //             reasonSelected: (val) {
//                       //               if (val != null) {
//                       //                 reasonController.text = val;
//                       //                 print(reasonController.text);
//                       //                 setState(() {
//                       //                   isReasonDropdownOpen = false;
//                       //                 });
//                       //               }
//                       //             },
//                       //           ),
//                       //         ).then((_) {
//                       //           setState(() => isReasonDropdownOpen = false);
//                       //         });
//                       //       },
//                       //       isReadOnly: true,
//                       //       controller: reasonController,
//                       //       label: DefaultString.instance.reason,
//                       //       suffix: Icon(
//                       //         isReasonDropdownOpen
//                       //             ? Icons.keyboard_arrow_up_outlined
//                       //             : Icons.keyboard_arrow_down_outlined,
//                       //         color: Colors.black,
//                       //       ),
//                       //     ),
//                       //   ],
//                       // ),
//                     ),
//                     // NextButtonWidget(
//                     //   isFormReady: isFormReady,
//                     //   abFormKey: abFormKey,
//                     // ),
//                     CustomButtonNewWidget(
//                       onPress: () {
//                         if (isFormReady) {
//                           // Run a full validation pass
//                           if (abFormKey.currentState?.validate() ?? false) {
//                             CustomSheet.show(
//                               context: context,
//                               child: CallbackRequestSheet(),
//                             );
//                           }
//                         }
//                       },
//                       title: DefaultString.instance.nextTitle,
//                       buttonColor: isFormReady
//                           ? DefaultColors.blueBase
//                           : DefaultColors.grayMedBase,
//                       ////////////////////////////
//                     ),
//                     const SizedBox(height: 16),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget buildDynamicField({
//     required FieldData field,
//     required TextEditingController controller,
//     required FormValidator validate,
//     required BuildContext context,
//   }) {
//     final isMandatory = field.fieldOption.toLowerCase() == "mandatory";
//
//     // TYPE: COMBO -> Show UiTextField that opens bottom sheet
//     if (field.fieldType.toLowerCase() == "combo" && field.fieldList != null) {
//       return StatefulBuilder(
//         builder: (context, setLocalState) {
//           return UiTextField(
//             isReadOnly: true,
//             controller: controller,
//             label: field.fieldName + (isMandatory ? " *" : ""),
//             onTap: () {
//               setLocalState(() => isDropdownOpen = true);
//
//               CustomSheet.show(
//                 context: context,
//                 child: FieldSheetWidget(
//                   titleSheet: field.fieldName,
//                   controllerText: controller.text,
//                   options: field.fieldList!,
//                   itemSelected: (val) {
//                     controller.text = val;
//                     print("Selected: ${controller.text}");
//                     setLocalState(() {}); // ✅ update field instantly
//                   },
//                 ),
//               ).then((_) {
//                 setLocalState(() => isDropdownOpen = false);
//               });
//             },
//             suffix: Icon(
//               isDropdownOpen
//                   ? Icons.keyboard_arrow_up_outlined
//                   : Icons.keyboard_arrow_down_outlined,
//               color: Colors.black,
//             ),
//           );
//         },
//       );
//     }
//
//     // TYPE: TEXT FIELD
//     return UiTextField(
//       controller: controller,
//       label: field.fieldName + (isMandatory ? " *" : ""),
//       maxLength: int.tryParse(field.fieldLength) ?? null,
//       obscureText: false,
//       keyboardType: field.fieldType == "alphaNumeric"
//           ? TextInputType.text
//           : TextInputType.name,
//       inputFormatters: field.fieldType == "alphaNumeric"
//           ? []
//           : [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]'))],
//       validator: (val) {
//         if (isMandatory && (val == null || val.isEmpty)) {
//           return "${field.fieldName} is required";
//         }
//         if (field.fieldValidations != null && val!.isNotEmpty) {
//           final regex = RegExp(field.fieldValidations!);
//           if (!regex.hasMatch(val)) {
//             return "Invalid ${field.fieldName}";
//           }
//         }
//         return null;
//       },
//     );
//   }
// }

// class NextButtonWidget extends ConsumerStatefulWidget {
//   final bool isFormReady;
//   final abFormKey;
//   const NextButtonWidget({
//     super.key,
//     required this.isFormReady,
//     this.abFormKey,
//   });
//
//   @override
//   ConsumerState<NextButtonWidget> createState() => _NextButtonWidgetState();
// }
//
// class _NextButtonWidgetState extends ConsumerState<NextButtonWidget>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(vsync: this);
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   bool _isSubmitting = false;
//
//   @override
//   Widget build(BuildContext context) {
//     final requestCallbackState = ref.watch(requestCallbackNotifierProvider);
//     final isLoading = requestCallbackState is AsyncLoading || _isSubmitting;
//     return isLoading
//         ? Expanded(child: LoadingButton())
//         : CustomButtonNewWidget(
//             onPress: () async {
//               if (widget.isFormReady) {
//                 // Run a full validation pass
//                 if (widget.abFormKey.currentState?.validate() ?? false) {
//                   setState(() {
//                     _isSubmitting = true;
//                   });
//
//                   final notifier = ref.read(
//                     requestCallbackNotifierProvider.notifier,
//                   );
//
//                   final result = await AsyncValue.guard(
//                     () => notifier.fetchCallBackRequest(  requestCallbackBody: ),
//                   );
//
//                   if (!mounted) return;
//
//                   result.when(
//                     data: (_) {
//                       final entity = ref
//                           .read(requestCallbackNotifierProvider)
//                           .value;
//                       if (entity!.data != null) {
//                         CustomSheet.show(
//                           context: context,
//                           child: CallbackRequestSheet(),
//                         );
//                       }
//                     },
//                     error: (err, _) {
//                       UiToast().showFlagMsg(
//                         context: context,
//                         msg: "$err",
//                         level: ToastLevel.error,
//                       );
//                     },
//                     loading: () {}, // already handled
//                   );
//
//                   if (mounted) {
//                     setState(() {
//                       _isSubmitting = false;
//                     });
//                   }
//                 }
//               }
//             },
//             title: DefaultString.instance.nextTitle,
//             buttonColor: widget.isFormReady
//                 ? DefaultColors.blueBase
//                 : DefaultColors.grayMedBase,
//             ////////////////////////////
//           );
//   }
// }
//
// class QatarPhonePrefixFormatter extends TextInputFormatter {
//   final String prefix = '+974-';
//
//   @override
//   TextEditingValue formatEditUpdate(
//     TextEditingValue oldValue,
//     TextEditingValue newValue,
//   ) {
//     String text = newValue.text;
//
//     // If the user deletes the prefix, re-add it
//     if (!text.startsWith(prefix)) {
//       text = prefix + text.replaceAll(prefix, '');
//     }
//
//     // Remove any non-digit characters after the prefix
//     String afterPrefix = text
//         .substring(prefix.length)
//         .replaceAll(RegExp(r'[^0-9]'), '');
//     text = prefix + afterPrefix;
//
//     return TextEditingValue(
//       text: text,
//       selection: TextSelection.collapsed(offset: text.length),
//     );
//   }
// }
