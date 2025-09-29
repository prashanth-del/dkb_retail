import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entity/onboarding_file_upload_entity.dart';



part 'onboarding_file_upload_model.freezed.dart';
part 'onboarding_file_upload_model.g.dart';

@freezed
class OnboardingFileUploadModel with _$OnboardingFileUploadModel {
  const factory OnboardingFileUploadModel({
    @JsonKey(name: 'data') required Map<String,dynamic> data,
  }) = _OnboardingFileUploadModel;

  factory OnboardingFileUploadModel.fromJson(Map<String, dynamic> json) =>
      _$OnboardingFileUploadModelFromJson(json);

  const OnboardingFileUploadModel._();

  OnboardingFileUploadEntity toDomain() {
    return OnboardingFileUploadEntity(
      data: data,
    );
  }
}

// @freezed
// class QidDetails with _$QidDetails {
//   const factory QidDetails({
//     @JsonKey(name: 'fullName') required String fullName,
//     @JsonKey(name: 'QIDNumber') required String qidNumber,
//     @JsonKey(name: 'expirationDate') required String expirationDate,
//     @JsonKey(name: 'dateOfBirth') required String dateOfBirth,
//     @JsonKey(name: 'Nationality') required String nationality,
//   }) = _QidDetails;
//
//   factory QidDetails.fromJson(Map<String, dynamic> json) =>
//       _$QidDetailsFromJson(json);
// }
