import 'package:freezed_annotation/freezed_annotation.dart';
import 'update_password_request_body_option_raw_dto.dart';

part 'update_password_request_body_option_dto.freezed.dart';
part 'update_password_request_body_option_dto.g.dart';

@freezed
class UpdatePasswordRequestBodyOptionDto
    with _$UpdatePasswordRequestBodyOptionDto {
  const factory UpdatePasswordRequestBodyOptionDto({
    UpdatePasswordRequestBodyOptionRawDto? raw,
  }) = _UpdatePasswordRequestBodyOptionDto;

  factory UpdatePasswordRequestBodyOptionDto.fromJson(
    Map<String, dynamic> json,
  ) => _$UpdatePasswordRequestBodyOptionDtoFromJson(json);
}
