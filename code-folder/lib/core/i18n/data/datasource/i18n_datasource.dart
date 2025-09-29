import '../../../../network/domain/models/api_envelope.dart';
import '../../domain/entity/i18n_asset.dart';

abstract class I18nDatasource {
  Future<ApiEnvelope<I18nAsset>> getLocaleAsset(String localeId);
}

/// Accepts ONLY:
/// {
///   "data": {
///     "i18": { ... },            // Map
///     "validations": { ... }     // Map
///   }
/// }
/// Returns:
/// { "i18": {...}, "validation": {...} }
Map<String, dynamic> normalizeToI18AndValidation(Object? raw) {
  if (raw is! Map) {
    throw const FormatException("Root must be a Map with key 'data'.");
  }

  final data = raw['data'];
  if (data is! Map) {
    throw const FormatException("Missing or invalid 'data' (must be a Map).");
  }

  final i18 = data['i18'];
  final validations = data['validation'];

  if (i18 is! Map) {
    throw const FormatException("Missing or invalid 'data.i18' (must be a Map).");
  }
  if (validations is! Map) {
    throw const FormatException("Missing or invalid 'data.validations' (must be a Map).");
  }

  final i18Out = _toStringKeyedDeep(i18);
  final validationOut = _toStringKeyedDeep(validations);

  return {'i18': i18Out, 'validation': validationOut};
}

Map<String, dynamic> _toStringKeyedDeep(Map input) {
  final out = <String, dynamic>{};
  input.forEach((k, v) {
    final key = k.toString();
    if (v is Map) {
      out[key] = _toStringKeyedDeep(v);
    } else if (v is List) {
      out[key] = v.map((e) => e is Map ? _toStringKeyedDeep(e) : e).toList();
    } else {
      out[key] = v;
    }
  });
  return out;
}


