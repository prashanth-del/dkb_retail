import 'package:hive/hive.dart';

class LocaleCache {
  LocaleCache._(this._box);
  final Box<dynamic> _box;

  static late final LocaleCache _instance;
  static LocaleCache get instance => _instance;

  static const String _boxName = 'localeBox';
  static const String _localeKey = 'locale';
  static const String _localeAssetKey2 = 'localeAsset2';
  static const String _localeAssetKey = 'localeAsset';

  static Future<void> init() async {
    final box = await Hive.openBox<dynamic>(_boxName);
    _instance = LocaleCache._(box);
  }

  T _getValue<T>(dynamic key, {T? defaultValue}) =>
      _box.get(key, defaultValue: defaultValue) as T;

  Future<void> _setValue<T>(dynamic key, T value) => _box.put(key, value);

  // Locale
  String getLocaleId() => _getValue(_localeKey, defaultValue: 'en');
  Future<void> setLocaleId(String localeId) => _setValue(_localeKey, localeId);

  // Locale Asset
  dynamic getLocaleAsset() => _getValue(_localeAssetKey, defaultValue: {});
  Future<void> setLocaleAsset(dynamic asset) =>
      _setValue(_localeAssetKey, asset);
}