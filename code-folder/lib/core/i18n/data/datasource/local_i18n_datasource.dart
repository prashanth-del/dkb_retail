import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/foundation.dart' show compute;
import '../../../../network/data/model/app_status.dart';
import '../../../../network/domain/models/api_envelope.dart';
import '../../../../network/domain/models/api_error.dart';
import '../../domain/entity/i18n_asset.dart';
import 'i18n_datasource.dart';

Future<Map<String, dynamic>> _decodeMap(String s) async =>
    (json.decode(s) as Map<String, dynamic>);

class LocalI18nDatasource implements I18nDatasource {
  const LocalI18nDatasource();

  @override
  Future<ApiEnvelope<I18nAsset>> getLocaleAsset(String localeId) async {
    try {
      final path = 'assets/i18n/$localeId.json';
      const fallback = 'assets/i18n/static_labels.json';

      String jsonString;
      try {
        jsonString = await rootBundle.loadString(path);
      } catch (_) {
        jsonString = await rootBundle.loadString(fallback);
      }

      final raw = await compute(_decodeMap, jsonString);
      final normalized = normalizeToI18AndValidation(raw);

      return ApiEnvelope.success(
        I18nAsset(normalized),
        const ApiError(),
        AppStatus.success,
      );
    } catch (_) {
      return ApiEnvelope.error(
        const ApiError(description: 'i18n asset load failed'),
        AppStatus.error,
      );
    }
  }
}
