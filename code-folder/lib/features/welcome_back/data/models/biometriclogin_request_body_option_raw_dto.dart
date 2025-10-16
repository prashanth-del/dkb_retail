import 'package:freezed_annotation/freezed_annotation.dart';


part 'biometriclogin_request_body_option_raw_dto.freezed.dart';
part 'biometriclogin_request_body_option_raw_dto.g.dart';

@freezed
class BiometricloginRequestBodyOptionRawDto with _$BiometricloginRequestBodyOptionRawDto {
  const factory BiometricloginRequestBodyOptionRawDto({
    String? language,
  }) = _BiometricloginRequestBodyOptionRawDto;

  factory BiometricloginRequestBodyOptionRawDto.fromJson(Map<String, dynamic> json) => _$BiometricloginRequestBodyOptionRawDtoFromJson(json);
}
