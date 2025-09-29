typedef JsonMap = Map<String, dynamic>;

class I18nAsset {
  /// Always: { "i18": {...}, "validation": {...} } with String keys.
  final JsonMap raw;

  I18nAsset(Map normalized)
      : raw = {
    'i18': Map<String, dynamic>.from(
        (normalized['i18'] is Map) ? normalized['i18'] as Map : const {}),
    'validation': Map<String, dynamic>.from((normalized['validation'] is Map)
        ? normalized['validation'] as Map
        : const {}),
  };

  late final Map<String, String> _flatI18 =
  _flatten(raw['i18'] as Map<String, dynamic>);

  String text(String path, {String fallback = ''}) => _flatI18[path] ?? fallback;

  String validation(String key, {String fallback = ''}) {
    final v = raw['validation'];
    if (v is Map<String, dynamic>) {
      final s = v[key];
      if (s is String) return s;
    }
    return fallback;
  }

  Map<String, String> _flatten(Map<String, dynamic> m, [String prefix = '']) {
    final out = <String, String>{};
    m.forEach((k, v) {
      final p = prefix.isEmpty ? k : '$prefix.$k';
      if (v is Map) {
        out.addAll(_flatten(Map<String, dynamic>.from(v), p));
      } else if (v is String) {
        out[p] = v;
      } else if (v != null) {
        out[p] = v.toString();
      }
    });
    return out;
  }
}

extension I18nAssetExt on I18nAsset {
  bool get hasI18n => raw['i18'] is Map && (raw['i18'] as Map).isNotEmpty;
}
