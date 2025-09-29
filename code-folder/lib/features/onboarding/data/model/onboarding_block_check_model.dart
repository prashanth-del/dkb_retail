import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entity/onboarding_block_check_entity.dart';


part 'onboarding_block_check_model.freezed.dart';
part 'onboarding_block_check_model.g.dart';

@freezed
class OnboardingBlockCheckModel with _$OnboardingBlockCheckModel {
  const factory OnboardingBlockCheckModel({
    @JsonKey(name: 'isblocked') required String isblocked,
  }) = _OnboardingBlockCheckModel;

  factory OnboardingBlockCheckModel.fromJson(Map<String, dynamic> json) =>
      _$OnboardingBlockCheckModelFromJson(json);

  const OnboardingBlockCheckModel._();

  OnboardingBlockCheckEntity toDomain() {
    return OnboardingBlockCheckEntity(
      isblocked: isblocked,
    );
  }
}
