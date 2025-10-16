import 'package:freezed_annotation/freezed_annotation.dart';


part 'update_password2_request_body_raw_dto.freezed.dart';
part 'update_password2_request_body_raw_dto.g.dart';

@freezed
class UpdatePassword2RequestBodyRawDto with _$UpdatePassword2RequestBodyRawDto {
  const factory UpdatePassword2RequestBodyRawDto({
    int? customerId,
    String? newUsername,
    String? newPassword,
    String? clientSalt,
  }) = _UpdatePassword2RequestBodyRawDto;

  factory UpdatePassword2RequestBodyRawDto.fromJson(Map<String, dynamic> json) => _$UpdatePassword2RequestBodyRawDtoFromJson(json);
}
