import 'package:flutter/material.dart';
import 'package:db_uicomponents/components.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ActionSelectionSheet extends StatelessWidget {
  final VoidCallback onCameraTap;
  final VoidCallback onGalleryTap;
  final VoidCallback onPdfTap;

  const ActionSelectionSheet({
    Key? key,
    required this.onCameraTap,
    required this.onGalleryTap,
    required this.onPdfTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildActionCard('assets/icons/camera_icon.svg', 'Camera', onCameraTap),
            _buildActionCard('assets/icons/Gallery.svg', 'Gallery', onGalleryTap),
            _buildActionCard('assets/icons/pdf.svg', 'Pdf', onPdfTap),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard(String assetPath, String label, VoidCallback onTap) {
    return SizedBox(
      width: 100,
      child: UiCard(
        onTap: onTap,
        padding: const EdgeInsets.all(12),
        borderRadius: BorderRadius.circular(12),
        cardColor: DefaultColors.grayF4,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(assetPath, width: 28, height: 28),
            const SizedBox(height: 6),
            UiTextNew.b14Medium(label, color: DefaultColors.black),
          ],
        ),
      ),
    );
  }
}