import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/active_session_dto.dart';

part 'active_session_entity.freezed.dart';

@freezed
class ActiveSessionEntity with _$ActiveSessionEntity {
  const factory ActiveSessionEntity({
    required Axis yAxis,
    required Axis xAxis,
    required List<Series> series,
    required String title,
  }) = _ActiveSessionEntity;
}
