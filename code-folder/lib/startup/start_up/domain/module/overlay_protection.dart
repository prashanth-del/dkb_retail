import 'package:flutter/services.dart';

import '../../../../common/utils.dart';

class OverlayProtection {
  static const MethodChannel _channel = MethodChannel('overlay_protection_channel');


  static Future<bool> isOverlayActive() async {
    try {
      final bool result = await _channel.invokeMethod('isOverlayActive');
      return result;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> isAppInForeground() async {
    try {
      final bool result = await _channel.invokeMethod('isAppInForeground');
      return result;
    } catch (e) {
      return false;
    }
  }

  static Future<void> hideOverlay() async {
    try {
      await _channel.invokeMethod('hideOverlay');
    } catch (e) {
      consoleLog('Unable to hide overlay');
    }
  }
}