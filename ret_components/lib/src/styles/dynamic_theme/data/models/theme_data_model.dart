import 'package:freezed_annotation/freezed_annotation.dart';

import 'color_scheme.dart';

part 'theme_data_model.freezed.dart';
part 'theme_data_model.g.dart';

@freezed
class ThemeDataModel with _$ThemeDataModel {
  const factory ThemeDataModel({
    required String fontFamilyHead,
    required String fontFamilyBody,
    required String fontFamilyBody1,
    required String titleColor,
    required String hintColor,
    required String subtitleColor,
    required String appBarBackground,
    required String appBarIcon,
    required String appBarTitle,
    required String labelColor,
    required String buttonBackground,
    required String buttonForeground,
    required String scaffoldBackground,
    required String backgroundColor,
    required String borderSide,
    required String focusedBorderColor,
    required String errorBorderColor,
    required String? radioOverlayColor,
    required String? radioFillColor,
    required String shadowColor,
    required String floatingActionButtonBackground,
    required String floatingActionButtonForeground,
    required String bottomNavigationBackground,
    required String inputFillColor,
    required double horizontalButtonPadding,
    required double verticalButtonPadding,
    required double textFieldCurve,
    required String textFieldType,
    required ColorSchemeModel colorScheme,
  }) = _ThemeDataModel;

  factory ThemeDataModel.fromJson(Map<String, dynamic> json) =>
      _$ThemeDataModelFromJson(json);
}