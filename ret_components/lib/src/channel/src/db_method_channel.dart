import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'db_platform_interface.dart';

/// An implementation of [DbPlatformInterface] that uses method channels.
class DbMethodChannel extends DbPlatformInterface {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('db_uicomponents');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<String?> encrypt({required Map<String, String> toEncrypt}) async {
    final value =
        await methodChannel.invokeMethod<String>('encPayload', toEncrypt);

    return value;
  }

  @override
  Future<String?> decryptPayLoad(
      {required Map<String, String> toDecrypt}) async {
    final value =
        await methodChannel.invokeMethod<String>('decPayload', toDecrypt);

    return value;
  }

  @override
  Future<bool> detectVpn() async {
    try {
      final value = await methodChannel.invokeMethod<bool?>('detectVPN');
      if(value != null) {
        return value;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
