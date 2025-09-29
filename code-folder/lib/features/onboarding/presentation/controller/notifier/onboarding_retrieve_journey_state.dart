import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dkb_retail/features/onboarding/domain/entity/onboarding_retrieve_journey_entity.dart';

part 'onboarding_retrieve_journey_state.freezed.dart';

@freezed
class OnboardingRetrieveJourneyState with _$OnboardingRetrieveJourneyState {
  const factory OnboardingRetrieveJourneyState.initial() = _Initial;
  const factory OnboardingRetrieveJourneyState.loading() = _Loading;
  const factory OnboardingRetrieveJourneyState.success(
    OnboardingRetrieveJourneyEntity entity,
  ) = _Success;
  const factory OnboardingRetrieveJourneyState.failure(String message) =
      _Failure;
}
