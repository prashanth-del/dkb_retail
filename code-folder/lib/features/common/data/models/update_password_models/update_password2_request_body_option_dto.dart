import 'package:freezed_annotation/freezed_annotation.dart';
import 'update_password2_request_body_option_raw_dto.dart';

part 'update_password2_request_body_option_dto.freezed.dart';
part 'update_password2_request_body_option_dto.g.dart';

@freezed
class UpdatePassword2RequestBodyOptionDto
    with _$UpdatePassword2RequestBodyOptionDto {
  const factory UpdatePassword2RequestBodyOptionDto({
    UpdatePassword2RequestBodyOptionRawDto? raw,
  }) = _UpdatePassword2RequestBodyOptionDto;

  factory UpdatePassword2RequestBodyOptionDto.fromJson(
    Map<String, dynamic> json,
  ) => _$UpdatePassword2RequestBodyOptionDtoFromJson(json);
}
