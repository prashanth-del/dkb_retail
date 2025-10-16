import 'package:freezed_annotation/freezed_annotation.dart';


part 'callback_fields.freezed.dart';

@freezed
class CallbackFields with _$CallbackFields {
  const factory CallbackFields({
    required String fieldKey,
    required String fieldName,
    required String fieldOption,
    required String fieldLength,
    required dynamic fieldValidations,
    required String fieldType,
    required dynamic fieldList,
    required int sequence,
  }) = _CallbackFields;
}
