import 'package:freezed_annotation/freezed_annotation.dart';

import 'api_envelope.dart';

part 'api_error.freezed.dart';
part 'api_error.g.dart';

@freezed
class ApiError with _$ApiError {
  const factory ApiError({
    dynamic? code, // e.g. '000000'
    String? description, // generic description
    String? mwCode, // middleware code (if any)
    String? mwdesc, // middleware description (network-friendly)
  }) = _ApiError;

  factory ApiError.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorFromJson(json);

  const ApiError._();

  bool get ok => code == '000000';

  @override
  String toString() => description ?? mwdesc ?? "Something went wrong!";
}

extension ApiErrorX on ApiError {
  /// Create a normalized error from any ApiEnvelope
  static ApiError fromEnvelope<T>(ApiEnvelope<T> env) {
    final base = env.status;
    final msg = env.message; // already user-friendly
    return base.copyWith(
      mwdesc: base.mwdesc ?? msg,
      description: base.description ?? msg,
    );
  }
}
