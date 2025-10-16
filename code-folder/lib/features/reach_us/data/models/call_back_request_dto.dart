import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/call_back_request.dart';


part 'call_back_request_dto.freezed.dart';
part 'call_back_request_dto.g.dart';

@freezed
class CallBackRequestDto with _$CallBackRequestDto {
  const factory CallBackRequestDto({
    String? returnCodeDescProvider,
    String? returnCodeProvider,
  }) = _CallBackRequestDto;

  factory CallBackRequestDto.fromJson(Map<String, dynamic> json) => _$CallBackRequestDtoFromJson(json);
}

extension CallBackRequestDtoX on CallBackRequestDto {
  CallBackRequest toEntity() => CallBackRequest(
      returnCodeDescProvider: returnCodeDescProvider ?? "",
      returnCodeProvider: returnCodeProvider ?? "",
  );
}
