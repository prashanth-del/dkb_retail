import 'package:db_uicomponents/src/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';

import '../../utils.dart';
import '../styles/theme/colorscheme/colors/default_colors.dart';

class UIOutlineButton extends StatelessWidget {
  final Function()? onPressed;
  final Widget? child;
  final String? text;
  final Size? size;
  final EdgeInsets? padding;
  final bool loading;
  final Color? background;
  final Color? foreground;
  final Widget? icon;
  final TextStyle? textStyle;

  const UIOutlineButton(
      {Key? key,
      this.onPressed,
      this.child,
      this.text,
      this.size,
      this.padding,
      this.loading = false,
      this.background,
      this.icon,
      this.textStyle,
      this.foreground})
      : assert(child != null || text != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: loading ? null : onPressed,
        style: ElevatedButton.styleFrom(
            elevation: 0.0,
            padding: padding,
            backgroundColor: background ?? DefaultColors.white,
            fixedSize: size,
            shape: RoundedRectangleBorder(
                side: const BorderSide(color: DefaultColors.grayE5),
                borderRadius: BorderRadius.circular(8))),
        child: loading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: Center(
                  child: CircularProgressIndicator.adaptive(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    strokeWidth: 2,
                  ),
                ),
              )
            : child ??
                (icon != null
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          icon!,
                          const SizedBox(width: 8),
                          Flexible(
                            child: FittedBox(
                              child: Text(
                                text!.toUpperCase(),
                                style: textStyle != null
                                    ? context.textTheme.bodyLarge
                                        ?.merge(textStyle)
                                    : null,
                              ),
                            ),
                          ),
                          const SizedBox(width: 4)
                        ],
                      )
                    : Text(
                        text!.toUpperCase(),
                        style: textStyle != null
                            ? context.textTheme.bodyLarge?.merge(textStyle)
                            : null,
                      )));
  }
}
