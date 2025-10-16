import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/request_callback_dto.dart';

part 'request_callback_entity.freezed.dart';

@freezed
class RequestCallbackEntity with _$RequestCallbackEntity {
  const factory RequestCallbackEntity({
    required StatusDto status,
    required List<RequestCallbackDataDto> data,
  }) = _RequestCallbackEntity;
}
