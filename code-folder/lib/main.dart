import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'bootstrap.dart';

Future<void> main() async {
  // Catch Flutter framework errors
  FlutterError.onError = (details) {
    FlutterError.dumpErrorToConsole(details);
    // TODO: report to Crashlytics/Sentry
    print('Dumping error: $details');
  };

  // Catch all other zone errors
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();

    // System UI
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
    ));

    await bootstrap();
  }, (error, stack) {
    if (kDebugMode) {
      // ignore: avoid_print
      print('Uncaught: $error\n$stack');
    }
    // TODO: send to crashlytics/sentry
  });
}