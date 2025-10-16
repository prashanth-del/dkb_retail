import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/callback_fields.dart';


part 'callback_fields_dto.freezed.dart';
part 'callback_fields_dto.g.dart';

@freezed
class CallbackFieldsDto with _$CallbackFieldsDto {
  const factory CallbackFieldsDto({
    String? fieldKey,
    String? fieldName,
    String? fieldOption,
    String? fieldLength,
    dynamic? fieldValidations,
    String? fieldType,
    dynamic? fieldList,
    int? sequence,
  }) = _CallbackFieldsDto;

  factory CallbackFieldsDto.fromJson(Map<String, dynamic> json) => _$CallbackFieldsDtoFromJson(json);
}

extension CallbackFieldsDtoX on CallbackFieldsDto {
  CallbackFields toEntity() => CallbackFields(
      fieldKey: fieldKey ?? "",
      fieldName: fieldName ?? "",
      fieldOption: fieldOption ?? "",
      fieldLength: fieldLength ?? "",
      fieldValidations: fieldValidations,
      fieldType: fieldType ?? "",
      fieldList: fieldList,
      sequence: sequence ?? 0,
  );
}
