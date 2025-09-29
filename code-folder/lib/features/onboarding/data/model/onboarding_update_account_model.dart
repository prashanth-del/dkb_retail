import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entity/onboarding_save_stage_data_entity.dart';
import '../../domain/entity/onboarding_stage_sum_entity.dart';
import '../../domain/entity/onboarding_update_account_entity.dart';


part 'onboarding_update_account_model.freezed.dart';
part 'onboarding_update_account_model.g.dart';

@freezed
class OnboardingUpdateAccountModel with _$OnboardingUpdateAccountModel {
  const factory OnboardingUpdateAccountModel({
    @JsonKey(name: 'code') required String code,
    @JsonKey(name: 'description') required String description,

  }) = _OnboardingUpdateAccountModel;

  factory OnboardingUpdateAccountModel.fromJson(Map<String, dynamic> json) =>
      _$OnboardingUpdateAccountModelFromJson(json);

  const OnboardingUpdateAccountModel._();

  OnboardingUpdateAccountEntity toDomain() {
    return OnboardingUpdateAccountEntity(
        code: code,
        description: description
    );
  }
}
