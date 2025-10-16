// GENERATED DTO (Freezed): ValidateCardDto
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/validate_card_entites/validate_card.dart';
import 'validate_card_header_dto.dart';
import 'validate_card_request_dto.dart';
import 'validate_card_response_dto.dart';

part 'validate_card_dto.freezed.dart';
part 'validate_card_dto.g.dart';

@freezed
class ValidateCardDto with _$ValidateCardDto {
  const factory ValidateCardDto({
    String? url,
    ValidateCardHeaderDto? headers,
    ValidateCardRequestDto? request,
    ValidateCardResponseDto? response,
  }) = _ValidateCardDto;

  factory ValidateCardDto.fromJson(Map<String, dynamic> json) =>
      _$ValidateCardDtoFromJson(json);
}

extension ValidateCardDtoX on ValidateCardDto {
  ValidateCard toEntity() => ValidateCard(
    url: url ?? "",
    headers: headers?.toEntity(),
    request: request?.toEntity(),
    response: response?.toEntity(),
  );
}
