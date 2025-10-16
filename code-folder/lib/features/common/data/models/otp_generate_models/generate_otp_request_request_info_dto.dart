import 'package:freezed_annotation/freezed_annotation.dart';


part 'generate_otp_request_request_info_dto.freezed.dart';
part 'generate_otp_request_request_info_dto.g.dart';

@freezed
class GenerateOtpRequestRequestInfoDto with _$GenerateOtpRequestRequestInfoDto {
  const factory GenerateOtpRequestRequestInfoDto({
    String? action,
    int? rimNo,
    String? mobileNumber,
  }) = _GenerateOtpRequestRequestInfoDto;

  factory GenerateOtpRequestRequestInfoDto.fromJson(Map<String, dynamic> json) => _$GenerateOtpRequestRequestInfoDtoFromJson(json);
}
