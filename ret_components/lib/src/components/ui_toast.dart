import 'package:db_uicomponents/styles.dart';
import 'package:db_uicomponents/utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:motion_toast/motion_toast.dart';

enum ToastLevel { error, success, warning, info, delete }

class UiToast {
  // Flutter Toast
  void showToast(dynamic msg, {bool isNotification = false}) {
    Fluttertoast.showToast(
      msg: msg.toString(),
      toastLength: Toast.LENGTH_LONG,
      gravity: isNotification ? ToastGravity.TOP : ToastGravity.SNACKBAR,
      timeInSecForIosWeb: 1,
      backgroundColor: "${msg}" == ""
          ? Colors.transparent
          : isNotification
          ? DefaultColors.red_09
          : DefaultColors.black,
      textColor: DefaultColors.white,
      fontSize: 15.0,
    );
  }

// Bottom Toast
  void showBottomMsg({
    required BuildContext context,
    required String msg,
    Color? textColor,
  }) {
    final size = context.screenSize;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
      builder: (context) {
        return ListTile(
          dense: true,
          minLeadingWidth: 0,
          minVerticalPadding: 18,
          horizontalTitleGap: 5,
          leading: Icon(
            Icons.error,
            color: textColor ?? DefaultColors.red64,
            size: 20,
          ),
          title: Text(
            msg,
            textAlign: TextAlign.center,
            style: context.textTheme.bodyMedium?.copyWith(
              fontSize: size.height * 0.02,
              color: textColor ?? DefaultColors.red64,
            ),
          ),
        );
      },
    );
  }

// Motion Toast
  void showFlagMsg({
    required BuildContext context,
    required String msg,
    ToastLevel level = ToastLevel.info,
  }) {
    late MotionToast toast;
    const toastDuration = Duration(seconds: 2);
    const animationDuration = Duration(seconds: 1);
    const enableAnimation = false;

    switch (level) {
      case ToastLevel.success:
        toast = MotionToast.success(
          height: 40,
          iconSize: 20,
          description: Text(
            msg,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.white),
          ),
          displaySideBar: false,
          borderRadius: 4,
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          enableAnimation: enableAnimation,
          toastDuration: toastDuration,
          animationDuration: animationDuration,
          animationCurve: Curves.easeIn,
        );
        break;
      case ToastLevel.error:
        toast = MotionToast.error(
          displaySideBar: false,
          iconSize: 20,
          borderRadius: 4,
          opacity: 0.8,
          barrierColor: DefaultColors.red_09,
          contentPadding: EdgeInsets.symmetric(horizontal: 5),
          description: Text(
            msg,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: DefaultColors.white),
          ),
          enableAnimation: enableAnimation,
          toastDuration: toastDuration,
          animationDuration: animationDuration,
          animationCurve: Curves.easeIn,
        );
        break;
      case ToastLevel.delete:
        toast = MotionToast.warning(
          description: Text(
            msg,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.white),
          ),
          enableAnimation: enableAnimation,
          toastDuration: toastDuration,
          animationDuration: animationDuration,
          animationCurve: Curves.easeIn,
        );
        break;
      case ToastLevel.warning:
        toast = MotionToast.warning(
          description: Text(
            msg,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.white),
          ),
          enableAnimation: enableAnimation,
          toastDuration: toastDuration,
          animationDuration: animationDuration,
          animationCurve: Curves.easeIn,
        );
        break;
      case ToastLevel.info:
      default:
        toast = MotionToast.info(
          enableAnimation: enableAnimation,
          description: Text(
            msg,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.white),
          ),
          toastDuration: toastDuration,
          animationDuration: animationDuration,
          animationCurve: Curves.easeIn,
        );
    }
    toast.show(context);
  }
}
