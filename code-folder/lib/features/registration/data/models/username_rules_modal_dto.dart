// GENERATED DTO (Freezed): UsernameRulesModalDto
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/username_rules_modal.dart';


part 'username_rules_modal_dto.freezed.dart';
part 'username_rules_modal_dto.g.dart';

@freezed
class UsernameRulesModalDto with _$UsernameRulesModalDto {
  const factory UsernameRulesModalDto({
    String? ruleDescription,
    String? validationPattern,
  }) = _UsernameRulesModalDto;

  factory UsernameRulesModalDto.fromJson(Map<String, dynamic> json) => _$UsernameRulesModalDtoFromJson(json);
}

extension UsernameRulesModalDtoX on UsernameRulesModalDto {
  UsernameRulesModal toEntity() => UsernameRulesModal(
      ruleDescription: ruleDescription ?? "",
      validationPattern: validationPattern ?? "",
  );
}
