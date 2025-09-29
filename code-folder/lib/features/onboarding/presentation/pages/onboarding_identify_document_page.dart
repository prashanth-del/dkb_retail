// import 'dart:convert';
// import 'dart:io';

// import 'package:auto_route/auto_route.dart';
// import 'package:db_uicomponents/components.dart';
// import 'package:db_uicomponents/src/components/retail/ui_button_retail.dart';
// import 'package:flutter/material.dart';
// import 'package:dkb_retail/core/router/app_router.dart';
// import 'package:dkb_retail/core/utils/extensions/locale_extension.dart';
// import 'package:dkb_retail/features/onboarding/data/model/onboarding_stage_sum_model.dart';
// import 'package:dkb_retail/features/onboarding/presentation/controller/notifier/onboarding_file_upload_notifier.dart';
// import 'package:dkb_retail/features/onboarding/presentation/provider/onboarding_provider.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_ml_kit/google_ml_kit.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path/path.dart' as path;

// import '../../../../core/constants/asset_path/asset_path.dart';
// import '../../../../core/constants/colors.dart';
// import '../../../common/dialog/ui_dialogs.dart';
// import '../controller/notifier/onboarding_block_journey_notifier.dart';
// import '../controller/notifier/onboarding_save_stage_data_notifier.dart';

// @RoutePage()
// class OnboardingIdentifyDocumentPage extends ConsumerStatefulWidget {
//   const OnboardingIdentifyDocumentPage({super.key});

//   @override
//   _OnboardingIdentifyDocumentPageState createState() =>
//       _OnboardingIdentifyDocumentPageState();
// }

// class _OnboardingIdentifyDocumentPageState
//     extends ConsumerState<OnboardingIdentifyDocumentPage> {
//   File? _frontImage;
//   File? _backImage;

//   final picker = ImagePicker();
//   String _frontText = "";
//   String _backText = "";

//   final textRecognizer = GoogleMlKit.vision.textRecognizer();
//   int scanAttemptsFrontImage = 0;
//   int scanAttemptsBackImage = 0;

//   bool isFrontCaptured = false;
//   bool isBackCaptured = false;
//   bool isFrontImageUploaded = false;
//   bool isBackImageUploaded = false;
//   XFile? _capturedImage;
//   Map<String, String> extractedData = {};

//   final Map<String, String> dummyResponse = {
//     "Name": "John Doe",
//     "DateOfBirth": "1990-01-01",
//     "QID": "123456789",
//     "IssueDate": "2020-01-01",
//     "ExpiryDate": "2030-01-01",
//   };

//   Future<void> _selectDocument(bool isFront) async {
//     ref.read(isFrontCardImageProvider.notifier).state = isFront
//         ? "Front Side"
//         : "Back side";
//     final selectedImage =
//         await context.router.push(OnboardingDocumentProcessingRoute()) as File?;

//     if (selectedImage != null) {
//       setState(() {
//         // _frontImage = selectedImage;
//         _processImage(selectedImage, isFront);
//         // _backImage = selectedImage;
//       });
//     }
//   }

//   Future<void> _processImage(File imageFile, bool isFront) async {
//     try {
//       final inputImage = InputImage.fromFile(imageFile);
//       final recognizedText = await textRecognizer.processImage(inputImage);

//       // Validate the OCR result
//       if (_validateQID(recognizedText.text)) {
//         setState(() {
//           if (isFront) {
//             isFrontCaptured = true;
//             _frontImage = imageFile;
//             ref.read(isFrontCardImageProvider.notifier).state = "Front Side";
//             // extractedData["Name"] = _extractField(recognizedText, "Name");
//             // extractedData["DateOfBirth"] = _extractField(recognizedText, "D.O.B");
//             // extractedData["QID"] = _extractField(recognizedText, "ID. No:");
//             // extractedData["ExpiryDate"] = _extractField(recognizedText, "Date of expiry:");
//             // extractedData["Nationality"] = _extractField(recognizedText, "Nationality");

//             // ScaffoldMessenger.of(context).showSnackBar(
//             //   SnackBar(content: Text("Front side captured successfully.")),
//             // );
//             scanAttemptsFrontImage++;
//             if (scanAttemptsFrontImage >= 5) {
//               ref
//                   .read(onboardingBlockJourneyNotifierProvider.notifier)
//                   .fetch(
//                     mobileNumber: ref.watch(getMobileNumber),
//                     blockPeriod: "${ref.watch(customerJourneyId)}",
//                     nationalId: ref.watch(getQidNumber),
//                     blockReason: "QID Scan",
//                   );

//               _showError(
//                 "You have exceeded the maximum number of attempts. Please try again after 2 hours.",
//               );
//               // Navigate to pre-login landing screen
//               // Navigator.pop(context);
//             }
//           } else {
//             isBackCaptured = true;
//             _backImage = imageFile;
//             ref.read(isFrontCardImageProvider.notifier).state = "Back Side";
//             // extractedData["QID"] = _extractField(recognizedText, "QID");
//             // // extractedData["IssueDate"] = _extractField(recognizedText, "Issue Date");
//             // extractedData["ExpiryDate"] = _extractField(recognizedText, "Expiry Date");

//             // ScaffoldMessenger.of(context).showSnackBar(
//             //   SnackBar(content: Text("Back side captured successfully.")),
//             // );
//             scanAttemptsBackImage++;
//             if (scanAttemptsBackImage >= 5) {
//               ref
//                   .read(onboardingBlockJourneyNotifierProvider.notifier)
//                   .fetch(
//                     mobileNumber: ref.watch(getMobileNumber),
//                     blockPeriod: "${ref.watch(customerJourneyId)}",
//                     nationalId: ref.watch(getQidNumber),
//                     blockReason: "QID Scan",
//                   );

//               _showError(
//                 "You have exceeded the maximum number of attempts. Please try again after 2 hours.",
//               );
//               // Navigate to pre-login landing screen
//               // Navigator.pop(context);
//             }
//           }
//           // else {
//           //   _showError("Both sides of the QID are already captured.");
//           // }
//         });
//       } else {
//         _showError("Incorrect document. Please scan your QID.");
//       }
//     } catch (e) {
//       _showError("An error occurred while processing the image.");
//     }

//     // Check attempt limit
//   }

//   bool _validateQID(String text) {
//     // if (text.contains("ID. No:") || text.contains("Date of expiry:")) {
//     //   return true; // Assume valid QID keywords found
//     // }
//     return true; // Invalid document
//   }

//   void _showError(String message) {
//     ScaffoldMessenger.of(
//       context,
//     ).showSnackBar(SnackBar(content: Text(message)));
//   }

//   // Future<void> _extractTextFromImage(File image, bool isFront) async {
//   //   final inputImage = InputImage.fromFile(image);
//   //   final textRecognizer = TextRecognizer();
//   //
//   //   // final textDetector = GoogleMlKit.vision.textRecognizer();
//   //
//   //   try {
//   //     final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
//   //
//   //     // final RecognizedText recognizedText =
//   //     // await textDetector.processImage(inputImage);
//   //     // Extract the text content
//   //     setState(() {
//   //       if (isFront) {
//   //         print("sssssssssssssssss ${recognizedText.text}");
//   //
//   //         _frontText = recognizedText.text;
//   //       } else {
//   //         _backText = recognizedText.text;
//   //       }
//   //     });
//   //   } catch (e) {
//   //     debugPrint("Error reading text from image: $e");
//   //   } finally {
//   //     textRecognizer.close();
//   //   }
//   // }

//   // Future<void> _pickImage(bool isFront) async {
//   //   final pickedFile = await picker.pickImage(source: ImageSource.camera);
//   //   if (pickedFile != null) {
//   //     setState(() {
//   //       if (isFront) {
//   //         _frontImage = File(pickedFile.path);
//   //       } else {
//   //         _backImage = File(pickedFile.path);
//   //       }
//   //     });
//   //   }
//   // }

//   void _submit(StageData currentStage) async {
//     if (_frontImage != null && _backImage != null) {
//       // Logic to send images to the backend or process them.

//       debugPrint("Front Text: $_frontText");
//       debugPrint("Back Text: $_backText");
//       // print(extractedData);

//       if (!isFrontImageUploaded) {
//         // isFrontImageUploaded = true;
//         final notifier = ref.read(
//           getOnboardingFileUploadNotifierProvider.notifier,
//         );

//         bool value = await notifier.fetch(
//           imageType: "front",
//           fileExtension: "${getFileExtension(_frontImage!)}",
//           fileSize: "${_frontImage!.lengthSync() ~/ 1024}",
//           nationalId: ref.watch(getQidNumber),
//           mobileNumber: ref.watch(getMobileNumber),
//           fileType: getFileDetails(_frontImage!),
//           fileBase64: base64Encode(_frontImage!.readAsBytesSync()),
//         );
//         if (value == true) {
//           isFrontImageUploaded = true;
//           if (isFrontImageUploaded && isBackImageUploaded) {
//             isFrontImageUploaded = false;
//             isBackImageUploaded = false;

//             bool value = await ref
//                 .read(onboardingSaveStageDataNotifierProvider.notifier)
//                 .fetch(
//                   custJourneyId: ref.watch(customerJourneyId),
//                   stageId: "${currentStage?.stageId}",
//                   data: {"frontImage": _frontImage, "backImage": _backImage},
//                 );

//             if (value == true) {
//               if (ref.read(isFromPassportPageProvider)) {
//                 context.router.maybePop([
//                   File(_frontImage!.path),
//                   File(_backImage!.path),
//                 ]);
//               } else {
//                 context.router.push(OnboardingVerifyIdentificationRoute());
//               }
//             } else {
//               UiDialogs.showErrorDialog(
//                 context: context,
//                 description: "Data Not Saved",
//                 bknOkPressed: () {
//                   context.router.maybePop();
//                 },
//               );
//             }
//           }
//         } else {
//           UiDialogs.showErrorDialog(
//             context: context,
//             description: "Front Side image not uploaded",
//             bknOkPressed: () {
//               _frontImage == null;
//               _backImage == null;
//               isFrontImageUploaded = false;
//               isBackImageUploaded = false;
//               context.router.maybePop();
//             },
//           );
//         }
//       }

//       if (!isBackImageUploaded) {
//         // isBackImageUploaded = true;
//         final notifier = ref.read(
//           getOnboardingFileUploadNotifierProvider.notifier,
//         );

//         bool value = await notifier.fetch(
//           imageType: "back",
//           fileExtension: "${getFileExtension(_backImage!)}",
//           fileSize: "${_backImage!.lengthSync() ~/ 1024}",
//           nationalId: ref.watch(getQidNumber),
//           mobileNumber: ref.watch(getMobileNumber),
//           fileType: getFileDetails(_backImage!),
//           fileBase64: base64Encode(_backImage!.readAsBytesSync()),
//         );
//         if (value == true) {
//           isBackImageUploaded = true;

//           if (isFrontImageUploaded && isBackImageUploaded) {
//             isFrontImageUploaded = false;
//             isBackImageUploaded = false;

//             bool value = await ref
//                 .read(onboardingSaveStageDataNotifierProvider.notifier)
//                 .fetch(
//                   custJourneyId: ref.watch(customerJourneyId),
//                   stageId: "${currentStage?.stageId}",
//                   data: {"frontImage": _frontImage, "backImage": _backImage},
//                 );

//             if (value == true) {
//               if (ref.read(isFromPassportPageProvider)) {
//                 context.router.maybePop([
//                   File(_frontImage!.path),
//                   File(_backImage!.path),
//                 ]);
//               } else {
//                 context.router.push(OnboardingVerifyIdentificationRoute());
//               }
//             } else {
//               UiDialogs.showErrorDialog(
//                 context: context,
//                 description: "Data Not Saved",
//                 bknOkPressed: () {
//                   context.router.maybePop();
//                 },
//               );
//             }
//           }
//         } else {
//           UiDialogs.showErrorDialog(
//             context: context,
//             description: "Back Side image not uploaded",
//             bknOkPressed: () {
//               _frontImage == null;
//               _backImage == null;
//               isFrontImageUploaded = false;
//               isBackImageUploaded = false;
//               context.router.maybePop();
//             },
//           );
//         }
//       }

//       // context.router.push(OnboardingVerifyIdentificationRoute());
//       // ScaffoldMessenger.of(context).showSnackBar(
//       //   SnackBar(content: Text('Images submitted successfully!')),
//       // );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Please scan both front and back sides.')),
//       );
//     }
//   }

//   String getFileExtension(File file) {
//     return path.extension(file.path).toLowerCase();
//   }

//   String getFileDetails(File file) {
//     // Get the file extension
//     String fileExtension = path
//         .extension(file.path)
//         .toLowerCase(); // e.g., ".jpeg"

//     // Determine the file type based on the extension
//     String fileType;
//     if (fileExtension == '.jpg' || fileExtension == '.jpeg') {
//       fileType = 'jpeg';
//     } else if (fileExtension == '.png') {
//       fileType = 'png';
//     } else if (fileExtension == '.pdf') {
//       fileType = 'pdf';
//     } else {
//       fileType = 'unknown';
//     }
//     return fileType;
//     print("File Extension: $fileExtension");
//     print("File Type: $fileType");
//   }

//   String _extractField(RecognizedText recognizedText, String fieldName) {
//     // Search for a specific field in the recognized text
//     for (var block in recognizedText.blocks) {
//       for (var line in block.lines) {
//         if (line.text.contains(fieldName)) {
//           return line.text.replaceAll("$fieldName:", "").trim();
//         }
//       }
//     }
//     return "Not Found";
//   }

//   void _compareData() {
//     dummyResponse.forEach((key, value) {
//       String extractedValue = extractedData[key] ?? "Not Found";
//       if (extractedValue == value) {
//         print("$key matches: $extractedValue");
//       } else {
//         print("$key mismatch: Expected $value, Got $extractedValue");
//       }
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void dispose() {
//     textRecognizer.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final currentStage = getStageById(ref, "QID_SCAN");

//     ref.listen(onboardingBlockJourneyNotifierProvider, (previous, next) {
//       next.maybeWhen(
//         data: (response) {
//           // Handle successful response
//           UiDialogs.showErrorDialog(
//             context: context,
//             description: response.message,
//             bknOkPressed: () {
//               context.router.maybePop();
//               context.router.replace(LoginRoute());
//             },
//           );
//         },
//         error: (error, stackError) => UiDialogs.showErrorDialog(
//           context: context,
//           description: "$error",
//           bknOkPressed: () {
//             context.router.maybePop();
//           },
//         ),
//         loading: () {
//           // Optionally handle loading state
//           Center(
//             child: UiLoader(
//               loadingText: ref.getLocaleString(
//                 "Loading",
//                 defaultValue: "Loading...",
//               ),
//             ),
//           );
//         },
//         orElse: () {},
//       );
//     });

//     ref.listen(getOnboardingFileUploadNotifierProvider, (previous, next) {
//       // Optionally handle updates to the state
//     });

//     // ref.listen(getOnboardingFileUploadNotifierProvider, (previous, next)async {
//     //   final notifier = ref.read(getOnboardingFileUploadNotifierProvider.notifier);
//     //
//     //   if (notifier.isFrontUploaded && notifier.isBackUploaded) {
//     //     bool value = await ref.read(onboardingSaveStageDataNotifierProvider.notifier).fetch(
//     //         custJourneyId: ref.watch(customerJourneyId),
//     //         stageId: "${currentStage?.stageId}",
//     //         data: {
//     //           "frontImage" : _frontImage,
//     //           "backImage" : _backImage
//     //         });
//     //
//     //     if(value == true) {
//     //       if(ref.read(isFromPassportPageProvider)) {
//     //         context.router.maybePop([
//     //           File(_frontImage!.path),
//     //           File(_backImage!.path),
//     //         ]);
//     //       } else {
//     //         context.router.push(OnboardingVerifyIdentificationRoute());
//     //       }
//     //
//     //     } else {
//     //       UiDialogs.showErrorDialog(
//     //         context: context,
//     //         description: "Data Not Saved",
//     //         bknOkPressed: () {
//     //           context.router.maybePop();
//     //         },
//     //       );
//     //     }
//     //
//     //     // context.router.push(OnboardingVerifyIdentificationRoute());
//     //
//     //     // ref.read(isSubmittedRequestProvider.notifier).state = false;
//     //     //
//     //
//     //   }
//     //
//     //   next.maybeWhen(
//     //     data: (response) {
//     //       // Handle successful response
//     //       ref.read(qidDetailsProvider.notifier).state = response.data;
//     //
//     //     },
//     //     error: (error, stackError) {
//     //       debugPrint("Error: $error");
//     //       UiDialogs.showErrorDialog(
//     //         context: context,
//     //         description: "$error",
//     //         bknOkPressed: () {
//     //           _frontImage == null;
//     //           _backImage == null;
//     //           context.router.maybePop();
//     //         },
//     //       );
//     //     },
//     //     loading: () {
//     //       Center(
//     //         child: UiLoader(
//     //           loadingText: ref.getLocaleString("Loading", defaultValue: "Loading..."),
//     //         ),
//     //       );
//     //     },
//     //     orElse: () {},
//     //   );
//     // });

//     // ref.listen(getOnboardingFileUploadNotifierProvider, (previous, next) {
//     //   next.maybeWhen(
//     //     data: (response) {
//     //       // Handle successful response
//     //       // ScaffoldMessenger.of(context).showSnackBar(
//     //       //   const SnackBar(content: Text("Images uploaded successfully!")),
//     //       // );
//     //       final previousState = previous?.asData?.value;
//     //       if (previousState != null && previousState == response) {
//     //         return; // Prevent duplicate handling
//     //       }
//     //
//     //
//     //       context.router.push(OnboardingVerifyIdentificationRoute());
//     //     },
//     //     error:(error, stackError) =>
//     //         UiDialogs.showErrorDialog(
//     //           context: context,
//     //           description: "$error",
//     //           bknOkPressed: () {
//     //             _frontImage == null;
//     //             _backImage == null;
//     //             context.router.maybePop();
//     //           },
//     //         ),
//     //     loading: () {
//     //       // Optionally handle loading state
//     //       Center(
//     //           child: UiLoader(
//     //               loadingText: ref.getLocaleString("Loading",
//     //                   defaultValue: "Loading...")));
//     //     },
//     //     orElse: () {},
//     //   );
//     // });

//     return Scaffold(
//       appBar: AppBar(title: Text('Identify Document')),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const UiTextNew.customRubik(
//               "Identify Document",
//               fontSize: 18,
//               color: DefaultColors.black,
//             ),
//             SizedBox(height: 10),

//             const UiTextNew.h4Regular(
//               "Tap on each cards to scan the documents",
//               color: DefaultColors.white_800,
//             ),
//             SizedBox(height: 20),

//             const UiTextNew.customRubik(
//               "Front Side",
//               fontSize: 14,
//               color: DefaultColors.white_800,
//             ),

//             SizedBox(height: 8),
//             Expanded(
//               child: GestureDetector(
//                 onTap: () => _selectDocument(
//                   true,
//                 ), //context.router.push(OnboardingDocumentProcessingRoute()),
//                 child: Container(
//                   width: double.infinity,
//                   margin: EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: DefaultColors.blue9D),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: _frontImage != null
//                       ? Image.file(_frontImage!, fit: BoxFit.cover)
//                       : Center(
//                           child: SvgPicture.asset(
//                             AssetPath.icon.onboardingFrontImageRetailIcon,
//                             fit: BoxFit.contain,
//                           ),
//                         ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 16),
//             const UiTextNew.customRubik(
//               "Back Side",
//               fontSize: 14,
//               color: DefaultColors.white_800,
//             ),
//             SizedBox(height: 8),
//             Expanded(
//               child: GestureDetector(
//                 onTap: () => _selectDocument(false), //_pickImage(false),
//                 child: Container(
//                   width: double.infinity,
//                   margin: EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: DefaultColors.blue9D),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: _backImage != null
//                       ? Image.file(_backImage!, fit: BoxFit.cover)
//                       : Center(
//                           child: SvgPicture.asset(
//                             AssetPath.icon.onboardingBackImageRetailIcon,
//                             fit: BoxFit.contain,
//                           ),
//                         ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             const UiTextNew.h4Regular(
//               "Make sure the document is readable and avoid any reflection.",
//               color: DefaultColors.white_800,
//             ),
//             const SizedBox(height: 30),
//             ActionButtonWidget(
//               text: 'SUBMIT',
//               onPressed: () {
//                 // _submit();
//                 if (ref.read(isFromPassportPageProvider)) {
//                   if (_frontImage != null && _backImage != null)
//                     context.router.maybePop([
//                       File(_frontImage!.path),
//                       File(_backImage!.path),
//                     ]);
//                 } else {
//                   _submit(currentStage!);
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
