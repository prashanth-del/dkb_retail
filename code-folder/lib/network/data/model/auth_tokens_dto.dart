import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/models/auth_tokens.dart';

part 'auth_tokens_dto.freezed.dart';
part 'auth_tokens_dto.g.dart';

@freezed
class AuthTokensDto with _$AuthTokensDto {
  const AuthTokensDto._();

  const factory AuthTokensDto({
    String? reftkn,
    String? atkn,
  }) = _AuthTokensDto;

  AuthTokens toDomain() => AuthTokens(
    atkn: atkn ?? "",
    reftkn: reftkn ?? "",
  );

  factory AuthTokensDto.fromJson(Map<String, dynamic> json) =>
      _$AuthTokensDtoFromJson(json);
}
