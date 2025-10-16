import 'package:freezed_annotation/freezed_annotation.dart';

part 'signwith_credentials_request_body_raw_dto.freezed.dart';
part 'signwith_credentials_request_body_raw_dto.g.dart';

@freezed
class SignwithCredentialsRequestBodyRawDto
    with _$SignwithCredentialsRequestBodyRawDto {
  const factory SignwithCredentialsRequestBodyRawDto({
    String? userId,
    String? password,
    String? loginChannel,
    String? clientSalt,
  }) = _SignwithCredentialsRequestBodyRawDto;

  factory SignwithCredentialsRequestBodyRawDto.fromJson(
    Map<String, dynamic> json,
  ) => _$SignwithCredentialsRequestBodyRawDtoFromJson(json);
}
