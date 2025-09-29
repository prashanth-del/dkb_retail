import 'dart:io' show Platform;
import 'package:flutter/services.dart';

enum Flavor { dev, uat, prod }

class AppConfig {
  final Flavor flavor;
  final String apiBaseUrl;

  AppConfig._(this.flavor, this.apiBaseUrl);

  static AppConfig? _i;
  static AppConfig get shared => _i!;

  /// Precedence:
  /// 1) --dart-define (API_BASE_URL, FLAVOR_NAME)
  /// 2) Native channel (BuildConfig/Info.plist via "app_config")
  /// 3) Safe defaults
  static Future<void> initializeAsync() async {
    Map<dynamic, dynamic>? nativeCfg;

    // 1) Read dart-defines (work on all platforms, including web)
    final ddFlavor = const String.fromEnvironment('FLAVOR_NAME', defaultValue: '');
    final ddBase   = const String.fromEnvironment('API_BASE_URL', defaultValue: '');

    // 2) Try native only on Android/iOS, ignore on web/desktop
    if (Platform.isAndroid || Platform.isIOS) {
      try {
        nativeCfg = await const MethodChannel('app_config')
            .invokeMethod<Map<dynamic, dynamic>>('getConfig');
      } catch (_) {
        // ignore; we’ll fall back
      }
    }

    // Resolve values with precedence
    final flavorName = (ddFlavor.isNotEmpty
        ? ddFlavor
        : (nativeCfg?['flavor']?.toString() ?? 'dev'))
        .toLowerCase();

    final baseUrl = (ddBase.isNotEmpty
        ? ddBase
        : (nativeCfg?['apiBaseUrl'] as String?) ?? 'https://www.example.com')
        .trim();

    final fl = switch (flavorName) {
      'uat' => Flavor.uat,
      'prod' => Flavor.prod,
      _ => Flavor.dev,
    };

    _i = AppConfig._(fl, _normalizeBaseUrl(baseUrl));
  }

  static String _normalizeBaseUrl(String url) {
    // add scheme if missing; fix common typos like "http:www.example.com"
    final trimmed = url.replaceAll(RegExp(r'^\s+|\s+$'), '');
    if (trimmed.startsWith('http://') || trimmed.startsWith('https://')) {
      return trimmed.endsWith('/') ? trimmed.substring(0, trimmed.length - 1) : trimmed;
    }
    final withScheme = 'https://$trimmed';
    return withScheme.endsWith('/') ? withScheme.substring(0, withScheme.length - 1) : withScheme;
  }
}
