import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/callback_fields.dart';

part 'fetch_callback_fields_state.freezed.dart';

@freezed
class FetchCallbackFieldsState with _$FetchCallbackFieldsState {
  const factory FetchCallbackFieldsState.initial() = _Initial;
  const factory FetchCallbackFieldsState.loading() = _Loading;
  const factory FetchCallbackFieldsState.success(List<CallbackFields> data) = _Success;
  const factory FetchCallbackFieldsState.failure(String message) = _Failure;
}
