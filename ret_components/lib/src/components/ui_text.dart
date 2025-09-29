import 'package:db_uicomponents/src/styles/theme/colorscheme/colors/default_colors.dart';
import 'package:db_uicomponents/utils.dart';
import 'package:flutter/material.dart';

enum UITextType {
  bodySmall,
  bodyMedium,
  bodyLarge,
  title,
  subtitle,
  headline,
  labelLarge,
  labelMedium,
  labelSmall,
  display
}

@Deprecated('Use UiTextNew instead')
class UIText extends StatelessWidget {
  final String text;
  final UITextType type;
  final double? size;
  final Color? color;
  final FontStyle? fontStyle;
  final double? letterSpacing;
  final double? wordSpacing;
  final TextBaseline? textBaseline;
  final double? height;
  final TextAlign? textAlign;
  final TextDecoration? decoration;

  const UIText.bodySmall(
    this.text, {
    super.key,
    this.size = 10,
    this.color,
    this.fontStyle,
    this.textAlign,
    this.letterSpacing,
    this.wordSpacing,
    this.textBaseline,
    this.decoration,
    this.height,
  }) : type = UITextType.bodySmall;

  const UIText.bodyMedium(
    this.text, {
    super.key,
    this.size = 14,
    this.color,
    this.fontStyle,
    this.textAlign,
    this.letterSpacing,
    this.wordSpacing,
    this.decoration,
    this.textBaseline,
    this.height,
  }) : type = UITextType.bodyMedium;

  const UIText.bodyLarge(
    this.text, {
    super.key,
    this.size = 16,
    this.color,
    this.fontStyle,
    this.textAlign,
    this.letterSpacing,
    this.decoration,
    this.wordSpacing,
    this.textBaseline,
    this.height,
  }) : type = UITextType.bodyLarge;

  const UIText.title(
    this.text, {
    super.key,
    this.size = 20,
    this.color,
    this.fontStyle,
    this.textAlign,
    this.decoration,
    this.letterSpacing,
    this.wordSpacing,
    this.textBaseline,
    this.height,
  }) : type = UITextType.title;

  const UIText.subtitle(
    this.text, {
    super.key,
    this.size = 18,
    this.color,
    this.fontStyle,
    this.textAlign,
    this.letterSpacing,
    this.decoration,
    this.wordSpacing,
    this.textBaseline,
    this.height,
  }) : type = UITextType.subtitle;

  const UIText.headline(
    this.text, {
    super.key,
    this.size = 24,
    this.color,
    this.decoration,
    this.fontStyle,
    this.textAlign,
    this.letterSpacing,
    this.wordSpacing,
    this.textBaseline,
    this.height,
  }) : type = UITextType.headline;

  const UIText.labelLarge(
    this.text, {
    super.key,
    this.size = 22,
    this.color,
    this.fontStyle,
    this.textAlign,
    this.letterSpacing,
    this.decoration,
    this.wordSpacing,
    this.textBaseline,
    this.height,
  }) : type = UITextType.labelLarge;

  const UIText.labelMedium(
    this.text, {
    super.key,
    this.size = 18,
    this.color,
    this.fontStyle,
    this.textAlign,
    this.decoration,
    this.letterSpacing,
    this.wordSpacing,
    this.textBaseline,
    this.height,
  }) : type = UITextType.labelMedium;

  const UIText.labelSmall(
    this.text, {
    super.key,
    this.size = 10,
    this.color = DefaultColors.gray2D,
    this.fontStyle,
    this.textAlign,
    this.letterSpacing,
    this.decoration,
    this.wordSpacing,
    this.textBaseline,
    this.height,
  }) : type = UITextType.labelSmall;

  @override
  Widget build(BuildContext context) {
    final themeX = context.themeX;

    final textTheme = context.textTheme.apply(
      bodyColor: themeX.defaultTextColor,
      displayColor: themeX.defaultTextColor,
    );

    final TextStyle baseStyle = switch (type) {
      UITextType.bodySmall => textTheme.bodySmall!,
      UITextType.bodyMedium => textTheme.bodyMedium!,
      UITextType.bodyLarge => textTheme.bodyLarge!,
      UITextType.title => textTheme.titleLarge!,
      UITextType.subtitle => textTheme.titleMedium!,
      UITextType.headline => textTheme.headlineMedium!,
      UITextType.labelLarge => textTheme.labelLarge!,
      UITextType.labelMedium => textTheme.labelMedium!,
      UITextType.labelSmall => textTheme.labelSmall!,
      UITextType.display => textTheme.displaySmall!,
    };

    final TextStyle style = baseStyle.copyWith(
      fontSize: size,
      fontWeight: switch (type) {
        UITextType.bodySmall => FontWeight.normal,
        UITextType.bodyMedium => FontWeight.w400,
        UITextType.bodyLarge => FontWeight.w500,
        UITextType.title => FontWeight.w600,
        UITextType.subtitle => FontWeight.w600,
        UITextType.headline => FontWeight.w600,
        UITextType.labelLarge => FontWeight.w600,
        UITextType.labelMedium => FontWeight.w500,
        UITextType.labelSmall => FontWeight.w500,
        UITextType.display => FontWeight.w600,
      },
      color: color ?? DefaultColors.black,
      fontStyle: fontStyle,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      textBaseline: textBaseline,
      height: height,
      decoration: decoration,
      decorationColor: color,
    );

    return Text(
      text,
      textAlign: textAlign,
      style: style,
    );
  }
}
