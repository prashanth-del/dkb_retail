import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/otp_validate_entites/otp_validate.dart';


part 'otp_validate_dto.freezed.dart';
part 'otp_validate_dto.g.dart';

@freezed
class OtpValidateDto with _$OtpValidateDto {
  const factory OtpValidateDto({
    String? message,
  }) = _OtpValidateDto;

  factory OtpValidateDto.fromJson(Map<String, dynamic> json) => _$OtpValidateDtoFromJson(json);
}

extension OtpValidateDtoX on OtpValidateDto {
  OtpValidate toEntity() => OtpValidate(
      message: message ?? "",
  );
}
