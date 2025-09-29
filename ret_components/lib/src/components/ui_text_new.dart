import 'package:flutter/material.dart';

/// Usage
/// UiTextNew.h1Regular("Text");
///
/// Theme-first behavior with compatibility:
/// - If a size is passed (custom/customRubik), it overrides theme.
/// - Otherwise we take size from ThemeData.textTheme.
/// - If theme has no size, we fallback to legacy constants used before.

enum Fonts { sfPro, rubik, diodrumArabic }

enum _Role {
  h1,
  h2,
  h3,
  h4,
  h5,
  h6,
  h28, // mapped similar to titleLarge/headlineMedium
  b1,
  b2,
  b3,
  b4,
  b11,
  b14,
  b15,
  b17,
}

class UiTextNew extends StatelessWidget {
  // public fields (kept as-is)
  final String text;
  final Color? color;
  final double? lineHeight;
  final TextAlign? textAlign;
  final double? spacing;
  final TextDecoration? decoration;
  final Color? decorationColor;
  final Fonts? fontFamily;
  final TextOverflow? overflow;
  final int? maxLines;

  // NOTE: in old code this was always set; now it's an *override* (nullable)
  // so theme can drive the default when not provided.
  final double? fontSize;
  final FontWeight fontWeight;

  // internal role + legacy fallback when theme is missing size
  final _Role _role;
  final double _fallbackSize;

  // single generative constructor
  const UiTextNew._internal(
    this.text, {
    required _Role role,
    required double fallbackSize,
    required this.fontWeight,
    this.fontSize, // may be null (means: no override, use theme or fallback)
    this.color,
    this.lineHeight,
    this.textAlign,
    this.maxLines,
    this.decoration,
    this.spacing,
    this.overflow,
    this.decorationColor,
    this.fontFamily,
    super.key,
  })  : _role = role,
        _fallbackSize = fallbackSize;

  // ---------------- H1 ----------------
  const UiTextNew.h1Regular(
    String text, {
    Color? color,
    double? lineHeight,
    TextAlign? textAlign,
    int? maxLines,
    TextDecoration? decoration,
    double? spacing,
    TextOverflow? overflow,
    Color? decorationColor,
    Key? key,
  }) : this._internal(
          text,
          role: _Role.h1,
          fallbackSize: 31, // legacy default
          fontWeight: FontWeight.w400,
          color: color,
          lineHeight: lineHeight,
          textAlign: textAlign,
          maxLines: maxLines,
          decoration: decoration,
          spacing: spacing,
          overflow: overflow,
          decorationColor: decorationColor,
          fontFamily: Fonts.diodrumArabic,
          key: key,
        );

  const UiTextNew.h1Medium(
    String text, {
    Color? color,
    double? lineHeight,
    TextDecoration? decoration,
    int? maxLines,
    Color? decorationColor,
    TextAlign? textAlign,
    TextOverflow? overflow,
    double? spacing,
    Key? key,
  }) : this._internal(
          text,
          role: _Role.h1,
          fallbackSize: 31,
          fontWeight: FontWeight.w500,
          color: color,
          lineHeight: lineHeight,
          textAlign: textAlign,
          maxLines: maxLines,
          decoration: decoration,
          spacing: spacing,
          overflow: overflow,
          decorationColor: decorationColor,
          fontFamily: Fonts.diodrumArabic,
          key: key,
        );

  const UiTextNew.h1Semibold(
    String text, {
    Color? color,
    double? lineHeight,
    int? maxLines,
    TextDecoration? decoration,
    TextOverflow? overflow,
    TextAlign? textAlign,
    Color? decorationColor,
    double? spacing,
    Key? key,
  }) : this._internal(
          text,
          role: _Role.h1,
          fallbackSize: 24,
          fontWeight: FontWeight.w600,
          color: color,
          lineHeight: lineHeight,
          textAlign: textAlign,
          maxLines: maxLines,
          decoration: decoration,
          spacing: spacing,
          overflow: overflow,
          decorationColor: decorationColor,
          fontFamily: Fonts.diodrumArabic,
          key: key,
        );

  const UiTextNew.h1Bold(
    String text, {
    Color? color,
    double? lineHeight,
    Color? decorationColor,
    double? spacing,
    TextDecoration? decoration,
    TextOverflow? overflow,
    int? maxLines,
    TextAlign? textAlign,
    Key? key,
  }) : this._internal(
          text,
          role: _Role.h1,
          fallbackSize: 27,
          fontWeight: FontWeight.w700,
          color: color,
          lineHeight: lineHeight,
          textAlign: textAlign,
          maxLines: maxLines,
          decoration: decoration,
          spacing: spacing,
          overflow: overflow,
          decorationColor: decorationColor,
          fontFamily: Fonts.diodrumArabic,
          key: key,
        );

  // ---------------- H28 ----------------
  const UiTextNew.h28Bold(
    String text, {
    Color? color,
    double? lineHeight,
    int? maxLines,
    TextAlign? textAlign,
    Color? decorationColor,
    TextDecoration? decoration,
    double? spacing,
    TextOverflow? overflow,
    Key? key,
  }) : this._internal(
          text,
          role: _Role.h28,
          fallbackSize: 28,
          fontWeight: FontWeight.w400, // kept as original
          color: color,
          lineHeight: lineHeight,
          textAlign: textAlign,
          maxLines: maxLines,
          decoration: decoration,
          spacing: spacing,
          overflow: overflow,
          decorationColor: decorationColor,
          fontFamily: Fonts.diodrumArabic,
          key: key,
        );

  // ---------------- H2 ----------------
  const UiTextNew.h2Regular(
    String text, {
    Color? color,
    double? lineHeight,
    double? spacing,
    Color? decorationColor,
    TextDecoration? decoration,
    int? maxLines,
    TextOverflow? overflow,
    TextAlign? textAlign,
    Key? key,
  }) : this._internal(
          text,
          role: _Role.h2,
          fallbackSize: 24,
          fontWeight: FontWeight.w400,
          color: color,
          lineHeight: lineHeight,
          textAlign: textAlign,
          maxLines: maxLines,
          decoration: decoration,
          spacing: spacing,
          overflow: overflow,
          decorationColor: decorationColor,
          fontFamily: Fonts.diodrumArabic,
          key: key,
        );

  const UiTextNew.h2Medium(
    String text, {
    Color? color,
    double? lineHeight,
    TextAlign? textAlign,
    Color? decorationColor,
    int? maxLines,
    TextDecoration? decoration,
    double? spacing,
    Key? key,
    TextOverflow? overflow,
  }) : this._internal(
          text,
          role: _Role.h2,
          fallbackSize: 24,
          fontWeight: FontWeight.w500,
          color: color,
          lineHeight: lineHeight,
          textAlign: textAlign,
          maxLines: maxLines,
          decoration: decoration,
          spacing: spacing,
          overflow: overflow,
          decorationColor: decorationColor,
          fontFamily: Fonts.diodrumArabic,
          key: key,
        );

  const UiTextNew.h2Semibold(
    String text, {
    Color? color,
    double? lineHeight,
    Color? decorationColor,
    int? maxLines,
    TextDecoration? decoration,
    double? spacing,
    TextOverflow? overflow,
    TextAlign? textAlign,
    Key? key,
  }) : this._internal(
          text,
          role: _Role.h2,
          fallbackSize: 20,
          fontWeight: FontWeight.w600,
          color: color,
          lineHeight: lineHeight,
          textAlign: textAlign,
          maxLines: maxLines,
          decoration: decoration,
          spacing: spacing,
          overflow: overflow,
          decorationColor: decorationColor,
          fontFamily: Fonts.diodrumArabic,
          key: key,
        );

  const UiTextNew.h2Bold(
    String text, {
    Color? color,
    double? lineHeight,
    Color? decorationColor,
    TextOverflow? overflow,
    TextDecoration? decoration,
    int? maxLines,
    double? spacing,
    TextAlign? textAlign,
    Key? key,
  }) : this._internal(
          text,
          role: _Role.h2,
          fallbackSize: 25,
          fontWeight: FontWeight.w600,
          color: color,
          lineHeight: lineHeight,
          textAlign: textAlign,
          maxLines: maxLines,
          decoration: decoration,
          spacing: spacing,
          overflow: overflow,
          decorationColor: decorationColor,
          fontFamily: Fonts.diodrumArabic,
          key: key,
        );

  // ---------------- H3 ----------------
  const UiTextNew.h3Regular(
    String text, {
    Color? color,
    double? lineHeight,
    Color? decorationColor,
    double? spacing,
    TextOverflow? overflow,
    int? maxLines,
    TextDecoration? decoration,
    TextAlign? textAlign,
    Key? key,
  }) : this._internal(
          text,
          role: _Role.h3,
          fallbackSize: 20,
          fontWeight: FontWeight.w400,
          color: color,
          lineHeight: lineHeight,
          textAlign: textAlign,
          maxLines: maxLines,
          decoration: decoration,
          spacing: spacing,
          overflow: overflow,
          decorationColor: decorationColor,
          fontFamily: Fonts.diodrumArabic,
          key: key,
        );

  const UiTextNew.h3Medium(
    String text, {
    Color? color,
    double? lineHeight,
    Color? decorationColor,
    TextOverflow? overflow,
    int? maxLines,
    double? spacing,
    TextDecoration? decoration,
    TextAlign? textAlign,
    Key? key,
  }) : this._internal(
          text,
          role: _Role.h3,
          fallbackSize: 20,
          fontWeight: FontWeight.w500,
          color: color,
          lineHeight: lineHeight,
          textAlign: textAlign,
          maxLines: maxLines,
          decoration: decoration,
          spacing: spacing,
          overflow: overflow,
          decorationColor: decorationColor,
          fontFamily: Fonts.diodrumArabic,
          key: key,
        );

  const UiTextNew.h3Semibold(
    String text, {
    Color? color,
    double? lineHeight,
    TextDecoration? decoration,
    int? maxLines,
    Color? decorationColor,
    TextAlign? textAlign,
    TextOverflow? overflow,
    double? spacing,
    Key? key,
  }) : this._internal(
          text,
          role: _Role.h3,
          fallbackSize: 16,
          fontWeight: FontWeight.w600,
          color: color,
          lineHeight: lineHeight,
          textAlign: textAlign,
          maxLines: maxLines,
          decoration: decoration,
          spacing: spacing,
          overflow: overflow,
          decorationColor: decorationColor,
          fontFamily: Fonts.diodrumArabic,
          key: key,
        );

  // ---------------- Body 14 ----------------
  const UiTextNew.b14Regular(
    String text, {
    Color? color,
    int? maxLines,
    double? lineHeight,
    TextDecoration? decoration,
    Color? decorationColor,
    TextOverflow? overflow,
    double? spacing,
    TextAlign? textAlign,
    Key? key,
  }) : this._internal(
          text,
          role: _Role.b14,
          fallbackSize: 14,
          fontWeight: FontWeight.w400,
          color: color,
          lineHeight: lineHeight,
          textAlign: textAlign,
          maxLines: maxLines,
          decoration: decoration,
          spacing: spacing,
          overflow: overflow,
          decorationColor: decorationColor,
          fontFamily: Fonts.diodrumArabic,
          key: key,
        );

  const UiTextNew.b14Medium(
    String text, {
    Color? color,
    double? lineHeight,
    Color? decorationColor,
    double? spacing,
    int? maxLines,
    TextOverflow? overflow,
    TextDecoration? decoration,
    TextAlign? textAlign,
    Key? key,
  }) : this._internal(
          text,
          role: _Role.b14,
          fallbackSize: 14,
          fontWeight: FontWeight.w500,
          color: color,
          lineHeight: lineHeight,
          textAlign: textAlign,
          maxLines: maxLines,
          decoration: decoration,
          spacing: spacing,
          overflow: overflow,
          decorationColor: decorationColor,
          fontFamily: Fonts.diodrumArabic,
          key: key,
        );

  const UiTextNew.b14Semibold(
    String text, {
    Color? color,
    double? lineHeight,
    double? spacing,
    int? maxLines,
    TextOverflow? overflow,
    Color? decorationColor,
    TextDecoration? decoration,
    TextAlign? textAlign,
    Key? key,
  }) : this._internal(
          text,
          role: _Role.b14,
          fallbackSize: 14,
          fontWeight: FontWeight.w600,
          color: color,
          lineHeight: lineHeight,
          textAlign: textAlign,
          maxLines: maxLines,
          decoration: decoration,
          spacing: spacing,
          overflow: overflow,
          decorationColor: decorationColor,
          fontFamily: Fonts.diodrumArabic,
          key: key,
        );

  // ---------------- Body 15 ----------------
  const UiTextNew.b15Regular(
    String text, {
    Color? color,
    int? maxLines,
    double? lineHeight,
    TextDecoration? decoration,
    Color? decorationColor,
    TextOverflow? overflow,
    double? spacing,
    TextAlign? textAlign,
    Key? key,
  }) : this._internal(
          text,
          role: _Role.b15,
          fallbackSize: 15,
          fontWeight: FontWeight.w400,
          color: color,
          lineHeight: lineHeight,
          textAlign: textAlign,
          maxLines: maxLines,
          decoration: decoration,
          spacing: spacing,
          overflow: overflow,
          decorationColor: decorationColor,
          fontFamily: Fonts.diodrumArabic,
          key: key,
        );

  const UiTextNew.b15Medium(
    String text, {
    Color? color,
    double? lineHeight,
    Color? decorationColor,
    double? spacing,
    int? maxLines,
    TextOverflow? overflow,
    TextDecoration? decoration,
    TextAlign? textAlign,
    Key? key,
  }) : this._internal(
          text,
          role: _Role.b15,
          fallbackSize: 15,
          fontWeight: FontWeight.w500,
          color: color,
          lineHeight: lineHeight,
          textAlign: textAlign,
          maxLines: maxLines,
          decoration: decoration,
          spacing: spacing,
          overflow: overflow,
          decorationColor: decorationColor,
          fontFamily: Fonts.diodrumArabic,
          key: key,
        );

  const UiTextNew.b15Semibold(
    String text, {
    Color? color,
    double? lineHeight,
    double? spacing,
    int? maxLines,
    TextOverflow? overflow,
    Color? decorationColor,
    TextDecoration? decoration,
    TextAlign? textAlign,
    Key? key,
  }) : this._internal(
          text,
          role: _Role.b15,
          fallbackSize: 14,
          fontWeight: FontWeight.w600,
          color: color,
          lineHeight: lineHeight,
          textAlign: textAlign,
          maxLines: maxLines,
          decoration: decoration,
          spacing: spacing,
          overflow: overflow,
          decorationColor: decorationColor,
          fontFamily: Fonts.diodrumArabic,
          key: key,
        );

  // ---------------- Body 1 (16) ----------------
  const UiTextNew.b1Regular(
    String text, {
    Color? color,
    int? maxLines,
    double? lineHeight,
    TextDecoration? decoration,
    Color? decorationColor,
    TextOverflow? overflow,
    double? spacing,
    TextAlign? textAlign,
    Key? key,
  }) : this._internal(
          text,
          role: _Role.b1,
          fallbackSize: 16,
          fontWeight: FontWeight.w400,
          color: color,
          lineHeight: lineHeight,
          textAlign: textAlign,
          maxLines: maxLines,
          decoration: decoration,
          spacing: spacing,
          overflow: overflow,
          decorationColor: decorationColor,
          fontFamily: Fonts.diodrumArabic,
          key: key,
        );

  const UiTextNew.b1Medium(
    String text, {
    Color? color,
    double? lineHeight,
    Color? decorationColor,
    double? spacing,
    int? maxLines,
    TextOverflow? overflow,
    TextDecoration? decoration,
    TextAlign? textAlign,
    Key? key,
  }) : this._internal(
          text,
          role: _Role.b1,
          fallbackSize: 16,
          fontWeight: FontWeight.w500,
          color: color,
          lineHeight: lineHeight,
          textAlign: textAlign,
          maxLines: maxLines,
          decoration: decoration,
          spacing: spacing,
          overflow: overflow,
          decorationColor: decorationColor,
          fontFamily: Fonts.diodrumArabic,
          key: key,
        );

  const UiTextNew.b1Semibold(
    String text, {
    Color? color,
    double? lineHeight,
    double? spacing,
    int? maxLines,
    TextOverflow? overflow,
    Color? decorationColor,
    TextDecoration? decoration,
    TextAlign? textAlign,
    Key? key,
  }) : this._internal(
          text,
          role: _Role.b1,
          fallbackSize: 16,
          fontWeight: FontWeight.w600,
          color: color,
          lineHeight: lineHeight,
          textAlign: textAlign,
          maxLines: maxLines,
          decoration: decoration,
          spacing: spacing,
          overflow: overflow,
          decorationColor: decorationColor,
          fontFamily: Fonts.diodrumArabic,
          key: key,
        );

  // ---------------- Body 17 ----------------
  const UiTextNew.b17Regular(
    String text, {
    Color? color,
    int? maxLines,
    double? lineHeight,
    double? spacing,
    Color? decorationColor,
    TextOverflow? overflow,
    TextDecoration? decoration,
    TextAlign? textAlign,
    Key? key,
  }) : this._internal(
          text,
          role: _Role.b17,
          fallbackSize: 17,
          fontWeight: FontWeight.w600,
          color: color,
          lineHeight: lineHeight,
          textAlign: textAlign,
          maxLines: maxLines,
          decoration: decoration,
          spacing: spacing,
          overflow: overflow,
          decorationColor: decorationColor,
          fontFamily: Fonts.diodrumArabic,
          key: key,
        );

  // ---------------- Body 2 (13) ----------------
  const UiTextNew.b2Regular(
    String text, {
    Color? color,
    TextDecoration? decoration,
    Color? decorationColor,
    double? spacing,
    TextOverflow? overflow,
    double? lineHeight,
    int? maxLines,
    TextAlign? textAlign,
    Key? key,
  }) : this._internal(
          text,
          role: _Role.b2,
          fallbackSize: 13,
          fontWeight: FontWeight.w400,
          color: color,
          lineHeight: lineHeight,
          textAlign: textAlign,
          maxLines: maxLines,
          decoration: decoration,
          spacing: spacing,
          overflow: overflow,
          decorationColor: decorationColor,
          fontFamily: Fonts.diodrumArabic,
          key: key,
        );

  const UiTextNew.b2Medium(
    String text, {
    Color? color,
    TextDecoration? decoration,
    double? lineHeight,
    Color? decorationColor,
    double? spacing,
    int? maxLines,
    TextOverflow? overflow,
    TextAlign? textAlign,
    Key? key,
  }) : this._internal(
          text,
          role: _Role.b2,
          fallbackSize: 13,
          fontWeight: FontWeight.w500,
          color: color,
          lineHeight: lineHeight,
          textAlign: textAlign,
          maxLines: maxLines,
          decoration: decoration,
          spacing: spacing,
          overflow: overflow,
          decorationColor: decorationColor,
          fontFamily: Fonts.diodrumArabic,
          key: key,
        );

  const UiTextNew.b2Semibold(
    String text, {
    Color? color,
    double? lineHeight,
    double? spacing,
    TextDecoration? decoration,
    Color? decorationColor,
    int? maxLines,
    TextOverflow? overflow,
    TextAlign? textAlign,
    Key? key,
  }) : this._internal(
          text,
          role: _Role.b2,
          fallbackSize: 13,
          fontWeight: FontWeight.w600,
          color: color,
          lineHeight: lineHeight,
          textAlign: textAlign,
          maxLines: maxLines,
          decoration: decoration,
          spacing: spacing,
          overflow: overflow,
          decorationColor: decorationColor,
          fontFamily: Fonts.diodrumArabic,
          key: key,
        );

  // ---------------- Body 3 (10) ----------------
  const UiTextNew.b3Light(
    String text, {
    Color? color,
    double? lineHeight,
    int? maxLines,
    TextDecoration? decoration,
    double? spacing,
    Color? decorationColor,
    TextAlign? textAlign,
    Key? key,
    TextOverflow? overflow,
  }) : this._internal(
          text,
          role: _Role.b3,
          fallbackSize: 10,
          fontWeight: FontWeight.w300,
          color: color,
          lineHeight: lineHeight,
          textAlign: textAlign,
          maxLines: maxLines,
          decoration: decoration,
          spacing: spacing,
          overflow: overflow,
          decorationColor: decorationColor,
          fontFamily: Fonts.diodrumArabic,
          key: key,
        );

  const UiTextNew.b3Regular(
    String text, {
    Color? color,
    double? lineHeight,
    TextDecoration? decoration,
    Color? decorationColor,
    double? spacing,
    int? maxLines,
    TextOverflow? overflow,
    TextAlign? textAlign,
    Key? key,
  }) : this._internal(
          text,
          role: _Role.b3,
          fallbackSize: 10,
          fontWeight: FontWeight.w400,
          color: color,
          lineHeight: lineHeight,
          textAlign: textAlign,
          maxLines: maxLines,
          decoration: decoration,
          spacing: spacing,
          overflow: overflow,
          decorationColor: decorationColor,
          fontFamily: Fonts.diodrumArabic,
          key: key,
        );

  const UiTextNew.b3Medium(
    String text, {
    Color? color,
    TextDecoration? decoration,
    Color? decorationColor,
    double? lineHeight,
    TextOverflow? overflow,
    double? spacing,
    int? maxLines,
    TextAlign? textAlign,
    Key? key,
  }) : this._internal(
          text,
          role: _Role.b3,
          fallbackSize: 10,
          fontWeight: FontWeight.w500,
          color: color,
          lineHeight: lineHeight,
          textAlign: textAlign,
          maxLines: maxLines,
          decoration: decoration,
          spacing: spacing,
          overflow: overflow,
          decorationColor: decorationColor,
          fontFamily: Fonts.diodrumArabic,
          key: key,
        );

  const UiTextNew.b3Semibold(
    String text, {
    Color? color,
    double? lineHeight,
    int? maxLines,
    double? spacing,
    TextDecoration? decoration,
    Color? decorationColor,
    TextAlign? textAlign,
    TextOverflow? overflow,
    Key? key,
  }) : this._internal(
          text,
          role: _Role.b3,
          fallbackSize: 10,
          fontWeight: FontWeight.w600,
          color: color,
          lineHeight: lineHeight,
          textAlign: textAlign,
          maxLines: maxLines,
          decoration: decoration,
          spacing: spacing,
          overflow: overflow,
          decorationColor: decorationColor,
          fontFamily: Fonts.diodrumArabic,
          key: key,
        );

  const UiTextNew.b3Bold(
    String text, {
    Color? color,
    int? maxLines,
    double? spacing,
    TextDecoration? decoration,
    Color? decorationColor,
    double? lineHeight,
    TextOverflow? overflow,
    TextAlign? textAlign,
    Key? key,
  }) : this._internal(
          text,
          role: _Role.b3,
          fallbackSize: 10,
          fontWeight: FontWeight.w700,
          color: color,
          lineHeight: lineHeight,
          textAlign: textAlign,
          maxLines: maxLines,
          decoration: decoration,
          spacing: spacing,
          overflow: overflow,
          decorationColor: decorationColor,
          fontFamily: Fonts.diodrumArabic,
          key: key,
        );

  // ---------------- Body 4 (8) ----------------
  const UiTextNew.b4Light(
    String text, {
    Color? color,
    double? lineHeight,
    int? maxLines,
    TextDecoration? decoration,
    Color? decorationColor,
    double? spacing,
    TextOverflow? overflow,
    TextAlign? textAlign,
    Key? key,
  }) : this._internal(
          text,
          role: _Role.b4,
          fallbackSize: 8,
          fontWeight: FontWeight.w300,
          color: color,
          lineHeight: lineHeight,
          textAlign: textAlign,
          maxLines: maxLines,
          decoration: decoration,
          spacing: spacing,
          overflow: overflow,
          decorationColor: decorationColor,
          fontFamily: Fonts.diodrumArabic,
          key: key,
        );

  const UiTextNew.b4Regular(
    String text, {
    Color? color,
    double? spacing,
    double? lineHeight,
    int? maxLines,
    TextOverflow? overflow,
    TextDecoration? decoration,
    Color? decorationColor,
    TextAlign? textAlign,
    Key? key,
  }) : this._internal(
          text,
          role: _Role.b4,
          fallbackSize: 8,
          fontWeight: FontWeight.w400,
          color: color,
          lineHeight: lineHeight,
          textAlign: textAlign,
          maxLines: maxLines,
          decoration: decoration,
          spacing: spacing,
          overflow: overflow,
          decorationColor: decorationColor,
          fontFamily: Fonts.diodrumArabic,
          key: key,
        );

  const UiTextNew.b4Medium(
    String text, {
    Color? color,
    double? spacing,
    int? maxLines,
    TextAlign? textAlign,
    TextDecoration? decoration,
    TextOverflow? overflow,
    Color? decorationColor,
    double? lineHeight,
    Key? key,
  }) : this._internal(
          text,
          role: _Role.b4,
          fallbackSize: 8,
          fontWeight: FontWeight.w500,
          color: color,
          lineHeight: lineHeight,
          textAlign: textAlign,
          maxLines: maxLines,
          decoration: decoration,
          spacing: spacing,
          overflow: overflow,
          decorationColor: decorationColor,
          fontFamily: Fonts.diodrumArabic,
          key: key,
        );

  const UiTextNew.b4Semibold(
    String text, {
    Color? color,
    double? lineHeight,
    int? maxLines,
    TextDecoration? decoration,
    Color? decorationColor,
    double? spacing,
    TextOverflow? overflow,
    TextAlign? textAlign,
    Key? key,
  }) : this._internal(
          text,
          role: _Role.b4,
          fallbackSize: 8,
          fontWeight: FontWeight.w600,
          color: color,
          lineHeight: lineHeight,
          textAlign: textAlign,
          maxLines: maxLines,
          decoration: decoration,
          spacing: spacing,
          overflow: overflow,
          decorationColor: decorationColor,
          fontFamily: Fonts.diodrumArabic,
          key: key,
        );

  const UiTextNew.b4Bold(
    String text, {
    Color? color,
    int? maxLines,
    double? lineHeight,
    TextDecoration? decoration,
    Color? decorationColor,
    double? spacing,
    TextOverflow? overflow,
    TextAlign? textAlign,
    Key? key,
  }) : this._internal(
          text,
          role: _Role.b4,
          fallbackSize: 8,
          fontWeight: FontWeight.w700,
          color: color,
          lineHeight: lineHeight,
          textAlign: textAlign,
          maxLines: maxLines,
          decoration: decoration,
          spacing: spacing,
          overflow: overflow,
          decorationColor: decorationColor,
          fontFamily: Fonts.diodrumArabic,
          key: key,
        );

  // ---------------- retail extras ----------------
  const UiTextNew.h4Regular(
    String text, {
    Color? color,
    double? lineHeight,
    Color? decorationColor,
    double? spacing,
    TextOverflow? overflow,
    int? maxLines,
    TextDecoration? decoration,
    TextAlign? textAlign,
    Key? key,
  }) : this._internal(
          text,
          role: _Role.h4,
          fallbackSize: 14,
          fontWeight: FontWeight.w400,
          color: color,
          lineHeight: lineHeight,
          textAlign: textAlign,
          maxLines: maxLines,
          decoration: decoration,
          spacing: spacing,
          overflow: overflow,
          decorationColor: decorationColor,
          fontFamily: Fonts.diodrumArabic,
          key: key,
        );

  const UiTextNew.h4Medium(
    String text, {
    Color? color,
    double? lineHeight,
    Color? decorationColor,
    double? spacing,
    TextOverflow? overflow,
    int? maxLines,
    TextDecoration? decoration,
    TextAlign? textAlign,
    Key? key,
  }) : this._internal(
          text,
          role: _Role.h4,
          fallbackSize: 14,
          fontWeight: FontWeight.w500,
          color: color,
          lineHeight: lineHeight,
          textAlign: textAlign,
          maxLines: maxLines,
          decoration: decoration,
          spacing: spacing,
          overflow: overflow,
          decorationColor: decorationColor,
          fontFamily: Fonts.diodrumArabic,
          key: key,
        );

  const UiTextNew.h5Regular(
    String text, {
    Color? color,
    double? lineHeight,
    Color? decorationColor,
    double? spacing,
    TextOverflow? overflow,
    int? maxLines,
    TextDecoration? decoration,
    TextAlign? textAlign,
    Key? key,
  }) : this._internal(
          text,
          role: _Role.h5,
          fallbackSize: 12,
          fontWeight: FontWeight.w400,
          color: color,
          lineHeight: lineHeight,
          textAlign: textAlign,
          maxLines: maxLines,
          decoration: decoration,
          spacing: spacing,
          overflow: overflow,
          decorationColor: decorationColor,
          fontFamily: Fonts.diodrumArabic,
          key: key,
        );

  const UiTextNew.h5Medium(
    String text, {
    Color? color,
    double? lineHeight,
    Color? decorationColor,
    double? spacing,
    TextOverflow? overflow,
    int? maxLines,
    TextDecoration? decoration,
    TextAlign? textAlign,
    Key? key,
  }) : this._internal(
          text,
          role: _Role.h5,
          fallbackSize: 12,
          fontWeight: FontWeight.w500,
          color: color,
          lineHeight: lineHeight,
          textAlign: textAlign,
          maxLines: maxLines,
          decoration: decoration,
          spacing: spacing,
          overflow: overflow,
          decorationColor: decorationColor,
          fontFamily: Fonts.diodrumArabic,
          key: key,
        );

  const UiTextNew.h6Semibold(
    String text, {
    Color? color,
    double? lineHeight,
    Color? decorationColor,
    double? spacing,
    TextOverflow? overflow,
    int? maxLines,
    TextDecoration? decoration,
    TextAlign? textAlign,
    Key? key,
  }) : this._internal(
          text,
          role: _Role.h6,
          fallbackSize: 18,
          fontWeight: FontWeight.w500,
          color: color,
          lineHeight: lineHeight,
          textAlign: textAlign,
          maxLines: maxLines,
          decoration: decoration,
          spacing: spacing,
          overflow: overflow,
          decorationColor: decorationColor,
          fontFamily: Fonts.diodrumArabic,
          key: key,
        );

  const UiTextNew.b11Regular(
    String text, {
    Color? color,
    int? maxLines,
    double? lineHeight,
    TextDecoration? decoration,
    Color? decorationColor,
    TextOverflow? overflow,
    double? spacing,
    TextAlign? textAlign,
    Key? key,
  }) : this._internal(
          text,
          role: _Role.b11,
          fallbackSize: 11,
          fontWeight: FontWeight.w500,
          color: color,
          lineHeight: lineHeight,
          textAlign: textAlign,
          maxLines: maxLines,
          decoration: decoration,
          spacing: spacing,
          overflow: overflow,
          decorationColor: decorationColor,
          fontFamily: Fonts.diodrumArabic,
          key: key,
        );

  const UiTextNew.b11Regular2(
    String text, {
    Color? color,
    int? maxLines,
    double? lineHeight,
    TextDecoration? decoration,
    Color? decorationColor,
    TextOverflow? overflow,
    double? spacing,
    TextAlign? textAlign,
    Key? key,
  }) : this._internal(
          text,
          role: _Role.b11,
          fallbackSize: 11,
          fontWeight: FontWeight.w400,
          color: color,
          lineHeight: lineHeight,
          textAlign: textAlign,
          maxLines: maxLines,
          decoration: decoration,
          spacing: spacing,
          overflow: overflow,
          decorationColor: decorationColor,
          fontFamily: Fonts.diodrumArabic,
          key: key,
        );

  const UiTextNew.h6Semiboldnew(
    String text, {
    Color? color,
    double? lineHeight,
    Color? decorationColor,
    double? spacing,
    TextOverflow? overflow,
    int? maxLines,
    TextDecoration? decoration,
    TextAlign? textAlign,
    Key? key,
  }) : this._internal(
          text,
          role: _Role.h6,
          fallbackSize: 18,
          fontWeight: FontWeight.w600,
          color: color,
          lineHeight: lineHeight,
          textAlign: textAlign,
          maxLines: maxLines,
          decoration: decoration,
          spacing: spacing,
          overflow: overflow,
          decorationColor: decorationColor,
          fontFamily: Fonts.diodrumArabic,
          key: key,
        );

  const UiTextNew.h5RegularNew(
    String text, {
    Color? color,
    double? lineHeight,
    Color? decorationColor,
    double? spacing,
    TextOverflow? overflow,
    int? maxLines,
    TextDecoration? decoration,
    TextAlign? textAlign,
    Key? key,
  }) : this._internal(
          text,
          role: _Role.h5,
          fallbackSize: 12,
          fontWeight: FontWeight.w500,
          color: color,
          lineHeight: lineHeight,
          textAlign: textAlign,
          maxLines: maxLines,
          decoration: decoration,
          spacing: spacing,
          overflow: overflow,
          decorationColor: decorationColor,
          fontFamily: Fonts.diodrumArabic,
          key: key,
        );

  const UiTextNew.b14Mediumnew(
    String text, {
    Color? color,
    double? lineHeight,
    Color? decorationColor,
    double? spacing,
    int? maxLines,
    TextOverflow? overflow,
    TextDecoration? decoration,
    TextAlign? textAlign,
    Key? key,
  }) : this._internal(
          text,
          role: _Role.b14,
          fallbackSize: 14,
          fontWeight: FontWeight.w500,
          color: color,
          lineHeight: lineHeight,
          textAlign: textAlign,
          maxLines: maxLines,
          decoration: decoration,
          spacing: spacing,
          overflow: overflow,
          decorationColor: decorationColor,
          fontFamily: Fonts.diodrumArabic,
          key: key,
        );

  // ---------------- custom & customRubik (size override kept) ----------------
  const UiTextNew.custom(
    String text, {
    int? maxLines,
    Color? color,
    double? lineHeight,
    TextAlign? textAlign,
    Color? decorationColor,
    TextOverflow? overflow,
    double fontSize = 23, // override if provided
    TextDecoration? decoration,
    double? spacing,
    FontWeight fontWeight = FontWeight.w500,
    Fonts? fontFamily,
    Key? key,
  }) : this._internal(
          text,
          role: _Role.b1,
          fallbackSize: 23, // legacy default if theme missing
          fontWeight: fontWeight,
          fontSize: fontSize, // treat as OVERRIDE
          color: color,
          lineHeight: lineHeight,
          textAlign: textAlign,
          maxLines: maxLines,
          decoration: decoration,
          spacing: spacing,
          overflow: overflow,
          decorationColor: decorationColor,
          fontFamily: fontFamily,
          key: key,
        );

  const UiTextNew.customRubik(
    String text, {
    int? maxLines,
    Color? color,
    double? lineHeight,
    TextAlign? textAlign,
    Color? decorationColor,
    TextOverflow? overflow,
    double fontSize = 23, // override if provided
    TextDecoration? decoration,
    double? spacing,
    FontWeight fontWeight = FontWeight.w500,
    Fonts fontFamily = Fonts.diodrumArabic,
    Key? key,
  }) : this._internal(
          text,
          role: _Role.b1,
          fallbackSize: 23,
          fontWeight: fontWeight,
          fontSize: fontSize, // treat as OVERRIDE
          color: color,
          lineHeight: lineHeight,
          textAlign: textAlign,
          maxLines: maxLines,
          decoration: decoration,
          spacing: spacing,
          overflow: overflow,
          decorationColor: decorationColor,
          fontFamily: fontFamily,
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: getTextStyle(context),
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    );
  }

  /// Theme-first strategy w/ backward fallback.
  TextStyle getTextStyle(BuildContext context) {
    final theme = Theme.of(context);
    final tt = theme.textTheme;
    final cs = theme.colorScheme;

    final TextStyle base = switch (_role) {
      _Role.h1 => tt.headlineLarge ?? const TextStyle(),
      _Role.h2 => tt.headlineMedium ?? const TextStyle(),
      _Role.h3 => tt.headlineSmall ?? const TextStyle(),
      _Role.h4 => tt.titleLarge ?? const TextStyle(),
      _Role.h5 => tt.titleMedium ?? const TextStyle(),
      _Role.h6 => tt.titleSmall ?? const TextStyle(),
      _Role.h28 => tt.titleLarge ?? (tt.headlineMedium ?? const TextStyle()),
      _Role.b1 => tt.bodyLarge ?? const TextStyle(),
      _Role.b2 => tt.bodyMedium ?? const TextStyle(),
      _Role.b3 => tt.bodySmall ?? const TextStyle(),
      _Role.b4 => tt.labelSmall ?? (tt.bodySmall ?? const TextStyle()),
      _Role.b11 => tt.labelSmall ?? (tt.bodySmall ?? const TextStyle()),
      _Role.b14 => tt.labelLarge ?? (tt.bodyMedium ?? const TextStyle()),
      _Role.b15 => tt.labelLarge ?? (tt.bodyMedium ?? const TextStyle()),
      _Role.b17 => tt.titleSmall ?? (tt.bodyLarge ?? const TextStyle()),
    };

    final resolvedColor = color ?? base.color ?? cs.onSurface;

    // IMPORTANT: size precedence
    // 1) explicit constructor override (fontSize, only in custom/customRubik)
    // 2) theme's TextTheme (base.fontSize)
    // 3) legacy fallback constant (keeps old look if theme not set)
    final double effectiveSize = fontSize ?? base.fontSize ?? _fallbackSize;

    return base.copyWith(
      fontSize: effectiveSize,
      fontWeight: fontWeight,
      color: resolvedColor,
      height: lineHeight,
      letterSpacing: spacing,
      decoration: decoration,
      decorationColor: decorationColor ?? resolvedColor,
      fontFamily: fontFamily == null ? base.fontFamily : _mapFont(fontFamily!),
      overflow: overflow,
    );
  }

  String _mapFont(Fonts family) => switch (family) {
        Fonts.sfPro => 'sfPro',
        Fonts.rubik => 'rubik',
        Fonts.diodrumArabic => 'DiodrumArabic',
      };
}
