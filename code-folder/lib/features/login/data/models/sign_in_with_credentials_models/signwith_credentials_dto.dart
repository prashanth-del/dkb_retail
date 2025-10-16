import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/sign_with_credentials_entity/login_response.dart';

part 'signwith_credentials_dto.freezed.dart';
part 'signwith_credentials_dto.g.dart';

@freezed
class SignwithCredentialsDto with _$SignwithCredentialsDto {
  const factory SignwithCredentialsDto({
    bool? valid,
    String? userId,
    String? domainId,
    String? userType,
    String? token,
  }) = _SignwithCredentialsDto;

  factory SignwithCredentialsDto.fromJson(Map<String, dynamic> json) =>
      _$SignwithCredentialsDtoFromJson(json);
}

extension SignwithCredentials2DtoX on SignwithCredentialsDto {
  LoginResponse toEntity() => LoginResponse(
    valid: valid ?? false,
    userId: userId ?? "",
    domainId: domainId ?? "",
    userType: userType ?? "",
    token: token ?? "",
  );
}
