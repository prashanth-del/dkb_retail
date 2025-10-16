import 'package:flutter/material.dart';

class CustomSheet<T> extends StatelessWidget {
  CustomSheet._({
    super.key,
    required this.child,
    this.title,
    this.onClose,
    this.backGroundColor,
    this.headerStyle,
    this.isDismissible,
    this.topTitle,
    this.height,
    this.radius,
    this.barrierColor,
    this.widthSheet,
  });

  final Widget child;
  final String? title;
  final Color? backGroundColor;
  final TextStyle? headerStyle;
  final ValueChanged<BuildContext>? onClose;
  final bool? isDismissible;
  final double? topTitle;
  final double? height;
  final double? radius;
  final Color? barrierColor;
  double? widthSheet; // 👈 Add this

  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    String? title,
    bool addHeader = true,
    ValueChanged<BuildContext>? onClose,
    Color? closeButtonColor,
    TextStyle? headerStyle,
    double? topTitle,
    bool isDismissible = true,

    double? heightSheet,
    double? radius,
    double? widthSheet,
    Color? barrierColor,
  }) {
    const isWeb = identical(0, 0.0); // crude but works for now

    if (isWeb) {
      // Custom full-width sheet for web
      return showDialog<T>(
        context: context,
        barrierDismissible: isDismissible,
        barrierColor: barrierColor ?? Colors.black.withOpacity(0.4),
        builder: (_) => GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            if (isDismissible) Navigator.of(context).pop();
          },
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Material(
              color: Colors.transparent,
              child: CustomSheet._(
                title: title,
                onClose: onClose,
                backGroundColor: closeButtonColor,
                headerStyle: headerStyle,
                height: heightSheet,
                widthSheet: widthSheet ?? MediaQuery.of(context).size.width,
                radius: radius ?? 0,
                child: child,
              ),
            ),
          ),
        ),
      );
    } else {
      // Standard modal sheet for mobile/desktop
      return showModalBottomSheet<T>(
        context: context,
        enableDrag: true,
        isDismissible: isDismissible,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        barrierColor: barrierColor ?? Colors.black.withOpacity(0.4),
        transitionAnimationController: AnimationController(
          vsync: Navigator.of(context),
          duration: const Duration(milliseconds: 900), // custom speed
        ),
        builder: (context) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              if (isDismissible) Navigator.of(context).pop();
            },
            child: TweenAnimationBuilder<Offset>(
              duration: const Duration(milliseconds: 900),
              curve: Curves.easeOutCubic,
              tween: Tween(begin: const Offset(0, 1), end: Offset.zero),
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(
                    0,
                    value.dy * MediaQuery.of(context).size.height,
                  ),
                  child: CustomSheet._(
                    title: title,
                    onClose: onClose,
                    backGroundColor: closeButtonColor,
                    headerStyle: headerStyle,
                    height: heightSheet,
                    widthSheet: widthSheet ?? double.infinity,
                    radius: radius ?? 0,
                    child: child!,
                  ),
                );
              },
              child: CustomSheet._(
                title: title,
                onClose: onClose,
                backGroundColor: closeButtonColor,
                headerStyle: headerStyle,
                height: heightSheet,
                widthSheet: widthSheet ?? double.infinity,
                radius: radius ?? 0,
                child: child,
              ),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          width: widthSheet ?? MediaQuery.of(context).size.width,
          height: height,
          decoration: const BoxDecoration(
            boxShadow: [
              // BoxShadow(
              //   color: Colors.black12,
              //   blurRadius: 10,
              //   offset: Offset(0, 1),
              // ),
            ],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            color: Colors.transparent,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }

  Widget? closeWidget() => null;
}
