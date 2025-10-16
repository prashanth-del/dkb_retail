import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/request_callback_entity.dart';

part 'request_callback_dto.freezed.dart';
part 'request_callback_dto.g.dart';

@freezed
class RequestCallbackDto with _$RequestCallbackDto {
  const factory RequestCallbackDto({
    required StatusDto status,
    required List<RequestCallbackDataDto> data,
  }) = _RequestCallbackDto;

  factory RequestCallbackDto.fromJson(Map<String, dynamic> json) =>
      _$RequestCallbackDtoFromJson(json);
  const RequestCallbackDto._();

  RequestCallbackEntity toDomain() {
    return RequestCallbackEntity(status: status!, data: data!);
  }
}

@freezed
class StatusDto with _$StatusDto {
  const factory StatusDto({String? code, String? description}) = _StatusDto;

  factory StatusDto.fromJson(Map<String, dynamic> json) =>
      _$StatusDtoFromJson(json);
}

@freezed
class RequestCallbackDataDto with _$RequestCallbackDataDto {
  const factory RequestCallbackDataDto({
    String? returnCodeDescProvider,
    String? returnCodeProvider,
  }) = _RequestCallbackDataDto;

  factory RequestCallbackDataDto.fromJson(Map<String, dynamic> json) =>
      _$RequestCallbackDataDtoFromJson(json);
}
