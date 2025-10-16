import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_response.freezed.dart';

@freezed
class LoginResponse with _$LoginResponse {
  const factory LoginResponse({
    required bool valid,
    required String userId,
    required String domainId,
    required String userType,
    required String token,
  }) = _LoginResponse;
}
