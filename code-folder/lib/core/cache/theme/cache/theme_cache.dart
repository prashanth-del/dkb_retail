import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart' show FlutterSecureStorage;
import '../../../theme/domain/brand.dart';

class ThemeCache {
  ThemeCache._();
  static final instance = ThemeCache._();

  static const _boxName    = 'theme_box';
  static const _kBrandKey  = 'theme_brand_key';
  static const _kThemeBlob = 'theme_blob_json';

  Box<String>? _box;

  /// Call once during boot (before reads).
  Future<void> init({bool encrypted = false}) async {
    await Hive.initFlutter();
    if (_box?.isOpen == true) return;

    if (!encrypted) {
      _box = await Hive.openBox<String>(_boxName);
      return;
    }

    const storage = FlutterSecureStorage();
    String? b64Key = await storage.read(key: '$_boxName.key');
    b64Key ??= base64Encode(Hive.generateSecureKey());
    await storage.write(key: '$_boxName.key', value: b64Key);

    _box = await Hive.openBox<String>(
      _boxName,
      encryptionCipher: HiveAesCipher(base64Decode(b64Key)),
    );
  }

  // ---------- enum helpers ----------
  Future<void> saveBrandEnum(Brand brand) async => _box!.put(_kBrandKey, brand.key);
  Future<Brand?> readBrandEnum() async {
    final v = _box!.get(_kBrandKey);
    return v == null ? null : BrandX.fromKey(v);
  }

  // ---------- theme blob ----------
  Future<void> saveThemeMap(Map<String, dynamic> map) async =>
      _box!.put(_kThemeBlob, jsonEncode(map));

  Future<Map<String, dynamic>?> readThemeMap() async {
    final s = _box!.get(_kThemeBlob);
    return s == null ? null : (jsonDecode(s) as Map<String, dynamic>);
  }
}
