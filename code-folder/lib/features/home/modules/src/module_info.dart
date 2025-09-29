import 'package:auto_route/auto_route.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'module_info.freezed.dart';

@freezed
class ModuleInfo with _$ModuleInfo {
  const factory ModuleInfo({
    required String id,
    required String activeIcon,
    required String fallbackLabel,
    required String i18nKey,
    required PageRouteInfo<void> route,
    Function()? onSelected,
  }) = _ModuleInfo;
}