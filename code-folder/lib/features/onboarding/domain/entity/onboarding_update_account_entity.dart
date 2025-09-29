import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/model/onboarding_stage_sum_model.dart';


part 'onboarding_update_account_entity.freezed.dart';
part 'onboarding_update_account_entity.g.dart';

@freezed
class OnboardingUpdateAccountEntity with _$OnboardingUpdateAccountEntity {
  const factory OnboardingUpdateAccountEntity({
    @JsonKey(name: 'code') required String code,
    @JsonKey(name: 'description') required String description,

  }) = _OnboardingUpdateAccountEntity;

  factory OnboardingUpdateAccountEntity.fromJson(Map<String, dynamic> json) =>
      _$OnboardingUpdateAccountEntityFromJson(json);
}
