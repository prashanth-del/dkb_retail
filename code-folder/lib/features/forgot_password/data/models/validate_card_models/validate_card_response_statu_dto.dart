// GENERATED DTO (Freezed): ValidateCardResponseStatuDto
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/validate_card_entites/validate_card_response_statu.dart';

part 'validate_card_response_statu_dto.freezed.dart';
part 'validate_card_response_statu_dto.g.dart';

@freezed
class ValidateCardResponseStatuDto with _$ValidateCardResponseStatuDto {
  const factory ValidateCardResponseStatuDto({
    String? code,
    String? description,
  }) = _ValidateCardResponseStatuDto;

  factory ValidateCardResponseStatuDto.fromJson(Map<String, dynamic> json) =>
      _$ValidateCardResponseStatuDtoFromJson(json);
}

extension ValidateCardResponseStatuDtoX on ValidateCardResponseStatuDto {
  ValidateCardResponseStatu toEntity() => ValidateCardResponseStatu(
    code: code ?? "",
    description: description ?? "",
  );
}
