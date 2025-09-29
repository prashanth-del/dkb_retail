import 'package:flutter/material.dart';

class UIPopupViewModel {
  final BuildContext context;
  final bool barrierDismissible;
  final bool closeIcon;
  final String title;
  final TextStyle? titleStyle;
  final String? content;
  final Widget? contentWidget;
  final TextStyle? contentStyle;
  final String? image;
  final double? imageSize;
  final Duration dismissAfter;
  final String buttonText;
  final VoidCallback? onButtonPressed;
  final VoidCallback? onClosePressed;
  final bool showButton;
  final TextAlign textAlign;

  UIPopupViewModel({
    required this.context,
    required this.title,
    this.content,
    this.contentWidget,
    this.image,
    this.barrierDismissible = true,
    this.closeIcon = false,
    this.titleStyle,
    this.contentStyle,
    this.imageSize,
    this.dismissAfter = const Duration(seconds: 0),
    this.buttonText = 'OK',
    this.onButtonPressed,
    this.onClosePressed,
    this.showButton=true,
    this.textAlign = TextAlign.center,
  }) : assert(
  content != null || contentWidget != null,
  'Either content or contentWidget must be provided.',
  );
}