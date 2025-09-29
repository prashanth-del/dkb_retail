import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entity/onboarding_block_journey_entity.dart';
import '../../domain/entity/onboarding_file_upload_entity.dart';



part 'onboarding_block_journey_model.freezed.dart';
part 'onboarding_block_journey_model.g.dart';

@freezed
class OnboardingBlockJourneyModel with _$OnboardingBlockJourneyModel {
  const factory OnboardingBlockJourneyModel({
    @JsonKey(name: 'Message') required String message,
  }) = _OnboardingBlockJourneyModel;

  factory OnboardingBlockJourneyModel.fromJson(Map<String, dynamic> json) =>
      _$OnboardingBlockJourneyModelFromJson(json);

  const OnboardingBlockJourneyModel._();

  OnboardingBlockJourneyEntity toDomain() {
    return OnboardingBlockJourneyEntity(
      message: message,
    );
  }
}

