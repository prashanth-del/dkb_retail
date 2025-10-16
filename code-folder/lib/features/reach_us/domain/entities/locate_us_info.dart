import 'package:freezed_annotation/freezed_annotation.dart';

import './locate_us_info_branche.dart';

part 'locate_us_info.freezed.dart';

@freezed
class LocateUsInfo with _$LocateUsInfo {
  const factory LocateUsInfo({
    required List<LocateUsInfoBranche> branches,
    required List<LocateUsInfoBranche> atms,
    required List<LocateUsInfoBranche> kiosks,
  }) = _LocateUsInfo;
}
