import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/validate_username_response.dart';

part 'validate_username_response_dto.freezed.dart';
part 'validate_username_response_dto.g.dart';

@freezed
class ValidateUsernameResponseDto with _$ValidateUsernameResponseDto {
  const factory ValidateUsernameResponseDto({
    bool? exists,
    String? message,
    String? userId,
  }) = _ValidateUsernameResponseDto;

  factory ValidateUsernameResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ValidateUsernameResponseDtoFromJson(json);
}

extension ValidateUsernameResponseDtoX on ValidateUsernameResponseDto {
  ValidateUsernameResponse toEntity() => ValidateUsernameResponse(
    exists: exists ?? false,
    message: message ?? "",
    userId: userId ?? "",
  );
}
