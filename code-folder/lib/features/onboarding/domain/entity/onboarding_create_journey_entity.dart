import 'package:freezed_annotation/freezed_annotation.dart';


part 'onboarding_create_journey_entity.freezed.dart';
part 'onboarding_create_journey_entity.g.dart';

@freezed
class OnboardingCreateJourneyEntity with _$OnboardingCreateJourneyEntity {
  const factory OnboardingCreateJourneyEntity({
    required int custJourneyId,

  }) = _OnboardingCreateJourneyEntity;

  factory OnboardingCreateJourneyEntity.fromJson(Map<String, dynamic> json) =>
      _$OnboardingCreateJourneyEntityFromJson(json);
}
