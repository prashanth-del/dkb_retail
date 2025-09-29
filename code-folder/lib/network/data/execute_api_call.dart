import 'dart:convert';
import 'package:dio/dio.dart';
import '../domain/models/api_envelope.dart';
import 'handle_exception.dart';

typedef DioCall = Future<Response> Function();

Future<ApiEnvelope<R>> executeApiCall<R>({
  required Future<Response> Function() call,
  required ApiEnvelope<R> Function(Map<String, dynamic> json) mapJson,
}) async {
  try {
    final res = await call();
    final raw = res.data;
    Map<String, dynamic>? asMap;
    if (raw is Map<String, dynamic>) {
      asMap = raw;
    } else if (raw is Map) {
      asMap = Map<String, dynamic>.from(raw);
    } else if (raw is String) {
      final decoded = jsonDecode(raw);
      if (decoded is Map) asMap = Map<String, dynamic>.from(decoded);
    }
    if (asMap != null) return mapJson(asMap);
    return handleException<R>('Invalid server response');
  } catch (e) {
    return handleException<R>(e);
  }
}

