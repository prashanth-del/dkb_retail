import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/call_back_request.dart';

part 'fetch_call_back_request_state.freezed.dart';

@freezed
class FetchCallBackRequestState with _$FetchCallBackRequestState {
  const factory FetchCallBackRequestState.initial() = _Initial;
  const factory FetchCallBackRequestState.loading() = _Loading;
  const factory FetchCallBackRequestState.success(List<CallBackRequest> data) = _Success;
  const factory FetchCallBackRequestState.failure(String message) = _Failure;
}
