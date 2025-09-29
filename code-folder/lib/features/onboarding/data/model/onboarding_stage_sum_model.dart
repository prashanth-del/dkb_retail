import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entity/onboarding_stage_sum_entity.dart';


part 'onboarding_stage_sum_model.freezed.dart';
part 'onboarding_stage_sum_model.g.dart';

@freezed
class OnboardingStageSumModel with _$OnboardingStageSumModel {
  const factory OnboardingStageSumModel({
    @JsonKey(name: 'Stagedata') required List<StageData> stageData,
  }) = _OnboardingStageSumModel;

  factory OnboardingStageSumModel.fromJson(Map<String, dynamic> json) =>
      _$OnboardingStageSumModelFromJson(json);

  const OnboardingStageSumModel._();

  OnboardingStageSumEntity toDomain() {
    return OnboardingStageSumEntity(
      stageData: stageData,
    );
  }
}

@freezed
class StageData with _$StageData {
  const factory StageData({
    @JsonKey(name: 'stageId') required String stageId,
    @JsonKey(name: 'stageDesc') required String stageDesc,
    @JsonKey(name: 'priority') required int priority,
  }) = _StageData;

  factory StageData.fromJson(Map<String, dynamic> json) =>
      _$StageDataFromJson(json);
}
