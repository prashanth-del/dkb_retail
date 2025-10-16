import 'package:freezed_annotation/freezed_annotation.dart';
import 'signwith_credentials_request_body_raw_dto.dart';
import 'signwith_credentials_request_body_option_dto.dart';

part 'signwith_credentials_request_body_dto.freezed.dart';
part 'signwith_credentials_request_body_dto.g.dart';

@freezed
class SignwithCredentialsRequestBodyDto
    with _$SignwithCredentialsRequestBodyDto {
  const factory SignwithCredentialsRequestBodyDto({
    String? mode,
    SignwithCredentialsRequestBodyRawDto? raw,
    SignwithCredentialsRequestBodyOptionDto? options,
  }) = _SignwithCredentialsRequestBodyDto;

  factory SignwithCredentialsRequestBodyDto.fromJson(
    Map<String, dynamic> json,
  ) => _$SignwithCredentialsRequestBodyDtoFromJson(json);
}
