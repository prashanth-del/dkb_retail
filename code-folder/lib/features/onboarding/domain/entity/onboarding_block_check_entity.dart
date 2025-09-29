import 'package:dkb_retail/features/onboarding/data/model/onboarding_block_check_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboarding_block_check_entity.freezed.dart';
part 'onboarding_block_check_entity.g.dart';

@freezed
class OnboardingBlockCheckEntity with _$OnboardingBlockCheckEntity {
  const factory OnboardingBlockCheckEntity({required String isblocked}) =
      _OnboardingBlockCheckEntity;

  factory OnboardingBlockCheckEntity.fromJson(Map<String, dynamic> json) =>
      _$OnboardingBlockCheckEntityFromJson(json);
}
