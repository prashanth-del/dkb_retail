// GENERATED DTO (Freezed): CardValidationModalDto
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/card_validation_modal.dart';

part 'card_validation_modal_dto.freezed.dart';
part 'card_validation_modal_dto.g.dart';

@freezed
class CardValidationModalDto with _$CardValidationModalDto {
  const factory CardValidationModalDto({
    String? code,
    String? bin,
    String? productType,
    String? cardType,
    String? status,
  }) = _CardValidationModalDto;

  factory CardValidationModalDto.fromJson(Map<String, dynamic> json) =>
      _$CardValidationModalDtoFromJson(json);
}

extension CardValidationModalDtoX on CardValidationModalDto {
  CardValidationModal toEntity() => CardValidationModal(
    code: code ?? "",
    bin: bin ?? "",
    productType: productType ?? "",
    cardType: cardType ?? "",
    status: status ?? "",
  );
}
