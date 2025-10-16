// GENERATED DTO (Freezed): ValidateCardRequestDto
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/validate_card_entites/validate_card_request.dart';
import 'validate_card_request_request_info_dto.dart';
import 'validate_card_request_device_info_dto.dart';

part 'validate_card_request_dto.freezed.dart';
part 'validate_card_request_dto.g.dart';

@freezed
class ValidateCardRequestDto with _$ValidateCardRequestDto {
  const factory ValidateCardRequestDto({
    ValidateCardRequestRequestInfoDto? requestInfo,
    ValidateCardRequestDeviceInfoDto? deviceInfo,
  }) = _ValidateCardRequestDto;

  factory ValidateCardRequestDto.fromJson(Map<String, dynamic> json) =>
      _$ValidateCardRequestDtoFromJson(json);
}

extension ValidateCardRequestDtoX on ValidateCardRequestDto {
  ValidateCardRequest toEntity() => ValidateCardRequest(
    requestInfo: requestInfo?.toEntity(),
    deviceInfo: deviceInfo?.toEntity(),
  );
}
