import 'package:freezed_annotation/freezed_annotation.dart';
import 'update_password2_request_body_raw_dto.dart';
import 'update_password2_request_body_option_dto.dart';

part 'update_password2_request_body_dto.freezed.dart';
part 'update_password2_request_body_dto.g.dart';

@freezed
class UpdatePassword2RequestBodyDto with _$UpdatePassword2RequestBodyDto {
  const factory UpdatePassword2RequestBodyDto({
    String? mode,
    UpdatePassword2RequestBodyRawDto? raw,
    UpdatePassword2RequestBodyOptionDto? options,
  }) = _UpdatePassword2RequestBodyDto;

  factory UpdatePassword2RequestBodyDto.fromJson(Map<String, dynamic> json) =>
      _$UpdatePassword2RequestBodyDtoFromJson(json);
}
