import 'package:flutter/material.dart';

class UiActionDialog extends StatelessWidget {
  final String title;
  final String yesText;
  final String noText;
  final VoidCallback? onYes;
  final VoidCallback? onNo;

  const UiActionDialog({
    super.key,
    required this.title,
    this.yesText = "Yes",
    this.noText = "No",
    this.onYes,
    this.onNo,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final shortestSide = size.shortestSide; // base for scaling
    final textScale = MediaQuery.of(context).textScaleFactor;

    // Dynamic sizing helpers
    double dp(double value) => value * shortestSide / 400; // scale with device
    double sp(double value) => value * textScale; // scale text

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(dp(16)),
      ),
      child: Padding(
        padding: EdgeInsets.all(dp(20)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: sp(16),
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: dp(20)),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(dp(30)),
                      ),
                      side: const BorderSide(color: Colors.blue),
                      padding: EdgeInsets.symmetric(vertical: dp(12)),
                    ),
                    onPressed: onYes?.call ??
                        () {
                          Navigator.of(context).pop(true);
                        },
                    child: Text(
                      yesText,
                      style: TextStyle(
                        fontSize: sp(14),
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: dp(12)),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(dp(30)),
                      ),
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(vertical: dp(12)),
                    ),
                    onPressed: onNo?.call ??
                        () {
                          Navigator.of(context).pop(false);
                        },
                    child: Text(
                      noText,
                      style: TextStyle(
                        fontSize: sp(14),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
