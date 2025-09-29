import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dkb_retail/common/utils.dart';
import 'package:flutter/Material.dart';
import '../domain/models/api_envelope.dart';
import '../domain/models/api_error.dart';
import 'status_policy.dart';

ApiEnvelope<T> handleException<T>(
    Object e, [
      StatusPolicyFn policy = StatusPolicy.defaultPolicy,
    ]) {
  // ✅ Always safe fallback
  const fallbackMessage = 'Something went wrong. Please try again later.';

  ApiError _fallback({String? code}) =>
      ApiError(code: code, description: fallbackMessage);

  Map<String, dynamic>? _asJsonMap(Object? raw) {
    if (raw == null) return null;
    if (raw is Map<String, dynamic>) return raw;
    if (raw is Map) return Map<String, dynamic>.from(raw);
    if (raw is String) {
      try {
        final decoded = jsonDecode(raw);
        if (decoded is Map) return Map<String, dynamic>.from(decoded);
      } catch (_) {}
    }
    return null;
  }

  ApiError _parseApiError(Object? data, int? httpCode) {
    final map = _asJsonMap(data);

    if (map != null) {
      // 1) { status: {...} }
      final statusVal = map['status'];
      final statusMap = _asJsonMap(statusVal);
      if (statusMap != null) {
        return ApiError.fromJson(statusMap);
      }

      // 2) Flattened: { code, description, mwdesc, mwCode, message, error }
      if (map.containsKey('code') ||
          map.containsKey('description') ||
          map.containsKey('mwdesc') ||
          map.containsKey('mwCode')) {
        return ApiError.fromJson({
          'code': map['code']?.toString(),
          // ✅ Prefer description/mwdesc if present; fallback = safe string
          'description': map['description'] ??
              map['message'] ??
              map['error'] ??
              fallbackMessage,
          'mwdesc': map['mwdesc'],
          'mwCode': map['mwCode']?.toString(),
        });
      }

      // 3) JSON with only generic message/error keys
      final desc = (map['message'] ?? map['error']) as String?;
      consoleLog("-------- \nError Message :::: \n\n${desc.toString()}\n--------");
      return ApiError(
        code: httpCode?.toString(),
        description: fallbackMessage,
      );
    }

    // 4) Non-JSON types → ignore content, always friendly fallback
    return _fallback(code: httpCode?.toString());
  }

  if (e is DioException) {
    final httpCode = e.response?.statusCode;
    final data = e.response?.data;

    final status = _parseApiError(data, httpCode);
    return ApiEnvelope.error(status, policy(status));
  }

  // Non-Dio errors → friendly fallback
  final status = _fallback();
  return ApiEnvelope.error(status, policy(status));
}
