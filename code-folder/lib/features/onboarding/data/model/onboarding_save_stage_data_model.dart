import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entity/onboarding_save_stage_data_entity.dart';
import '../../domain/entity/onboarding_stage_sum_entity.dart';


part 'onboarding_save_stage_data_model.freezed.dart';
part 'onboarding_save_stage_data_model.g.dart';

@freezed
class OnboardingSaveStageDataModel with _$OnboardingSaveStageDataModel {
  const factory OnboardingSaveStageDataModel({
    @JsonKey(name: 'code') required String code,
    @JsonKey(name: 'description') required String description,

  }) = _OnboardingSaveStageDataModel;

  factory OnboardingSaveStageDataModel.fromJson(Map<String, dynamic> json) =>
      _$OnboardingSaveStageDataModelFromJson(json);

  const OnboardingSaveStageDataModel._();

  OnboardingSaveStageDataEntity toDomain() {
    return OnboardingSaveStageDataEntity(
      code: code,
      description: description
    );
  }
}
