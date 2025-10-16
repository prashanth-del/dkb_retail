// GENERATED DTO (Freezed): ValidateCardRequestRequestInfoDto
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/validate_card_entites/validate_card_request_request_info.dart';

part 'validate_card_request_request_info_dto.freezed.dart';
part 'validate_card_request_request_info_dto.g.dart';

@freezed
class ValidateCardRequestRequestInfoDto
    with _$ValidateCardRequestRequestInfoDto {
  const factory ValidateCardRequestRequestInfoDto({
    String? cardNumber,
    String? pin,
  }) = _ValidateCardRequestRequestInfoDto;

  factory ValidateCardRequestRequestInfoDto.fromJson(
    Map<String, dynamic> json,
  ) => _$ValidateCardRequestRequestInfoDtoFromJson(json);
}

extension ValidateCardRequestRequestInfoDtoX
    on ValidateCardRequestRequestInfoDto {
  ValidateCardRequestRequestInfo toEntity() => ValidateCardRequestRequestInfo(
    cardNumber: cardNumber ?? "",
    pin: pin ?? "",
  );
}
