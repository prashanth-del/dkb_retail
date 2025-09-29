import 'package:db_uicomponents/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';

class DynamicPopup extends StatelessWidget {
  final String title;
  final String message;
  final String? imagePath; // Path for the dynamic image (optional)
  final VoidCallback? onDismiss;
  final VoidCallback? onView;

  const DynamicPopup({
    Key? key,
    required this.title,
    required this.message,
    this.imagePath,
    this.onDismiss,
    this.onView,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Dynamic Image (if provided)
            if (imagePath != null)
              Image.asset(
                imagePath!,
                width: 60,
                height: 60,
              ),
            const SizedBox(height: 16),

            // Title
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),

            const SizedBox(height: 8),

            // Message
            Text(
              message,
              style: const TextStyle(fontSize: 14, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),

            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Dismiss Button
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[300],
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: onDismiss ?? () => Navigator.of(context).pop(),
                    child: UiTextNew.h5Regular("dISMISS",
                      color: DefaultColors.blue88,),
                  ),
                ),
                const SizedBox(width: 8),

                // View Button
                if (onView != null)
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: DefaultColors.blue9C,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: onView,
                      child: UiTextNew.h5Regular("VIEW",
                        color: DefaultColors.white,),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
