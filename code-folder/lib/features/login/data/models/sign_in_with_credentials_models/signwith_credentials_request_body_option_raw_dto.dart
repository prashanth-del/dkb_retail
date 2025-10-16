import 'package:freezed_annotation/freezed_annotation.dart';

part 'signwith_credentials_request_body_option_raw_dto.freezed.dart';
part 'signwith_credentials_request_body_option_raw_dto.g.dart';

@freezed
class SignwithCredentialsRequestBodyOptionRawDto
    with _$SignwithCredentialsRequestBodyOptionRawDto {
  const factory SignwithCredentialsRequestBodyOptionRawDto({String? language}) =
      _SignwithCredentialsRequestBodyOptionRawDto;

  factory SignwithCredentialsRequestBodyOptionRawDto.fromJson(
    Map<String, dynamic> json,
  ) => _$SignwithCredentialsRequestBodyOptionRawDtoFromJson(json);
}
