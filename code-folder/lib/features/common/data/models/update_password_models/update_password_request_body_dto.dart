import 'package:freezed_annotation/freezed_annotation.dart';
import 'update_password_request_body_option_dto.dart';

part 'update_password_request_body_dto.freezed.dart';
part 'update_password_request_body_dto.g.dart';

@freezed
class UpdatePasswordRequestBodyDto with _$UpdatePasswordRequestBodyDto {
  const factory UpdatePasswordRequestBodyDto({
    String? mode,
    String? raw,
    UpdatePasswordRequestBodyOptionDto? options,
  }) = _UpdatePasswordRequestBodyDto;

  factory UpdatePasswordRequestBodyDto.fromJson(Map<String, dynamic> json) =>
      _$UpdatePasswordRequestBodyDtoFromJson(json);
}
