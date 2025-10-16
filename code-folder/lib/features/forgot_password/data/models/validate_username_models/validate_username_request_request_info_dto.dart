import 'package:freezed_annotation/freezed_annotation.dart';


part 'validate_username_request_request_info_dto.freezed.dart';
part 'validate_username_request_request_info_dto.g.dart';

@freezed
class ValidateUsernameRequestRequestInfoDto with _$ValidateUsernameRequestRequestInfoDto {
  const factory ValidateUsernameRequestRequestInfoDto({
    String? userId,
  }) = _ValidateUsernameRequestRequestInfoDto;

  factory ValidateUsernameRequestRequestInfoDto.fromJson(Map<String, dynamic> json) => _$ValidateUsernameRequestRequestInfoDtoFromJson(json);
}
