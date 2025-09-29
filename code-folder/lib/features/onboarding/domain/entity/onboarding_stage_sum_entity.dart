import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/model/onboarding_stage_sum_model.dart';


part 'onboarding_stage_sum_entity.freezed.dart';
part 'onboarding_stage_sum_entity.g.dart';

@freezed
class OnboardingStageSumEntity with _$OnboardingStageSumEntity {
  const factory OnboardingStageSumEntity({
    required List<StageData> stageData,

  }) = _OnboardingStageSumEntity;

  factory OnboardingStageSumEntity.fromJson(Map<String, dynamic> json) =>
      _$OnboardingStageSumEntityFromJson(json);
}
