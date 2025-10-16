import 'package:freezed_annotation/freezed_annotation.dart';


part 'locate_us_info_branche_coordinate.freezed.dart';

@freezed
class LocateUsInfoBrancheCoordinate with _$LocateUsInfoBrancheCoordinate {
  const factory LocateUsInfoBrancheCoordinate({
    required double latitude,
    required double longitude,
  }) = _LocateUsInfoBrancheCoordinate;
}
