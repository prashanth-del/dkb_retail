import 'package:freezed_annotation/freezed_annotation.dart';


part 'validate_otp_request_request_info_dto.freezed.dart';
part 'validate_otp_request_request_info_dto.g.dart';

@freezed
class ValidateOtpRequestRequestInfoDto with _$ValidateOtpRequestRequestInfoDto {
  const factory ValidateOtpRequestRequestInfoDto({
    String? otp,
  }) = _ValidateOtpRequestRequestInfoDto;

  factory ValidateOtpRequestRequestInfoDto.fromJson(Map<String, dynamic> json) => _$ValidateOtpRequestRequestInfoDtoFromJson(json);
}
