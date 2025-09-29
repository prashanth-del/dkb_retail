import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dash_module_info.freezed.dart';

@freezed
class DashModuleInfo with _$DashModuleInfo {
  const factory DashModuleInfo({
    required String id,
    required String fallbackLabel,
    required String i18nKey,
    required Widget route,
    Function()? onSelected,
  }) = _DashModuleInfo;
}