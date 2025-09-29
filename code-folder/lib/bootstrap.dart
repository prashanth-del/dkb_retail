import 'package:dkb_retail/startup/start_up/presentation/pages/app_root.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/constants/build_enviornment/build_environment.dart';
import '../init_dependencies.dart';
import '../core/i18n/i18n_binder.dart';

Future<void> bootstrap() async {
  await AppConfig.initializeAsync();
  await initCache();

  // Lock orientation (if you want it here globally)
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    const ProviderScope(
      child: I18nBinder(
        child: AppRoot(),
      ),
    ),
  );
}
