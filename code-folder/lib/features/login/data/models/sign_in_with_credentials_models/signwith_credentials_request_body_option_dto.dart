import 'package:freezed_annotation/freezed_annotation.dart';
import 'signwith_credentials_request_body_option_raw_dto.dart';

part 'signwith_credentials_request_body_option_dto.freezed.dart';
part 'signwith_credentials_request_body_option_dto.g.dart';

@freezed
class SignwithCredentialsRequestBodyOptionDto
    with _$SignwithCredentialsRequestBodyOptionDto {
  const factory SignwithCredentialsRequestBodyOptionDto({
    SignwithCredentialsRequestBodyOptionRawDto? raw,
  }) = _SignwithCredentialsRequestBodyOptionDto;

  factory SignwithCredentialsRequestBodyOptionDto.fromJson(
    Map<String, dynamic> json,
  ) => _$SignwithCredentialsRequestBodyOptionDtoFromJson(json);
}
