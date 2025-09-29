import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entity/active_session_entity.dart';

part 'active_session_dto.freezed.dart';
part 'active_session_dto.g.dart';

@freezed
class ActiveSessionDto with _$ActiveSessionDto {
  const factory ActiveSessionDto({
    required Axis yAxis,
    required Axis xAxis,
    required List<Series> series,
    required String title,
  }) = _ActiveSessionDto;

  const ActiveSessionDto._();

  // Mapping DTO to Domain Entity
  ActiveSessionEntity toDomain() {
    return ActiveSessionEntity(
      yAxis: yAxis,
      xAxis: xAxis,
      series: series,
      title: title,
    );
  }

  factory ActiveSessionDto.fromJson(Map<String, dynamic> json) =>
      _$ActiveSessionDtoFromJson(json);
}

@freezed
class Axis with _$Axis {
  const factory Axis({
    required String title,
    required List<String> values,
  }) = _Axis;

  factory Axis.fromJson(Map<String, dynamic> json) => _$AxisFromJson(json);
}

@freezed
class Series with _$Series {
  const factory Series({
    required String name,
    required List<DataPoint> data,
  }) = _Series;

  factory Series.fromJson(Map<String, dynamic> json) => _$SeriesFromJson(json);
}

@freezed
class DataPoint with _$DataPoint {
  const factory DataPoint({
    required String x,
    required String y,
  }) = _DataPoint;

  factory DataPoint.fromJson(Map<String, dynamic> json) => _$DataPointFromJson(json);
}
