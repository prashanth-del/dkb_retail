import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/locate_us_info_branche_coordinate.dart';


part 'locate_us_info_branche_coordinate_dto.freezed.dart';
part 'locate_us_info_branche_coordinate_dto.g.dart';

@freezed
class LocateUsInfoBrancheCoordinateDto with _$LocateUsInfoBrancheCoordinateDto {
  const factory LocateUsInfoBrancheCoordinateDto({
    double? latitude,
    double? longitude,
  }) = _LocateUsInfoBrancheCoordinateDto;

  factory LocateUsInfoBrancheCoordinateDto.fromJson(Map<String, dynamic> json) => _$LocateUsInfoBrancheCoordinateDtoFromJson(json);
}

extension LocateUsInfoBrancheCoordinateDtoX on LocateUsInfoBrancheCoordinateDto {
  LocateUsInfoBrancheCoordinate toEntity() => LocateUsInfoBrancheCoordinate(
      latitude: latitude ?? 0.0,
      longitude: longitude ?? 0.0,
  );
}
