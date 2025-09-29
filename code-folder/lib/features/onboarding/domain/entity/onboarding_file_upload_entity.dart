import 'package:dkb_retail/features/onboarding/data/model/onboarding_file_upload_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboarding_file_upload_entity.freezed.dart';
part 'onboarding_file_upload_entity.g.dart';

@freezed
class OnboardingFileUploadEntity with _$OnboardingFileUploadEntity {
  const factory OnboardingFileUploadEntity({
    required Map<String, dynamic> data,
  }) = _OnboardingFileUploadEntity;

  factory OnboardingFileUploadEntity.fromJson(Map<String, dynamic> json) =>
      _$OnboardingFileUploadEntityFromJson(json);
}
