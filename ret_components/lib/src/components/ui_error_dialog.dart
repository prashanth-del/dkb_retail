import 'package:db_uicomponents/styles.dart';
import 'package:flutter/material.dart';

class UiErrorDialog extends StatelessWidget {
  final String title;
  final String message;
  final String buttonText;
  final VoidCallback? onOk;

  const UiErrorDialog({
    super.key,
    required this.title,
    required this.message,
    this.buttonText = "OK",
    this.onOk,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final shortestSide = size.shortestSide;
    final textScale = MediaQuery.of(context).textScaleFactor;

    // Dynamic sizing helpers
    double dp(double value) => value * shortestSide / 400;
    double sp(double value) => value * textScale;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(dp(16)),
      ),
      child: Padding(
        padding: EdgeInsets.all(dp(20)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Error Icon
            Icon(
              Icons.error_outline,
              color: DefaultColors.blue98,
              size: dp(40),
            ),
            SizedBox(height: dp(12)),

            // Title
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: sp(18),
                fontWeight: FontWeight.bold,
                color: DefaultColors.blue98,
              ),
            ),
            SizedBox(height: dp(8)),

            // Message
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: sp(14),
                color: Colors.brown[700], // softer than black
              ),
            ),
            SizedBox(height: dp(20)),

            // OK Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(dp(30)),
                  ),
                  backgroundColor: DefaultColors.blue98,
                  foregroundColor:
                      Colors.brown[800], // darker text for contrast
                  padding: EdgeInsets.symmetric(vertical: dp(12)),
                ),
                onPressed: onOk?.call ??
                    () {
                      Navigator.of(context).pop();
                    },
                child: Text(
                  buttonText,
                  style: TextStyle(
                    fontSize: sp(14),
                    color: DefaultColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
