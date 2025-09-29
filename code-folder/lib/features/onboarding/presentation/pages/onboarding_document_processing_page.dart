import 'dart:io';

import 'package:auto_route/annotations.dart';
import 'package:camera/camera.dart';
import 'package:db_uicomponents/components.dart';
import 'package:flutter/material.dart';
import 'package:dkb_retail/core/constants/asset_path/asset_path.dart';
import 'package:dkb_retail/features/onboarding/presentation/provider/onboarding_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/constants/colors.dart';

@RoutePage()
class OnboardingDocumentProcessingPage extends ConsumerStatefulWidget {
  @override
  _OnboardingDocumentProcessingPageState createState() =>
      _OnboardingDocumentProcessingPageState();
}

class _OnboardingDocumentProcessingPageState
    extends ConsumerState<OnboardingDocumentProcessingPage> {
  late CameraController _cameraController;
  bool _isCameraInitialized = false;
  XFile? _capturedImage;
  final ImagePicker _picker = ImagePicker();
  File? _pickedImage;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _pickImageFromGallery() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80, // Reduce image size
    );

    if (image != null) {
      Navigator.pop(context, File(image.path)); // Return the picked image
    }
  }

  Future<void> _captureImage() async {
    if (_isCameraInitialized) {
      final image = await _cameraController.takePicture();
      Navigator.pop(context, File(image.path)); // Return the captured image
    }
  }
  // Function to pick an image from the gallery
  // Future<void> _pickImageFromGallery() async {
  //   final XFile? image = await _picker.pickImage(
  //     source: ImageSource.gallery,
  //     imageQuality: 80, // Reduce image size
  //   );
  //
  //   if (image != null) {
  //     setState(() {
  //       _pickedImage = File(image.path);
  //       _capturedImage = null; // Clear the captured image
  //     });
  //   }
  // }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      final firstCamera = cameras.first;

      _cameraController = CameraController(
        firstCamera,
        ResolutionPreset.medium,
      );

      await _cameraController.initialize();
      if (!mounted) return;

      setState(() {
        _isCameraInitialized = true;
      });
    } catch (e) {
      debugPrint('Error caught in opening camera');
    }
  }

  // Future<void> _captureImage() async {
  //   if (_isCameraInitialized) {
  //     final image = await _cameraController.takePicture();
  //     setState(() {
  //       _capturedImage = image;
  //       _pickedImage = null; // Clear the picked image
  //     });
  //   }
  // }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Identification"),
        backgroundColor: Colors.white,
        centerTitle: true,
        foregroundColor: Colors.black,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Processing Text
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20),
            child: UiTextNew.h4Regular(
              "Document processing...\nHold the device still",
              color: DefaultColors.blue_02,
              textAlign: TextAlign.center,
            ),
          ),
          // Camera, Captured Image, or Picked Image
          Expanded(
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 40.0,
                  horizontal: 20,
                ),

                height: 300,
                width: double.infinity,
                child: _capturedImage != null
                    ? Image.file(File(_capturedImage!.path), fit: BoxFit.cover)
                    : _pickedImage != null
                    ? Image.file(_pickedImage!, fit: BoxFit.cover)
                    : _isCameraInitialized
                    ? CameraPreview(_cameraController)
                    : Center(child: CircularProgressIndicator()),
              ),
            ),
          ),

          // Label "Front Side"
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: UiTextNew.customRubik(
              ref.read(isFrontCardImageProvider),
              fontSize: 16,
              color: DefaultColors.white,
            ),
          ),
          // Camera Controls
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed:
                      _pickImageFromGallery, // Call the gallery picker function
                  icon: SvgPicture.asset(
                    AssetPath.icon.onboardingGalleryIcon,
                    width: 32,
                    height: 32,
                  ),
                ),
                const SizedBox(width: 32),
                GestureDetector(
                  onTap: _captureImage,
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey, width: 2),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        AssetPath.icon.onboardingCameraIcon,
                        width: 50,
                        height: 50,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
