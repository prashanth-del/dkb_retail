import 'package:flutter/material.dart';

class AppCustomAlertDialog {
  static Future dialog({
    required Widget widget,
    required BuildContext context,
    Color? backgroundColor,
    EdgeInsets? paddingDialog,
  }) {
    return showDialog(
      barrierColor: Colors.black.withOpacity(0.4),
      context: context,
      builder: (_) {
        return Dialog(
          elevation: 0.0,
          backgroundColor: Colors.white,
          insetPadding: paddingDialog ?? EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            // 👈 This line adds rounded corners
            borderRadius: BorderRadius.circular(12),
          ),
          child: widget,
        );
      },
    );
  }
}

//
