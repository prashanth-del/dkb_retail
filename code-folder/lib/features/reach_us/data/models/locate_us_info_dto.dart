import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/locate_us_info.dart';
import './locate_us_info_branche_dto.dart';

part 'locate_us_info_dto.freezed.dart';
part 'locate_us_info_dto.g.dart';

@freezed
class LocateUsInfoDto with _$LocateUsInfoDto {
  const factory LocateUsInfoDto({
    List<LocateUsInfoBrancheDto>? branches,
    List<LocateUsInfoBrancheDto>? atms,
    List<LocateUsInfoBrancheDto>? kiosks,
  }) = _LocateUsInfoDto;

  factory LocateUsInfoDto.fromJson(Map<String, dynamic> json) =>
      _$LocateUsInfoDtoFromJson(json);
}

extension LocateUsInfoDtoX on LocateUsInfoDto {
  LocateUsInfo toEntity() => LocateUsInfo(
    branches: branches?.map((e) => e.toEntity()).toList() ?? const [],
    atms: atms?.map((e) => e.toEntity()).toList() ?? const [],
    kiosks: kiosks?.map((e) => e.toEntity()).toList() ?? const [],
  );
}

// class LocateUsInfoDto with _$LocateUsInfoDto {
//   const factory LocateUsInfoDto({
//     List<LocateUsInfoBrancheDto>? branches,
//   }) = _LocateUsInfoDto;
//
//   factory LocateUsInfoDto.fromJson(Map<String, dynamic> json) => _$LocateUsInfoDtoFromJson(json);
// }
//
// extension LocateUsInfoDtoX on LocateUsInfoDto {
//   LocateUsInfo toEntity() => LocateUsInfo(
//       branches: branches?.map((e)=>e.toEntity()).toList() ?? const [],
//   );
// }
