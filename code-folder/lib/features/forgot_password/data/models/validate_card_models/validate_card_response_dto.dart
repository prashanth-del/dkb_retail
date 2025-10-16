// GENERATED DTO (Freezed): ValidateCardResponseDto
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/validate_card_entites/validate_card_response.dart';
import 'validate_card_response_data_dto.dart';
import 'validate_card_response_statu_dto.dart';

part 'validate_card_response_dto.freezed.dart';
part 'validate_card_response_dto.g.dart';

@freezed
class ValidateCardResponseDto with _$ValidateCardResponseDto {
  const factory ValidateCardResponseDto({
    ValidateCardResponseDataDto? data,
    ValidateCardResponseStatuDto? status,
  }) = _ValidateCardResponseDto;

  factory ValidateCardResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ValidateCardResponseDtoFromJson(json);
}

extension ValidateCardResponseDtoX on ValidateCardResponseDto {
  ValidateCardResponse toEntity() =>
      ValidateCardResponse(data: data?.toEntity(), status: status?.toEntity());
}
