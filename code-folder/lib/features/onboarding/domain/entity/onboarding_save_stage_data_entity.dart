import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/model/onboarding_stage_sum_model.dart';


part 'onboarding_save_stage_data_entity.freezed.dart';
part 'onboarding_save_stage_data_entity.g.dart';

@freezed
class OnboardingSaveStageDataEntity with _$OnboardingSaveStageDataEntity {
  const factory OnboardingSaveStageDataEntity({
    @JsonKey(name: 'code') required String code,
    @JsonKey(name: 'description') required String description,

  }) = _OnboardingSaveStageDataEntity;

  factory OnboardingSaveStageDataEntity.fromJson(Map<String, dynamic> json) =>
      _$OnboardingSaveStageDataEntityFromJson(json);
}
