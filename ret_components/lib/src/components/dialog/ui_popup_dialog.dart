import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'src/ui_popup.dart';
import 'ui_popup_view_model.dart';

class UIPopupDialog<T> {
  Future<T?> showPopup({required UIPopupViewModel viewModel}) {
    Widget popup = BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: UIPopup(
        title: viewModel.title,
        titleStyle: viewModel.titleStyle,
        content: viewModel.content,
        contentStyle: viewModel.contentStyle,
        contentWidget: viewModel.contentWidget,
        image: viewModel.image,
        imageSize: viewModel.imageSize,
        dismissAfter: viewModel.dismissAfter,
        buttonText: viewModel.buttonText,
        onButtonPressed: viewModel.onButtonPressed,
        closeIcon: viewModel.closeIcon,
        onClosePressed: viewModel.onClosePressed,
        showButton: viewModel.showButton,
        textAlign: viewModel.textAlign,
      ),
    );

    if (Platform.isIOS) {
      return showCupertinoDialog<T>(
        context: viewModel.context,
        builder: (BuildContext context) => popup,
      );
    } else {
      return showDialog<T>(
        context: viewModel.context,
        barrierColor: Colors.black.withOpacity(0.6),
        barrierDismissible: viewModel.barrierDismissible,
        builder: (BuildContext context) => popup,
      );
    }
  }

  // bottom sheet
  Future<T?> showBottomSheet(
      {required BuildContext context,
      required Widget child,
      double? minHeight,
      double? maxHeight,
      bool isDismissible = true,
      Color? barrierColor}) async {
    final value = await showModalBottomSheet(
        barrierColor: barrierColor,
        isDismissible: isDismissible,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        // showDragHandle: true,
        constraints: BoxConstraints(
          minHeight: minHeight ??
              MediaQuery.of(context).size.height *
                  0.3,
          maxHeight: (maxHeight ?? MediaQuery.of(context).size.height *
              0.7) -
              MediaQuery.of(context).viewInsets.bottom,),
        isScrollControlled: true,
        context: context,
      builder: (context) {
        final viewInsets = MediaQuery.of(context).viewInsets;
        final viewPadding = MediaQuery.of(context).viewPadding;
        return Padding(
          padding: EdgeInsets.only(
            bottom: viewInsets.bottom + viewPadding.bottom,
          ),
          child: child,
        );
      });
    return value;
  }
}
