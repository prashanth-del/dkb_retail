import 'dart:convert';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/components.dart';
import 'package:db_uicomponents/src/components/retail/ui_button_retail.dart';
import 'package:db_uicomponents/src/components/retail/ui_header_subheader_retail.dart';
import 'package:flutter/material.dart';
import 'package:dkb_retail/core/router/app_router.dart';
import 'package:dkb_retail/features/onboarding/presentation/provider/onboarding_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

import '../../../../../core/constants/asset_path/asset_path.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../common/dialog/ui_dialogs.dart';
import '../../controller/notifier/onboarding_file_upload_notifier.dart';
import '../../controller/notifier/onboarding_save_stage_data_notifier.dart';
import '../../widget/builf_info_row_message.dart';

@RoutePage()
class OnboardingSignaturePage extends ConsumerStatefulWidget {
  @override
  @override
  ConsumerState<OnboardingSignaturePage> createState() =>
      _OnboardingSignaturePageState();
}

class _OnboardingSignaturePageState
    extends ConsumerState<OnboardingSignaturePage> {
  File? _signatureImage;

  final picker = ImagePicker();

  Future<void> _selectDocument() async {
    ref.read(isFrontCardImageProvider.notifier).state = "";
    final selectedImage =
        await context.router.push(OnboardingDocumentProcessingRoute()) as File?;

    setState(() {
      _signatureImage = selectedImage != null ? selectedImage : null;
    });
  }

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _signatureImage = File(pickedFile.path);
      });
    }
  }

  String getFileExtension(File file) {
    return path.extension(file.path).toLowerCase();
  }

  String getFileDetails(File file) {
    // Get the file extension
    String fileExtension = path
        .extension(file.path)
        .toLowerCase(); // e.g., ".jpeg"

    // Determine the file type based on the extension
    String fileType;
    if (fileExtension == '.jpg' || fileExtension == '.jpeg') {
      fileType = 'jpeg';
    } else if (fileExtension == '.png') {
      fileType = 'png';
    } else if (fileExtension == '.pdf') {
      fileType = 'pdf';
    } else {
      fileType = 'unknown';
    }
    return fileType;
    print("File Extension: $fileExtension");
    print("File Type: $fileType");
  }

  void _submit() {
    if (_signatureImage != null) {
      // Logic to send images to the backend or process them.
      context.router.push(OnboardingVerifyIdentificationRoute());
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Images submitted successfully!')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please scan both front and back sides.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentStage = getStageById(ref, "SIGN");

    return Scaffold(
      appBar: AppBar(title: Text('Signature')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const UiHeaderSubHeaderRetail(
              title: "Signature",
              description: "Please sign a piece of paper 4 times.",
            ),

            SizedBox(height: 24),

            buildInfoMessage1(),
            SizedBox(height: 24),

            Expanded(
              child: GestureDetector(
                onTap: () =>
                    _selectDocument(), //context.router.push(OnboardingDocumentProcessingRoute()),
                child: Container(
                  width: MediaQuery.of(context).size.width - 40,
                  // margin: EdgeInsets.all(8),
                  // decoration: BoxDecoration(
                  //   border: Border.all(color: DefaultColors.blue9D),
                  //   borderRadius: BorderRadius.circular(8),
                  // ),
                  child: _signatureImage != null
                      ? Image.file(_signatureImage!, fit: BoxFit.cover)
                      : Center(
                          child: Image.asset(
                            AssetPath.image.onboardingSignImage,
                            fit: BoxFit.contain,
                            width: double.infinity,
                          ),
                        ),
                ),
              ),
            ),
            SizedBox(height: 20),
            const UiTextNew.h4Regular(
              "Make sure the document is readable and avoid any reflection.",
              color: DefaultColors.white_800,
            ),
            const SizedBox(height: 20),
            ActionButtonWidget(
              text: (_signatureImage != null) ? 'SUBMIT' : 'SCAN SIGNATURE',
              onPressed: () async {
                if (_signatureImage == null) {
                  _selectDocument();
                } else {
                  final notifier = ref.read(
                    getOnboardingFileUploadNotifierProvider.notifier,
                  );

                  bool value = await notifier.fetch(
                    imageType: "signature",
                    fileExtension: "${getFileExtension(_signatureImage!)}",
                    fileSize: "${_signatureImage!.lengthSync() ~/ 1024}",
                    nationalId: ref.watch(getQidNumber),
                    mobileNumber: ref.watch(getMobileNumber),
                    fileType: getFileDetails(_signatureImage!),
                    fileBase64: base64Encode(
                      _signatureImage!.readAsBytesSync(),
                    ),
                  );
                  if (value == true) {
                    bool value = await ref
                        .read(onboardingSaveStageDataNotifierProvider.notifier)
                        .fetch(
                          custJourneyId: ref.watch(customerJourneyId),
                          stageId: "${currentStage?.stageId}",
                          data: {"Sign_Image": _signatureImage},
                        );

                    if (value == true) {
                      ref.read(isFromSignatureVerifiedProvider.notifier).state =
                          true;
                      context.router.push(OnboardingOtpRoute());
                    } else {
                      UiDialogs.showErrorDialog(
                        context: context,
                        description: "Data Not Saved",
                        bknOkPressed: () {
                          context.router.maybePop();
                        },
                      );
                    }
                  } else {
                    UiDialogs.showErrorDialog(
                      context: context,
                      description: "Selfie not uploaded",
                      bknOkPressed: () {
                        _signatureImage == null;
                        context.router.maybePop();
                      },
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
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
        buildInfoRowMessage(" •  ", "4 Signatures"),
        buildInfoRowMessage(" •  ", "White coloured paper only"),
        buildInfoRowMessage(" •  ", "Blue and Black pen only"),
        buildInfoRowMessage(" •  ", "Same signature as on QID"),
      ],
    ),
  );
}
