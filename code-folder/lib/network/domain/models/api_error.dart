import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_error.freezed.dart';
part 'api_error.g.dart';

@freezed
class ApiError with _$ApiError {
  const factory ApiError({
    String? code,         // e.g. '000000'
    String? description,  // generic description
    String? mwCode,       // middleware code (if any)
    String? mwdesc,       // middleware description (network-friendly)
  }) = _ApiError;

  factory ApiError.fromJson(Map<String, dynamic> json) => _$ApiErrorFromJson(json);

  const ApiError._();

  bool get ok => code == '000000';

  @override
  String toString() => description ?? mwdesc ?? "Something went wrong!";
}
