import 'package:freezed_annotation/freezed_annotation.dart';


part 'validate_username_response.freezed.dart';

@freezed
class ValidateUsernameResponse with _$ValidateUsernameResponse {
  const factory ValidateUsernameResponse({
    required bool exists,
    required String message,
    required String userId,
  }) = _ValidateUsernameResponse;
}
