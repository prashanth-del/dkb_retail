import 'package:freezed_annotation/freezed_annotation.dart';


part 'update_password2_request_body_option_raw_dto.freezed.dart';
part 'update_password2_request_body_option_raw_dto.g.dart';

@freezed
class UpdatePassword2RequestBodyOptionRawDto with _$UpdatePassword2RequestBodyOptionRawDto {
  const factory UpdatePassword2RequestBodyOptionRawDto({
    String? language,
  }) = _UpdatePassword2RequestBodyOptionRawDto;

  factory UpdatePassword2RequestBodyOptionRawDto.fromJson(Map<String, dynamic> json) => _$UpdatePassword2RequestBodyOptionRawDtoFromJson(json);
}
