// GENERATED DTO (Freezed): ValidateCardResponseDataDto
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/validate_card_entites/validate_card_response_data.dart';

part 'validate_card_response_data_dto.freezed.dart';
part 'validate_card_response_data_dto.g.dart';

@freezed
class ValidateCardResponseDataDto with _$ValidateCardResponseDataDto {
  const factory ValidateCardResponseDataDto({
    String? rimNumber,
    String? userName,
    bool? otp,
  }) = _ValidateCardResponseDataDto;

  factory ValidateCardResponseDataDto.fromJson(Map<String, dynamic> json) =>
      _$ValidateCardResponseDataDtoFromJson(json);
}

extension ValidateCardResponseDataDtoX on ValidateCardResponseDataDto {
  ValidateCardResponseData toEntity() => ValidateCardResponseData(
    rimNumber: rimNumber ?? "",
    userName: userName ?? "",
    otp: otp ?? false,
  );
}
