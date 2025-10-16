import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/otp_generate_entities/otp_generate.dart';


part 'otp_generate_dto.freezed.dart';
part 'otp_generate_dto.g.dart';

@freezed
class OtpGenerateDto with _$OtpGenerateDto {
  const factory OtpGenerateDto({
    String? mobileNumber,
    int? rimNo,
    String? message,
  }) = _OtpGenerateDto;

  factory OtpGenerateDto.fromJson(Map<String, dynamic> json) => _$OtpGenerateDtoFromJson(json);
}

extension OtpGenerateDtoX on OtpGenerateDto {
  OtpGenerate toEntity() => OtpGenerate(
      mobileNumber: mobileNumber ?? "",
      rimNo: rimNo ?? 0,
      message: message ?? "",
  );
}
