import 'package:dkb_retail/features/onboarding/data/model/onboarding_retrieve_journey_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboarding_retrieve_journey_entity.freezed.dart';
part 'onboarding_retrieve_journey_entity.g.dart';

@freezed
class OnboardingRetrieveJourneyEntity with _$OnboardingRetrieveJourneyEntity {
  const factory OnboardingRetrieveJourneyEntity({
    @JsonKey(name: 'data') required DataList data,

    //  required Map<String, Map<String,dynamic>> productSelection,
    // required Map<String, Map<String,dynamic>> basicDetails,
    //   required Map<String, Map<String,dynamic>> additionalInfoDetails,
    //   required Map<String, Map<String,dynamic>> personalResidentMailingAddress,
    //  required Map<String, Map<String,dynamic>> workHomeAddress,
    //   required Map<String, Map<String,dynamic>> financialInfo1,
    //   required Map<String, Map<String,dynamic>> financialInfo2,
  }) = _OnboardingRetrieveJourneyEntity;

  factory OnboardingRetrieveJourneyEntity.fromJson(Map<String, dynamic> json) =>
      _$OnboardingRetrieveJourneyEntityFromJson(json);
}
