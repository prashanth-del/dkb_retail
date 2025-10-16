import 'package:freezed_annotation/freezed_annotation.dart';
import './biometriclogin_request_body_option_raw_dto.dart';

part 'biometriclogin_request_body_option_dto.freezed.dart';
part 'biometriclogin_request_body_option_dto.g.dart';

@freezed
class BiometricloginRequestBodyOptionDto with _$BiometricloginRequestBodyOptionDto {
  const factory BiometricloginRequestBodyOptionDto({
    BiometricloginRequestBodyOptionRawDto? raw,
  }) = _BiometricloginRequestBodyOptionDto;

  factory BiometricloginRequestBodyOptionDto.fromJson(Map<String, dynamic> json) => _$BiometricloginRequestBodyOptionDtoFromJson(json);
}
