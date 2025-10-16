import 'package:freezed_annotation/freezed_annotation.dart';
import './biometriclogin_request_body_raw_dto.dart';
import './biometriclogin_request_body_option_dto.dart';

part 'biometriclogin_request_body_dto.freezed.dart';
part 'biometriclogin_request_body_dto.g.dart';

@freezed
class BiometricloginRequestBodyDto with _$BiometricloginRequestBodyDto {
  const factory BiometricloginRequestBodyDto({
    String? mode,
    BiometricloginRequestBodyRawDto? raw,
    BiometricloginRequestBodyOptionDto? options,
  }) = _BiometricloginRequestBodyDto;

  factory BiometricloginRequestBodyDto.fromJson(Map<String, dynamic> json) => _$BiometricloginRequestBodyDtoFromJson(json);
}
