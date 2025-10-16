// GENERATED DTO (Freezed): ValidateCardHeaderDto
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/validate_card_entites/validate_card_header.dart';

part 'validate_card_header_dto.freezed.dart';
part 'validate_card_header_dto.g.dart';

@freezed
class ValidateCardHeaderDto with _$ValidateCardHeaderDto {
  const factory ValidateCardHeaderDto({
    String? serviceId,
    String? moduleId,
    String? subModuleId,
    String? screenId,
  }) = _ValidateCardHeaderDto;

  factory ValidateCardHeaderDto.fromJson(Map<String, dynamic> json) =>
      _$ValidateCardHeaderDtoFromJson(json);
}

extension ValidateCardHeaderDtoX on ValidateCardHeaderDto {
  ValidateCardHeader toEntity() => ValidateCardHeader(
    serviceId: serviceId ?? "",
    moduleId: moduleId ?? "",
    subModuleId: subModuleId ?? "",
    screenId: screenId ?? "",
  );
}
