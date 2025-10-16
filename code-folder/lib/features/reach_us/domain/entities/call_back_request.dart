import 'package:freezed_annotation/freezed_annotation.dart';


part 'call_back_request.freezed.dart';

@freezed
class CallBackRequest with _$CallBackRequest {
  const factory CallBackRequest({
    required String returnCodeDescProvider,
    required String returnCodeProvider,
  }) = _CallBackRequest;
}
