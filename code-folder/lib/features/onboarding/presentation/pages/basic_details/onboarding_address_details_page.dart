import 'dart:convert';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/components.dart';
import 'package:db_uicomponents/src/components/retail/ui_header_subheader_retail.dart';
import 'package:db_uicomponents/src/components/retail/ui_label_dropdown_retail.dart';
import 'package:dkb_retail/core/constants/asset_path/asset_path.dart';
import 'package:dkb_retail/core/router/app_router.dart';
import 'package:dkb_retail/extensions/string_extenstion.dart';
import 'package:dkb_retail/features/onboarding/presentation/widget/builf_info_row_message.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../common/components/auto_leading_widget.dart';
import '../../../../common/dialog/ui_dialogs.dart';
import '../../controller/notifier/onboarding_file_upload_notifier.dart';
import '../../controller/notifier/onboarding_save_stage_data_notifier.dart';
import '../../provider/onboarding_provider.dart';

@RoutePage()
class OnboardingAddressDetailsPage extends ConsumerStatefulWidget {
  const OnboardingAddressDetailsPage({super.key});

  @override
  ConsumerState<OnboardingAddressDetailsPage> createState() =>
      _OnboardingAddressDetailsPageState();
}

class _OnboardingAddressDetailsPageState
    extends ConsumerState<OnboardingAddressDetailsPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  File? _uploadedFile; // Stores the uploaded file
  TextEditingController uploadController = TextEditingController();
  TextEditingController areaNumberController = TextEditingController();
  TextEditingController buildingNumberController = TextEditingController();
  TextEditingController streetNameController = TextEditingController();
  TextEditingController zoneNumberController = TextEditingController();

  final List<String> proofOfAddressTypes = [
    "Please Select",
    "Utility Bill",
    "Bank Statement",
    "Lease Agreement",
    "Government Issued ID",
  ];

  File? selectedFile;
  String fieldStatus = "Upload File (PDF only)";
  String? errorMessage;
  String selectedAddressType = "";

  Future<void> _pickPDF() async {
    try {
      // Open the file picker
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'], // Restrict to PDF files
      );

      // Check if a file was selected
      if (result != null && result.files.isNotEmpty) {
        String? filePath = result.files.single.path;

        if (filePath != null) {
          selectedFile = File(filePath);
          // uploadController.text = "File Uploaded: ${result.files.single.name}";

          final notifier = ref.read(
            getOnboardingFileUploadNotifierProvider.notifier,
          );

          bool value = await notifier.fetch(
            imageType: "AddressPDF",
            fileExtension: "".getFileExtension(selectedFile!),
            fileSize: "${selectedFile!.lengthSync() ~/ 1024}",
            nationalId: ref.watch(getQidNumber),
            mobileNumber: ref.watch(getMobileNumber),
            fileType: "".getFileDetails(selectedFile!),
            fileBase64: base64Encode(selectedFile!.readAsBytesSync()),
          );
          if (value == true) {
            setState(() {
              selectedFile = File(filePath);
              uploadController.text =
                  "File uploaded: ${result.files.single.name}";
            });
          } else {
            UiDialogs.showErrorDialog(
              context: context,
              description: "Data not uploaded",
              bknOkPressed: () {
                setState(() {
                  selectedFile = null;
                  uploadController.text = "";
                });
              },
            );
          }

          // Log file details for debugging
          print("File path: $filePath");
          print("File name: ${result.files.single.name}");
          print("File size: ${selectedFile!.lengthSync()} bytes");
        } else {
          // File path is null
          setState(() {
            uploadController.text = "File path is null";
            selectedFile = null;
          });
          print("File path is null");
        }
      } else {
        // User canceled the file picker
        setState(() {
          uploadController.text = "No file selected";
          selectedFile = null;
        });
        print("No file selected");
      }
    } catch (e) {
      // Catch any unexpected errors
      print("Error during file selection: $e");
      setState(() {
        selectedFile = null;
        uploadController.text = "An error occurred while selecting a file";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentStage = getStageById(ref, "IDENTIFICATION_RESIDENT");

    return Scaffold(
      appBar: UIAppBar.secondary(
        autoLeadingWidget: AutoLeadingWidget(),
        title: "Identification",
        appBarColor: DefaultColors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const UiHeaderSubHeaderRetail(
                        title: "Personal / Residence / Mailing Address",
                        description:
                            "Fill out the information about your personal address and submit a proof of address.",
                      ),
                      const SizedBox(height: 20),
                      _buildAreaNumberField(),
                      const SizedBox(height: 20),
                      _buildStreetNameField(),
                      const SizedBox(height: 20),
                      _buildBuildingNumberField(),
                      const SizedBox(height: 20),
                      _buildZoneNumberField(),
                      const SizedBox(height: 20),

                      UiLabelDropdownRetail(
                        label: "Proof of Address Type",
                        options: proofOfAddressTypes,
                        onChanged: (value) {
                          setState(() {
                            selectedAddressType = ((value == 'Please Select')
                                ? ''
                                : value)!;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      _buildUploadPDFFile(),
                      // buildFormInputFieldForUpload(
                      //   uploadController,
                      //   "Upload Proof of Address ",
                      //   "Upload File", ()async{
                      //   final uploadedFilePath = await context.router.push(OnboardingProofAddressScanningRoute()) as File?;
                      //   if(uploadedFilePath != null) {
                      //     setState(() {
                      //       _uploadedFile = uploadedFilePath;
                      //       uploadController.text = (_uploadedFile != null) ? uploadController.text = _uploadedFile!
                      //           .path
                      //           .split('/')
                      //           .last : "";
                      //     });
                      //   }
                      // }
                      // ),
                      const SizedBox(height: 20),
                      // const Spacer(),
                      buildInfoMessage1(),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 40,
              child: UIButton.rounded(
                label: 'CONTINUE',
                width: double.infinity,
                isDisabled:
                    areaNumberController.text.isEmpty ||
                    streetNameController.text.isEmpty ||
                    buildingNumberController.text.isEmpty ||
                    zoneNumberController.text.isEmpty ||
                    selectedAddressType.isEmpty ||
                    !(uploadController.text.contains("File uploaded")) ||
                    selectedFile == null ||
                    !_formKey.currentState!.validate(),
                // selectedFile == null,
                // buttonColor: (_uploadedFile == null) ? DefaultColors.grayB3 : DefaultColors.blue9D,
                onPressed: () async {
                  // if(_uploadedFile != null)
                  bool value = await ref
                      .read(onboardingSaveStageDataNotifierProvider.notifier)
                      .fetch(
                        custJourneyId: ref.watch(customerJourneyId),
                        stageId: "${currentStage?.stageId}",
                        data: {
                          "Area_number": areaNumberController.text,
                          "Street_name": streetNameController.text,
                          "Building_number": buildingNumberController,
                          "Zone_number": zoneNumberController.text,
                          "Proof_address_type": selectedAddressType,
                          // "Upload_pdf_file":selectedFile,
                        },
                      );

                  if (value == true) {
                    context.router.push(OnboardingWorkHomeAddressRoute());
                  } else {
                    UiDialogs.showErrorDialog(
                      context: context,
                      description: "Data Not Saved",
                      bknOkPressed: () {
                        context.router.maybePop();
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAreaNumberField() {
    return UIFormTextField.outlined(
      hintText: "Enter Area Number",
      maxLength: 6,
      borderColor: DefaultColors.grayE6,
      labelUiText: const UiTextNew.h4Regular(
        "Area",
        color: DefaultColors.white_800,
      ),
      labelHintTextStyle: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        fontFamily: 'Rubik',
        color: DefaultColors.grayB3,
      ),

      labelTextStyle: const TextStyle(
        fontSize: 14,
        fontFamily: 'Rubik',
        fontWeight: FontWeight.w500,
        color: DefaultColors.white_800,
      ),
      onChanged: (value) {
        setState(() {
          areaNumberController.text = value;
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "This field is required";
        }
        if (!RegExp(r'^[a-zA-Z0-9]*$').hasMatch(value)) {
          return "No special characters are allowed including space.";
        }

        return null;
      },
    );
  }

  Widget _buildStreetNameField() {
    return UIFormTextField.outlined(
      hintText: "Enter Street Name",
      maxLength: 6,
      borderColor: DefaultColors.grayE6,
      labelUiText: const UiTextNew.h4Regular(
        "Street",
        color: DefaultColors.white_800,
      ),
      labelHintTextStyle: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        fontFamily: 'Rubik',
        color: DefaultColors.grayB3,
      ),

      labelTextStyle: const TextStyle(
        fontSize: 14,
        fontFamily: 'Rubik',
        fontWeight: FontWeight.w500,
        color: DefaultColors.white_800,
      ),
      onChanged: (value) {
        setState(() {
          streetNameController.text = value;
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "This field is required";
        }
        if (!RegExp(r'^[a-zA-Z0-9]*$').hasMatch(value)) {
          return "No special characters are allowed including space.";
        }

        return null;
      },
    );
  }

  Widget _buildBuildingNumberField() {
    return UIFormTextField.outlined(
      hintText: "Enter Building Number",
      maxLength: 5,
      borderColor: DefaultColors.grayE6,
      labelUiText: const UiTextNew.h4Regular(
        "Building Number",
        color: DefaultColors.white_800,
      ),
      labelHintTextStyle: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        fontFamily: 'Rubik',
        color: DefaultColors.grayB3,
      ),

      labelTextStyle: const TextStyle(
        fontSize: 14,
        fontFamily: 'Rubik',
        fontWeight: FontWeight.w500,
        color: DefaultColors.white_800,
      ),
      onChanged: (value) {
        setState(() {
          buildingNumberController.text = value;
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "This field is required";
        }
        if (!RegExp(r'^[a-zA-Z0-9]*$').hasMatch(value)) {
          return "No special characters are allowed including space.";
        }

        return null;
      },
    );
  }

  Widget _buildZoneNumberField() {
    return UIFormTextField.outlined(
      hintText: "Enter Zone Number",
      maxLength: 5,
      borderColor: DefaultColors.grayE6,
      labelUiText: const UiTextNew.h4Regular(
        "Zone Number",
        color: DefaultColors.white_800,
      ),
      labelHintTextStyle: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        fontFamily: 'Rubik',
        color: DefaultColors.grayB3,
      ),

      labelTextStyle: const TextStyle(
        fontSize: 14,
        fontFamily: 'Rubik',
        fontWeight: FontWeight.w500,
        color: DefaultColors.white_800,
      ),
      onChanged: (value) {
        setState(() {
          zoneNumberController.text = value;
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "This field is required";
        }
        if (!RegExp(r'^[a-zA-Z0-9]*$').hasMatch(value)) {
          return "No special characters are allowed including space.";
        }

        return null;
      },
    );
  }

  Widget _buildUploadPDFFile() {
    return UIFormTextField.outlined(
      hintText: "Upload File",
      readOnly: true,
      borderColor: DefaultColors.grayE6,
      labelUiText: const UiTextNew.h4Regular(
        "Upload Proof of Address (PDF Only)",
        color: DefaultColors.white_800,
      ),
      controller: uploadController,
      labelHintTextStyle: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        fontFamily: 'Rubik',
        color: DefaultColors.grayB3,
      ),
      prefixIcon: Padding(
        padding: const EdgeInsets.all(10),
        child: GestureDetector(
          onTap: _pickPDF,
          child: SvgPicture.asset(
            AssetPath.icon.onboardingAttachFileIcon,
            width: 24,
            height: 24,
            fit: BoxFit.contain,
          ),
        ),
      ),
      labelTextStyle: const TextStyle(
        fontSize: 14,
        fontFamily: 'Rubik',
        fontWeight: FontWeight.w500,
        color: DefaultColors.white_800,
      ),
      validator: (value) {
        if (!(uploadController.text.contains("File uploaded")) ||
            selectedFile == null) {
          return "This field is required";
        }
        return null;
      },
    );
  }
}

Widget buildInfoMessage1() {
  return Container(
    color: const Color(0xFFFEFDED),
    padding: const EdgeInsets.all(8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.info_outline, color: DefaultColors.white_800, size: 14),
            SizedBox(width: 8), // Space between number and text
            Expanded(
              child: Wrap(
                children: [
                  UiTextNew.customRubik(
                    "Make sure the document is",
                    fontSize: 12,
                    color: DefaultColors.white_800, // Bold number with period
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        buildInfoRowMessage("•   ", "Valid for this effect"),
        buildInfoRowMessage("•   ", "Is less than 3 months old"),
        buildInfoRowMessage("•   ", "Complete and easy to read"),

        // UiTextNew.h4Regular(
        // " •   Valid for this effect",
        // color: DefaultColors.white_800,
        //           ),
        // UiTextNew.h4Regular(
        //   " •   Is less than 3 months old",
        //   color: DefaultColors.white_800,
        // ),
        // UiTextNew.h4Regular(
        //   " •   Complete and easy to read",
        //   color: DefaultColors.white_800,
        // )
      ],
    ),
  );
}
