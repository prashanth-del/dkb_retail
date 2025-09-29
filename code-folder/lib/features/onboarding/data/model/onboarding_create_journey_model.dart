
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entity/onboarding_create_journey_entity.dart';



part 'onboarding_create_journey_model.freezed.dart';
part 'onboarding_create_journey_model.g.dart';

@freezed
class OnboardingCreateJourneyModel with _$OnboardingCreateJourneyModel {
  const factory OnboardingCreateJourneyModel({
    @JsonKey(name: 'custJourneyId') required int custJourneyId,

  }) = _OnboardingCreateJourneyModel;

  factory OnboardingCreateJourneyModel.fromJson(Map<String, dynamic> json) =>
      _$OnboardingCreateJourneyModelFromJson(json);

  const OnboardingCreateJourneyModel._();

  OnboardingCreateJourneyEntity toDomain() {
    return OnboardingCreateJourneyEntity(
      custJourneyId: custJourneyId,
    );
  }
}

