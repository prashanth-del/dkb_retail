import 'package:db_uicomponents/styles.dart';
import 'package:flutter/material.dart';

class UiTextStyles {
  const UiTextStyles._();

  static TextStyle? uiTitleMediumStyle(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: 24,
            height: 1.2,
            fontWeight: FontWeight.w600,
            color: DefaultColors.white,
          );

  static TextStyle? uiTitleStyle(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: DefaultColors.black15,
          );

  static TextStyle? uiCardsTitleStyle(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: DefaultColors.blue_900,
          );

  static TextStyle? uiCardsViewAllStyle(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: DefaultColors.white_700,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            decorationStyle: TextDecorationStyle.solid,
            decoration: TextDecoration.underline,
          );

  static TextStyle? uiInfoHeadingBold(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: DefaultColors.blue_900,
          );

  static TextStyle? uiInfoTitleBold(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: DefaultColors.white_900,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          );

  static TextStyle? uiInfoTitle(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: DefaultColors.white_900,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          );

  static TextStyle? uiInfoTitleSmallBold(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: DefaultColors.white_600,
        fontSize: 13,
        fontWeight: FontWeight.w600,
      );

  static TextStyle? uiInfoTitleSmall(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: DefaultColors.white_600,
            fontSize: 13,
            fontWeight: FontWeight.w400,
          );

  static TextStyle? uiInfoSubTitleLarge(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: DefaultColors.white_600,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          );

  static TextStyle? uiInfoSubTitle(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: DefaultColors.white_600,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          );

  static TextStyle? uiInfoLarge(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: DefaultColors.white_900,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          );

  static TextStyle? uiInfoMediumLarge(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: DefaultColors.white_900,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          );

  static TextStyle? uiInfoMedium(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: DefaultColors.white_900,
            fontSize: 10,
            fontWeight: FontWeight.w500,
          );
}
