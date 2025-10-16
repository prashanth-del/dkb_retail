import 'package:freezed_annotation/freezed_annotation.dart';


part 'update_password_request_body_option_raw_dto.freezed.dart';
part 'update_password_request_body_option_raw_dto.g.dart';

@freezed
class UpdatePasswordRequestBodyOptionRawDto with _$UpdatePasswordRequestBodyOptionRawDto {
  const factory UpdatePasswordRequestBodyOptionRawDto({
    String? language,
  }) = _UpdatePasswordRequestBodyOptionRawDto;

  factory UpdatePasswordRequestBodyOptionRawDto.fromJson(Map<String, dynamic> json) => _$UpdatePasswordRequestBodyOptionRawDtoFromJson(json);
}
