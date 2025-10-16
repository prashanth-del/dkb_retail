// GENERATED DTO (Freezed): PasswordRulesDto
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/password_rules_entites/password_rules.dart';

part 'password_rules_dto.freezed.dart';
part 'password_rules_dto.g.dart';

@freezed
class PasswordRulesDto with _$PasswordRulesDto {
  const factory PasswordRulesDto({
    String? ruleDescription,
    String? validationPattern,
  }) = _PasswordRulesDto;

  factory PasswordRulesDto.fromJson(Map<String, dynamic> json) =>
      _$PasswordRulesDtoFromJson(json);
}

extension PasswordRulesDtoX on PasswordRulesDto {
  PasswordRules toEntity() => PasswordRules(
    ruleDescription: ruleDescription ?? "",
    validationPattern: validationPattern ?? "",
  );
}
