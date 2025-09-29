// import 'dart:io';
// import 'package:auto_route/annotations.dart';

// import 'package:auto_route/auto_route.dart';
// import 'package:country_list/country_list.dart';
// import 'package:db_uicomponents/components.dart';
// import 'package:db_uicomponents/utils.dart';
// import 'package:dkb_retail/common/utils.dart';
// import 'package:dkb_retail/core/router/app_router.dart';
// import 'package:dkb_retail/core/utils/extensions/locale_extension.dart';
// import 'package:dkb_retail/features/onboarding/presentation/provider/onboarding_provider.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_svg/svg.dart';

// import '../../../../../core/constants/asset_path/asset_path.dart';
// import '../../../../../core/constants/colors.dart';
// import '../../../../common/components/auto_leading_widget.dart';
// import 'package:db_uicomponents/src/components/retail/ui_header_subheader_retail.dart';
// import 'package:db_uicomponents/src/components/retail/ui_label_dropdown_retail.dart';
// import 'package:db_uicomponents/src/components/retail/ui_button_retail.dart';

// import '../../../../common/dialog/ui_dialogs.dart';
// import '../../controller/notifier/onboarding_save_stage_data_notifier.dart';
// import '../../widget/build_info_message.dart';
// import '../../widget/build_upload_field.dart';

// @RoutePage()
// class OnboardingPassportInfoPage extends ConsumerStatefulWidget {
//   const OnboardingPassportInfoPage({super.key});
//   @override
//   ConsumerState<OnboardingPassportInfoPage> createState() =>
//       _OnboardingPassportInfoPageState();
// }

// class _OnboardingPassportInfoPageState
//     extends ConsumerState<OnboardingPassportInfoPage> {
//   TextEditingController uploadControllerPassport = TextEditingController();
//   List<File> _uploadedFiles = [];
//   DateTime? _startDate;
//   DateTime? _endDate;
//   List<Country> countries = [];
//   List<Country> filteredCountries = [];
//   String searchQuery = "";
//   final TextEditingController _searchController = TextEditingController();
//   TextEditingController countryController = TextEditingController();
//   TextEditingController passportController = TextEditingController();

//   //
//   @override
//   void initState() {
//     super.initState();
//     loadCountries();
//   }

//   void loadCountries() {
//     countries = Countries.list;

//     //     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     final currentStage = getStageById(ref, "IDENTIFICATION_PASSPORT");

//     return Scaffold(
//       appBar: const UIAppBar.secondary(
//         autoLeadingWidget: AutoLeadingWidget(),
//         title: "Identification",
//         appBarColor: DefaultColors.white,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           children: [
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const UiHeaderSubHeaderRetail(
//                       title: "Passport Information",
//                       description:
//                           "Validate and complete the missing information below.",
//                     ),
//                     const SizedBox(height: 20),
//                     _setFormInputField("Passport Number", "Passport Number"),
//                     const SizedBox(height: 20),
//                     _buildCountryListUi(context),

//                     // const UiLabelDropdownRetail(
//                     //   label: "Nationality",
//                     //   options: ["1","2"],
//                     //   selectedValue: "1",
//                     // ),
//                     const SizedBox(height: 20),
//                     DatePickerContainer(
//                       // yearCount: 3,
//                       labelUiText: UiTextNew.h4Regular(
//                         ref.getLocaleString(
//                           "Passport Issue Date",
//                           defaultValue: "Passport Issue Date",
//                         ),
//                         color: DefaultColors.white_800,
//                       ),
//                       hintText: "Please Select",
//                       borderColor: DefaultColors.grayE6,
//                       selectedDate: _startDate,
//                       suffixIcon: UISvgIcon(assetPath: AssetPath.icon.calendar),
//                       onDateSelected: (date) {
//                         setState(() {
//                           _startDate = date;
//                           _endDate = null;
//                         });
//                         if (date == null) {
//                           setState(() {
//                             _startDate = null;
//                             _endDate = null;
//                           });
//                         }

//                         if (_endDate != null) {}
//                       },
//                     ),
//                     const SizedBox(height: 20),
//                     DatePickerContainer(
//                       // yearCount: 3,
//                       labelUiText: UiTextNew.h4Regular(
//                         ref.getLocaleString(
//                           "Passport Passport Expiration Date",
//                           defaultValue: "Passport Passport Expiration Date",
//                         ),
//                         color: DefaultColors.white_800,
//                       ),
//                       borderColor: DefaultColors.grayE6,
//                       isEndDate: true,
//                       selectedDate: _endDate,
//                       hintText: "Please Select",
//                       initialDate: _startDate,
//                       showPicker: _startDate != null,
//                       suffixIcon: UISvgIcon(assetPath: AssetPath.icon.calendar),
//                       onDateSelected: (date) {
//                         setState(() {
//                           _endDate = date;
//                         });
//                         if (date == null) {}
//                         if (date != null) {
//                         } else {}
//                       },
//                     ),

//                     const SizedBox(height: 20),
//                     _buildUploadFile(),
//                     // buildFormInputFieldForUpload(
//                     //     uploadControllerPassport,
//                     //     "Upload or take photos of your passport",
//                     //     "Upload File", ()async{
//                     //       ref.read(isFromPassportPageProvider.notifier).state = true;
//                     //   final uploadedFilePaths = await context.router.push(OnboardingIdentifyDocumentRoute()) as List<File>?;
//                     //       ref.read(isFromPassportPageProvider.notifier).state = false;
//                     //
//                     //       if (uploadedFilePaths != null && uploadedFilePaths.isNotEmpty) {
//                     //     setState(() {
//                     //       _uploadedFiles = uploadedFilePaths;
//                     //       uploadControllerPassport.text = _uploadedFiles
//                     //           .map((file) => file.path.split('/').last)
//                     //           .join(', '); // Show file names
//                     //     });
//                     //   }
//                     // }
//                     // ),
//                     // if (_uploadedFiles.isNotEmpty) _buildUploadedImagesPreview(),
//                   ],
//                 ),
//               ),
//             ),
//             // const Spacer(),
//             SizedBox(
//               width: double.infinity,
//               child: UIButton.rounded(
//                 label: 'CONTINUE',
//                 isDisabled:
//                     passportController.text.isEmpty ||
//                     countryController.text.isEmpty ||
//                     _startDate == null ||
//                     _endDate == null ||
//                     _uploadedFiles.isEmpty,
//                 onPressed: () async {
//                   bool value = await ref
//                       .read(onboardingSaveStageDataNotifierProvider.notifier)
//                       .fetch(
//                         custJourneyId: ref.watch(customerJourneyId),
//                         stageId: "${currentStage?.stageId}",
//                         data: {
//                           "Passport_Number": passportController.text,
//                           "Issue_Country": countryController.text,
//                           "Issue_date": _startDate,
//                           "Expiration_date": _endDate,
//                           "uploaded_files": _uploadedFiles,
//                         },
//                       );

//                   if (value == true) {
//                     context.router.push(OnboardingFinancialInfoRoute());
//                   } else {
//                     UiDialogs.showErrorDialog(
//                       context: context,
//                       description: "Data Not Saved",
//                       bknOkPressed: () {
//                         context.router.maybePop();
//                       },
//                     );
//                   }
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildUploadFile() {
//     return UIFormTextField.outlined(
//       hintText: "Upload File",
//       readOnly: true,
//       borderColor: DefaultColors.grayE6,
//       labelUiText: const UiTextNew.h4Regular(
//         "Upload or take photos of your passport",
//         color: DefaultColors.white_800,
//       ),
//       controller: uploadControllerPassport,
//       labelHintTextStyle: const TextStyle(
//         fontWeight: FontWeight.w500,
//         fontSize: 14,
//         fontFamily: 'Rubik',
//         color: DefaultColors.grayB3,
//       ),
//       prefixIcon: Padding(
//         padding: const EdgeInsets.all(10),
//         child: GestureDetector(
//           child: SvgPicture.asset(
//             AssetPath.icon.onboardingAttachFileIcon,
//             width: 24,
//             height: 24,
//             fit: BoxFit.contain,
//           ),
//           onTap: () async {
//             ref.read(isFromPassportPageProvider.notifier).state = true;
//             final uploadedFilePaths =
//                 await context.router.push(OnboardingIdentifyDocumentRoute())
//                     as List<File>?;
//             ref.read(isFromPassportPageProvider.notifier).state = false;

//             if (uploadedFilePaths != null && uploadedFilePaths.isNotEmpty) {
//               setState(() {
//                 _uploadedFiles = uploadedFilePaths;
//                 uploadControllerPassport.text = _uploadedFiles
//                     .map((file) => file.path.split('/').last)
//                     .join(', '); // Show file names
//               });
//             } else {
//               setState(() {
//                 uploadControllerPassport.text = "";
//                 _uploadedFiles = [];
//               });
//             }
//           },
//         ),
//       ),
//       labelTextStyle: const TextStyle(
//         fontSize: 14,
//         fontFamily: 'Rubik',
//         fontWeight: FontWeight.w500,
//         color: DefaultColors.white_800,
//       ),
//       validator: (value) {
//         if (uploadControllerPassport.text.isEmpty) {
//           return "This field is required";
//         }
//         return null;
//       },
//     );
//   }

//   Widget _buildCountryListUi(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const UiTextNew.h4Regular(
//           'Passport Issue Country',
//           color: DefaultColors.white_800,
//         ),
//         const SizedBox(height: 8),
//         // if(countries.length > 5)
//         UIFormTextField.outlined(
//           contentPadding: const EdgeInsets.symmetric(
//             vertical: 0,
//             horizontal: 15,
//           ),
//           hintText: "Please Select",
//           labelHintTextStyle: const TextStyle(
//             fontWeight: FontWeight.w500,
//             fontSize: 14,
//             fontFamily: 'Rubik',
//             color: DefaultColors.grayB3,
//           ),

//           borderColor: DefaultColors.grayE6,
//           controller: countryController,
//           suffixIcon: IconButton(
//             onPressed: () {
//               _showCountryBottomSheet(context);
//             },
//             icon: const Icon(
//               Icons.keyboard_arrow_down,
//               color: DefaultColors.blue9D,
//               size: 28,
//             ),
//           ),
//           labelTextStyle: const TextStyle(
//             fontSize: 14,
//             fontFamily: 'Rubik',
//             fontWeight: FontWeight.w500,
//             color: DefaultColors.white_800,
//           ),
//           validator: (value) {
//             if (value == null || value.isEmpty || value == "Please Select") {
//               return "This field is required";
//             }
//             return null;
//           },
//         ),

//         // if (isCountryEmpty == true) // Show error message if exists
//         //   Padding(
//         //     padding: const EdgeInsets.only(top: 5.0),
//         //     child: Text(
//         //       'This field is empty',
//         //       style: TextStyle(
//         //         color: Colors.red,
//         //         fontSize: 12,
//         //       ),
//         //     ),
//         //   ),
//       ],
//     );
//   }
//   // void _showCountryBottomSheet(BuildContext context) {
//   //   showModalBottomSheet(
//   //     context: context,
//   //     isScrollControlled: true,
//   //     builder: (BuildContext context) {
//   //       return UiBottomSheet.customSheet(
//   //         showBottomButton: false,
//   //         context: context,
//   //         title: "Country of Birth",
//   //         child: _buildCountryList(),
//   //       );
//   //     },
//   //   );
//   // }

//   void _showCountryBottomSheet(BuildContext context) {
//     return UiBottomSheet.customSheet(
//       showBottomButton: false,
//       context: context,
//       title: "Country of Birth",
//       child: _buildCountryList(),
//     );
//   }

//   Widget _buildCountryList() {
//     String searchQuery = _searchController.text.toLowerCase();

//     if (searchQuery.isEmpty) {
//       filteredCountries = countries;
//     } else {
//       String normalize(String value) {
//         return value
//             .replaceAll(',', '')
//             .replaceAll(' ', ' ')
//             .replaceAll("-", "")
//             .replaceAll(".", "")
//             .toLowerCase();
//       }

//       final normalizedQuery = normalize(searchQuery);
//       setState(() {
//         filteredCountries = countries.where((data) {
//           final name = normalize(data.name ?? '');
//           return name.contains(normalizedQuery);
//         }).toList();
//       });
//     }
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
//       child: Column(
//         children: [
//           UiSearch(
//             hintText: "Search",
//             controller: _searchController,
//             onChanged: (query) {
//               setState(() {});
//             },
//           ),
//           const SizedBox(height: 15),
//           Expanded(
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 5.0),
//                     child: GestureDetector(
//                       child: Container(
//                         width: double.infinity,
//                         padding: const EdgeInsets.all(12),
//                         decoration: BoxDecoration(
//                           color: DefaultColors.grayE6.withOpacity(0.5),
//                           //Color(0xFFECE6F0)
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: const UiTextNew.customRubik(
//                           'Please Select',
//                           fontSize: 16,
//                           color: DefaultColors.black,
//                         ),
//                       ),
//                       onTap: () {
//                         Navigator.pop(context);
//                         setState(() {
//                           // isCountryEmpty = true;
//                           countryController.text = '';
//                         });
//                       },
//                     ), // Render each transaction tile
//                   ),

//                   // SizedBox(height: 15,),
//                   ValueListenableBuilder(
//                     valueListenable: _searchController,
//                     builder: (context, TextEditingValue queryValue, _) {
//                       final searchQuery = queryValue.text.toLowerCase();
//                       final filteredCountries = Countries.list.where((country) {
//                         final name = country.name.toLowerCase();
//                         return name.contains(searchQuery);
//                       }).toList();
//                       return ListView.builder(
//                         shrinkWrap: true,
//                         itemCount: filteredCountries.length,
//                         physics: const NeverScrollableScrollPhysics(),
//                         itemBuilder: (context, index) {
//                           Country country = filteredCountries[index];
//                           return Padding(
//                             padding: const EdgeInsets.symmetric(vertical: 5.0),
//                             child: GestureDetector(
//                               child: Container(
//                                 padding: const EdgeInsets.all(12),
//                                 decoration: BoxDecoration(
//                                   color: DefaultColors.grayE6.withOpacity(0.5),
//                                   //Color(0xFFECE6F0)
//                                   borderRadius: BorderRadius.circular(8),
//                                 ),
//                                 child: UiTextNew.customRubik(
//                                   country.name,
//                                   fontSize: 16,
//                                   color: DefaultColors.black,
//                                 ),
//                               ),
//                               onTap: () {
//                                 Navigator.pop(context);
//                                 setState(() {
//                                   // isCountryEmpty = false;
//                                   countryController.text =
//                                       country.name == 'Please Select'
//                                       ? ''
//                                       : country.name;
//                                 });
//                               },
//                             ), // Render each transaction tile
//                           );
//                         },
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _setFormInputField(String label, String hintText) {
//     return UIFormTextField.outlined(
//       hintText: hintText,
//       borderColor: DefaultColors.grayE6,
//       labelHintTextStyle: const TextStyle(
//         fontWeight: FontWeight.w500,
//         fontSize: 14,
//         fontFamily: 'Rubik',
//         color: DefaultColors.grayB3,
//       ),
//       height: 30,
//       labelUiText: UiTextNew.h4Regular(label, color: DefaultColors.white_800),
//       maxLength: 15,
//       labelTextStyle: const TextStyle(
//         fontSize: 14,
//         fontFamily: 'Rubik',
//         fontWeight: FontWeight.w500,
//         color: DefaultColors.white_800,
//       ),
//       onChanged: (value) {
//         setState(() {
//           passportController.text = value;
//         });
//       },
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return "This field is required";
//         }
//         return null;
//       },
//     );
//   }

//   Widget _buildUploadedImagesPreview() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           "Uploaded Images:",
//           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 10),
//         Wrap(
//           spacing: 10,
//           runSpacing: 10,
//           children: _uploadedFiles.map((file) {
//             return Image.file(file, width: 100, height: 100, fit: BoxFit.cover);
//           }).toList(),
//         ),
//       ],
//     );
//   }
// }
