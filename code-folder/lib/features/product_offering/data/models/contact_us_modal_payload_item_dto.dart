// GENERATED DTO (Freezed): ContactUsModalPayloadItemDto
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/contact_us_modal_payload_item.dart';

part 'contact_us_modal_payload_item_dto.freezed.dart';
part 'contact_us_modal_payload_item_dto.g.dart';

@freezed
class ContactUsModalPayloadItemDto with _$ContactUsModalPayloadItemDto {
  const factory ContactUsModalPayloadItemDto({
    String? fieldKey,
    String? fieldName,
    String? fieldOption,
    String? fieldLength,
    String? fieldValidations,
    String? fieldType,
    dynamic fieldOptions,
    int? sequence,
  }) = _ContactUsModalPayloadItemDto;

  factory ContactUsModalPayloadItemDto.fromJson(Map<String, dynamic> json) =>
      _$ContactUsModalPayloadItemDtoFromJson(json);
}

extension ContactUsModalPayloadItemDtoX on ContactUsModalPayloadItemDto {
  ContactUsModalPayloadItem toEntity() => ContactUsModalPayloadItem(
    fieldKey: fieldKey ?? "",
    fieldName: fieldName ?? "",
    fieldOption: fieldOption ?? "",
    fieldLength: fieldLength ?? "",
    fieldValidations: fieldValidations ?? "",
    fieldType: fieldType ?? "",
    fieldOptions: fieldOptions,
    sequence: sequence ?? 0,
  );
}
