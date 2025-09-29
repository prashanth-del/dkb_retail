import 'dart:io';
import 'popup_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UIPopup extends StatelessWidget {
  final String title;
  final TextStyle? titleStyle;
  final TextStyle? contentStyle;
  final String? content;
  final Widget? contentWidget;
  final String? image;
  final double? imageSize;
  final bool closeIcon;
  final Duration dismissAfter;
  final String buttonText;
  final VoidCallback? onButtonPressed;
  final VoidCallback? onClosePressed;
  final bool showButton;
  final textAlign;

  const UIPopup({
    super.key,
    required this.title,
    required this.content,
    this.image,
    this.contentWidget,
    this.titleStyle,
    this.contentStyle,
    this.imageSize,
    this.closeIcon = false,
    this.dismissAfter = defaultDismissDuration,
    this.buttonText = defaultButtonText,
    this.onButtonPressed,
    this.onClosePressed,
    this.textAlign = TextAlign.center,
    this.showButton = true,
  });

  @override
  Widget build(BuildContext context) {
    if (dismissAfter != Duration.zero) {
      Future.delayed(dismissAfter, () {
        Navigator.of(context).pop();
      });
    }

    Widget iconWidget = Align(
      alignment: Alignment.topRight,
      child: IconButton(
          onPressed: () {
            if (onClosePressed != null) {
              onClosePressed!();
            } else {
              Navigator.of(context).pop();
            }
          },
          iconSize: 20,
          style: const ButtonStyle(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(
              minHeight: 20, minWidth: 20, maxHeight: 20, maxWidth: 20),
          icon: const Icon(
            Icons.close,
            color: Colors.black54,
            size: 20,
          )),
    );

    Widget titleItem = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (closeIcon) iconWidget,
        if (image != null)
          image!.endsWith('.svg')
              ? SvgPicture.asset(
                  image!,
                  width: imageSize ?? 60,
                  height: imageSize ?? 60,
                )
              : Image.asset(
                  image!,
                  width: imageSize ?? 60,
                  height: imageSize ?? 60,
                ),
        const SizedBox(height: 16),
        Text(
          title,
          textAlign:textAlign,
          style: titleStyle ??
              const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ],
    );

    Widget contentItem = contentWidget ??
        Text(
          content!,
          style: contentStyle ?? const TextStyle(fontSize: 13),
          textAlign: TextAlign.center,
        );

    if (Platform.isIOS) {
      return CupertinoAlertDialog(
        title: titleItem,
        content: contentItem,
        actions: closeIcon
            ? []
            :(showButton
            ? [
          CupertinoDialogAction(
            onPressed: () {
              if (onButtonPressed != null) {
                onButtonPressed!();
              } else {
                Navigator.of(context).pop();
              }
            },
            child: Text(buttonText),
          ),
        ]
            : []),
      );
    } else {
      return AlertDialog(
        title: titleItem,
        content: contentItem,
        actionsAlignment: MainAxisAlignment.center,
        actions: closeIcon
            ? null
            : (showButton
            ? [
          MaterialButton(
            color: const Color(0xFF4197CB),
            minWidth: MediaQuery.of(context).size.width,
            height: 40,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6)),
            onPressed: () {
              if (onButtonPressed != null) {
                onButtonPressed!();
              } else {
                Navigator.of(context).pop();
              }
            },
            child: Text(
              buttonText,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ]
            : []),
      );
    }
  }
}
