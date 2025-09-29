import 'package:db_uicomponents/components.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:flutter/material.dart';

class UiServerError extends StatelessWidget {
  /// Callback function that gets triggered when the user presses the "Retry" button.
  final VoidCallback? onRetry;

  final String description;

  /// Error message to be displayed, such as server-related issues.
  final String errorMessage;

  final String? lottieAssetPath;

  const UiServerError({
    Key? key,
    this.onRetry,
    this.lottieAssetPath,
    this.description = "Please try again later.",
    required this.errorMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display an error icon

            if (lottieAssetPath != null)
              UILottie(
                asset: lottieAssetPath!,
                width: 200,
                // height: context.screenHeight * 0.25,
              ),

            // Display the error message text
            UiTextNew.b1Medium(
              errorMessage,
              textAlign: TextAlign.center,
            ),
            UiSpace.vertical(5),
            UiTextNew.b2Regular(
              description,
              textAlign: TextAlign.center,
            ),
            //
            // // Retry button for retrying the action
            // if (onRetry != null)
            //   UIButton.rounded(
            //     onPressed: onRetry,
            //     label: "Retry",
            //   )
          ],
        ),
      ),
    );
  }
}
