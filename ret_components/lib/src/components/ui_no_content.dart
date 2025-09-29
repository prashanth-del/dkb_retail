import 'package:flutter/material.dart';
import 'ui_lottie.dart';

import '../../utils.dart';

class UINoContent extends StatelessWidget {
  final String? lottieAsset;
  final double? animHeight;
  final String? imageAsset;
  final String? title;
  final String? description;
  final Widget? actionButton;
  final bool showHeight;
  const UINoContent({
    super.key,
    this.lottieAsset,
    this.animHeight,
    this.title,
    this.description,
    this.actionButton,
    this.imageAsset,
    this.showHeight = true,
  });

  @override
  Widget build(BuildContext context) {
    debugPrint("Asset path $lottieAsset");
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (showHeight)
          SizedBox(
            height: context.screenHeight * 0.1,
          ),
        imageAsset != null
            ? Image.asset(
                imageAsset!,
                height: animHeight ?? context.screenHeight * 0.25,
              )
            : lottieAsset != null
                ? UILottie(
                    asset: lottieAsset!,
                    height: animHeight ?? context.screenHeight * 0.25,
                  )
                : const SizedBox.shrink(),
        if (imageAsset != null || lottieAsset != null)
          const SizedBox(height: 16),
        Text(
          title ?? "No Records Found",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 18),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            description ?? "",
            style:
                Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ),
        if (actionButton != null) const SizedBox(height: 24),
        if (actionButton != null)
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: actionButton!)
      ],
    );
  }
}
