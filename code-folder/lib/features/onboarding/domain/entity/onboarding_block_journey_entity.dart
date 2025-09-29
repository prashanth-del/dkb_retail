import 'package:dkb_retail/features/onboarding/data/model/onboarding_file_upload_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboarding_block_journey_entity.freezed.dart';
part 'onboarding_block_journey_entity.g.dart';

@freezed
class OnboardingBlockJourneyEntity with _$OnboardingBlockJourneyEntity {
  const factory OnboardingBlockJourneyEntity({required String message}) =
      _OnboardingBlockJourneyEntityy;

  factory OnboardingBlockJourneyEntity.fromJson(Map<String, dynamic> json) =>
      _$OnboardingBlockJourneyEntityFromJson(json);
}
