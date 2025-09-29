import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import '../../domain/models/api_error.dart';

part 'generic_response.g.dart';

typedef JsonMap = Map<String, dynamic>;

@JsonSerializable(explicitToJson: true, genericArgumentFactories: true)
class GenericResponse<T> {
  final ApiError? status;
  final T? data;

  const GenericResponse({this.status, this.data});

  bool get isSuccess => status?.ok == true;

  /// Closure-friendly factory:
  /// - Accepts raw Object? (Map or JSON string)
  /// - Accepts parser like `(data) => UserDto.fromJson(data)` (no casts)
  factory GenericResponse.fromJson(
      Object? raw,
      T Function(dynamic json) parseT, // <— dynamic so your closure compiles
      ) {
    final map = _ensureMap(raw);
    return _$GenericResponseFromJson(
      map,
      // Bridge: generated expects T Function(Object?),
      // we normalize to Map<String,dynamic> then call your closure.
          (obj) => parseT(_ensureMap(obj)),
    );
  }

  JsonMap toJson(Object Function(T value) toJsonT) =>
      _$GenericResponseToJson(this, toJsonT);

  // ---------- helpers ----------
  static JsonMap _ensureMap(Object? raw) {
    if (raw is JsonMap) return raw;
    if (raw is String) {
      final decoded = jsonDecode(raw);
      if (decoded is JsonMap) return decoded;
    }
    if (raw is Map) return Map<String, dynamic>.from(raw);
    throw const FormatException('Invalid Response payload (expected JSON object).');
  }
}
