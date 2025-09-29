import 'package:hive_flutter/hive_flutter.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'core/cache/adapter/auth_tokens_adapter.dart';
import 'core/cache/global_cache.dart';
import 'core/cache/locale_cache.dart';
import 'core/cache/theme/cache/theme_cache.dart';
import 'core/constants/build_enviornment/build_environment.dart';

Future<void> initCache() async {
  final docs = await getApplicationDocumentsDirectory();
  final flavor = AppConfig.shared.flavor.name; // 'dev' or 'uat'
  final hiveDir = p.join(docs.path, 'hive_$flavor');  // isolates data per flavor
  await Hive.initFlutter(hiveDir);

  _registerHiveAdapters();

  await GlobalCache.init();
  await LocaleCache.init();
  await ThemeCache.instance.init();
}

void _registerHiveAdapters() {
  // Ensure all custom adapters are here
  // Example for AuthTokens:
  if (!Hive.isAdapterRegistered(AuthTokensAdapter().typeId)) {
    Hive.registerAdapter(AuthTokensAdapter());
  }
  // Add any other adapters similarly
}
