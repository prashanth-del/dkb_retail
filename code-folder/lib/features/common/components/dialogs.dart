import 'package:db_uicomponents/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Shows error popup
void showErrorDialog(
  String message,
  BuildContext context,
  WidgetRef ref, {
  VoidCallback? onOk,
}) {
  showDialog(
    context: context,
    builder: (_) => UiErrorDialog(
      title: "Error",
      message: message,
      buttonText: "OK",
      onOk: onOk,
    ),
  );
}

/// Shows action (confirm) popup
void showActionDialog({
  required String title,
  required BuildContext context,
  String yesText = "Yes",
  String noText = "No",
  VoidCallback? onYes,
  VoidCallback? onNo,
}) {
  showDialog(
    context: context,
    builder: (_) => UiActionDialog(
      title: title,
      yesText: yesText,
      noText: noText,
      onYes: onYes,
      onNo: onNo,
    ),
  );
}
