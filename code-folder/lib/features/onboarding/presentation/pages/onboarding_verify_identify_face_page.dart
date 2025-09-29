import 'dart:convert';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:camera/camera.dart';
import 'package:db_uicomponents/components.dart';
import 'package:db_uicomponents/src/components/retail/ui_button_retail.dart';
import 'package:flutter/material.dart';
import 'package:dkb_retail/core/constants/asset_path/asset_path.dart';
import 'package:dkb_retail/core/router/app_router.dart';
import 'package:dkb_retail/core/utils/extensions/locale_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../../../../core/constants/colors.dart';
import '../../../common/components/auto_leading_widget.dart';
import '../../../common/dialog/ui_dialogs.dart';
import '../controller/notifier/onboarding_block_journey_notifier.dart';
import '../controller/notifier/onboarding_file_upload_notifier.dart';
import '../controller/notifier/onboarding_save_stage_data_notifier.dart';
import '../provider/onboarding_provider.dart';

@RoutePage()
class OnboardingVerifyIdentifyFacePage extends ConsumerStatefulWidget {
  @override
  _OnboardingVerifyIdentifyFacePageState createState() =>
      _OnboardingVerifyIdentifyFacePageState();
}

class _OnboardingVerifyIdentifyFacePageState
    extends ConsumerState<OnboardingVerifyIdentifyFacePage> {
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  bool _isCameraInitialized = false;
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    _cameras = await availableCameras();
    if (_cameras != null) {
      _cameraController = CameraController(
        _cameras![1],
        ResolutionPreset.medium,
      );
      await _cameraController?.initialize();
      if (mounted) {
        setState(() {
          _isCameraInitialized = true;
        });
      }
    }
  }

  Future<void> takePicture() async {
    if (!_cameraController!.value.isInitialized) return;
    final tempDir = await getTemporaryDirectory();
    final imagePath = path.join(tempDir.path, '${DateTime.now()}.png');
    await _cameraController?.takePicture().then((XFile file) {
      setState(() {
        _imageFile = File(file.path);
      });
    });
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentStage = getStageById(ref, "TAKE_SELFIE");

    ref.listen(onboardingBlockJourneyNotifierProvider, (previous, next) {
      next.maybeWhen(
        data: (response) {
          // Handle successful response
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(response.message)));
          context.router.replace(LoginRoute());
        },
        error: (error, stackError) => UiDialogs.showErrorDialog(
          context: context,
          description: "$error",
          bknOkPressed: () {
            context.router.maybePop();
          },
        ),
        loading: () {
          // Optionally handle loading state
          Center(
            child: UiLoader(
              loadingText: ref.getLocaleString(
                "Loading",
                defaultValue: "Loading...",
              ),
            ),
          );
        },
        orElse: () {},
      );
    });

    return Scaffold(
      appBar: const UIAppBar.secondary(
        title: "Identification",
        autoLeadingWidget: const AutoLeadingWidget(),
        iconWidth: 20,
        iconHeight: 20,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Camera Preview or Captured Image
            const Spacer(),

            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _imageFile == null
                      ? _isCameraInitialized
                            ? Stack(
                                alignment: Alignment.center,
                                children: [
                                  AspectRatio(
                                    aspectRatio:
                                        _cameraController!.value.aspectRatio,
                                    child: CameraPreview(_cameraController!),
                                  ),
                                  Container(
                                    height: 250,
                                    width: 250,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.grey.shade400,
                                        width: 4,
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Image.asset(
                                AssetPath.image.onboardingFaceImage,
                                width: 240,
                                height: 240,
                              )
                      : Container(
                          height: 250,
                          width: 250,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: FileImage(_imageFile!),
                              fit: BoxFit.cover,
                            ),
                            border: Border.all(color: Colors.green, width: 4),
                          ),
                        ),
                  SizedBox(height: 32),

                  const UiTextNew.h4Regular(
                    'Starting the session \nKeep your face within the defined bounds',
                    color: DefaultColors.white_800,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            // SizedBox(height: 30),
            // Buttons
            const Spacer(),
            _imageFile == null
                ? ActionButtonWidget(
                    text: 'TAKE A SELFIE',
                    onPressed: takePicture,
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: ActionButtonWidget(
                          text: 'RETAKE SELFIE',
                          textColor: DefaultColors.blue9D,
                          buttonColor: DefaultColors.blue_02,
                          onPressed: () {
                            int retakeSelfie =
                                ref.watch(retakeSelfieAttemptsProvider) + 1;
                            if (retakeSelfie >= 6) {
                              ref
                                      .read(
                                        retakeSelfieAttemptsProvider.notifier,
                                      )
                                      .state =
                                  0;
                              ref
                                  .read(
                                    onboardingBlockJourneyNotifierProvider
                                        .notifier,
                                  )
                                  .fetch(
                                    mobileNumber: ref.watch(getMobileNumber),
                                    blockPeriod:
                                        "${ref.watch(customerJourneyId)}",
                                    nationalId: ref.watch(getQidNumber),
                                    blockReason: "TAKE_SELFIE",
                                  );
                              //block
                            } else {
                              ref
                                      .read(
                                        retakeSelfieAttemptsProvider.notifier,
                                      )
                                      .state =
                                  retakeSelfie;
                              setState(() {
                                _imageFile = null;
                              });
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: UIButton.rounded(
                          label: 'Save & Continue',
                          height: 42.5,
                          isDisabled: _imageFile == null,
                          onPressed: () async {
                            final notifier = ref.read(
                              getOnboardingFileUploadNotifierProvider.notifier,
                            );

                            bool value = await notifier.fetch(
                              imageType: "selfie",
                              fileExtension: "${getFileExtension(_imageFile!)}",
                              fileSize: "${_imageFile!.lengthSync() ~/ 1024}",
                              nationalId: ref.watch(getQidNumber),
                              mobileNumber: ref.watch(getMobileNumber),
                              fileType: getFileDetails(_imageFile!),
                              fileBase64: base64Encode(
                                _imageFile!.readAsBytesSync(),
                              ),
                            );
                            if (value == true) {
                              bool value = await ref
                                  .read(
                                    onboardingSaveStageDataNotifierProvider
                                        .notifier,
                                  )
                                  .fetch(
                                    custJourneyId: ref.watch(customerJourneyId),
                                    stageId: "${currentStage?.stageId}",
                                    data: {"TAKE_SELFIE": _imageFile},
                                  );

                              if (value == true) {
                                context.router.push(
                                  OnboardingBasicDetailsRoute(),
                                );
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
                                  _imageFile == null;
                                  context.router.maybePop();
                                },
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
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
}
