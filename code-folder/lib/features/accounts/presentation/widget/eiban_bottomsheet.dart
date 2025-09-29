import 'package:db_uicomponents/components.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';

class IBANCertificateBottomSheet extends StatelessWidget {
  const IBANCertificateBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * 0.35, // Set the bottom sheet size
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header with title and close button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const UiTextNew.customRubik(
                "IBAN Certificate",
                color: DefaultColors.white_800,
                fontSize: 16,
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),

          const Divider(),

          const SizedBox(height: 16),

          // Buttons with equal sizes
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[300],
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                // Handle send to registered email
              },
              child: const UiTextNew.h5Regular("Send to registered email address"),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[300],
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                // Handle share on WhatsApp
              },
              child: const UiTextNew.h5Regular("Share on WhatsApp"),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[300],
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                // Handle download to phone
              },
              child: const UiTextNew.h5Regular("Download to phone"),
            ),
          ),
        ],
      ),
    );
  }
}
