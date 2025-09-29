import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import '../../domain/models/api_error.dart';

part 'generic_list_response.g.dart';

typedef JsonMap = Map<String, dynamic>;

@JsonSerializable(explicitToJson: true, genericArgumentFactories: true)
class GenericListResponse<T> {
  final ApiError? status;
  final List<T> data;

  const GenericListResponse({this.status, this.data = const []});

  bool get isSuccess => status?.ok == true;

  /// Closure-friendly factory:
  /// - Accepts raw Object? (Map or JSON string with `{ status, data: [...] }`)
  /// - Accepts parser like `(data) => ItemDto.fromJson(data)` (no casts)
  factory GenericListResponse.fromJson(
      Object? raw,
      T Function(dynamic json) parseT, // <— dynamic so your closure compiles
      ) {
    final map = _ensureMap(raw);
    return _$GenericListResponseFromJson(
      map,
          (obj) => parseT(_ensureMap(obj)), // normalize each item to Map before parsing
    );
  }

  JsonMap toJson(Object Function(T value) toJsonT) =>
      _$GenericListResponseToJson(this, toJsonT);

  // ---------- helpers ----------
  static JsonMap _ensureMap(Object? raw) {
    if (raw is JsonMap) return raw;
    if (raw is String) {
      final decoded = jsonDecode(raw);
      if (decoded is JsonMap) return decoded;
    }
    if (raw is Map) return Map<String, dynamic>.from(raw);
    throw const FormatException('Invalid GenericListResponse payload (expected JSON object).');
  }
}
