import 'dart:io';
import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/components.dart';
import 'package:dkb_retail/core/router/app_router.dart';
import 'package:dkb_retail/features/onboarding/presentation/provider/onboarding_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:db_uicomponents/src/components/retail/ui_button_retail.dart';
import 'package:db_uicomponents/src/components/retail/ui_header_subheader_retail.dart';

import '../../../../../core/constants/asset_path/asset_path.dart';
import '../../../../../core/constants/colors.dart';
import '../../widget/build_info_message.dart';

@RoutePage()
class OnboardingProofAddressScanningPage extends ConsumerStatefulWidget {
  const OnboardingProofAddressScanningPage({super.key});

  @override
  _OnboardingProofAddressScanningPageState createState() =>
      _OnboardingProofAddressScanningPageState();
}

class _OnboardingProofAddressScanningPageState
    extends ConsumerState<OnboardingProofAddressScanningPage> {
  File? _addressImage;

  final picker = ImagePicker();

  Future<void> _selectDocument() async {
    ref.read(isFrontCardImageProvider.notifier).state = "";
    final selectedImage =
        await context.router.push(OnboardingDocumentProcessingRoute()) as File?;

    if (selectedImage != null) {
      setState(() {
        _addressImage = selectedImage;
      });
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _addressImage = File(pickedFile.path);
      });
    }
  }

  void _submit() {
    if (_addressImage != null) {
      // Logic to send images to the backend or process them.
      context.router.push(OnboardingVerifyIdentificationRoute());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Images submitted successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please scan both front and back sides.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Identify Document')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const UiHeaderSubHeaderRetail(
              title: "Proof of Address",
              description: "Tap on the card to scan the document",
            ),

            const SizedBox(height: 20),

            Expanded(
              child: GestureDetector(
                onTap: () =>
                    _selectDocument(), //context.router.push(OnboardingDocumentProcessingRoute()),
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: DefaultColors.blue9D),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: _addressImage != null
                      ? Image.file(_addressImage!, fit: BoxFit.cover)
                      : Center(
                          child: SvgPicture.asset(
                            AssetPath.icon.onboardingFrontImageRetailIcon,
                            fit: BoxFit.contain,
                          ),
                        ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const UiTextNew.h4Regular(
              "Make sure the document is readable and avoid any reflection.",
              color: DefaultColors.white_800,
            ),
            const SizedBox(height: 20),
            buildInfoMessage(
              "!",
              "You have 30 days to finish the process. if you aren’t able to finish the process now, you’ll be able to continue it later by inserting your phone number & QID here",
            ),

            const SizedBox(height: 20),
            ActionButtonWidget(
              text: (_addressImage != null) ? 'SUBMIT' : 'SCAN DOCUMENT',
              onPressed: () {
                if (_addressImage == null) {
                  _selectDocument();
                } else {
                  context.router.maybePop(File(_addressImage!.path));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
