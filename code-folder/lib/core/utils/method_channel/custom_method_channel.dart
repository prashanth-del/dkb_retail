import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'method_channel_interface.dart';

class CustomMethodChannel extends MethodChannelPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('dbc.method.channel');

  @override
  Future<String?> clearClipboard() async {
    return await methodChannel.invokeMethod<String>('clearClipboard');
  }

  @override
  Future<String?> encryptCode({required Map<String, String> toEncrypt}) async {
    return await methodChannel.invokeMethod<String>('encPayload', toEncrypt);
  }

  @override
  Future<String?> decryptPayload({required Map<String, String> toDecrypt}) async {
    return await methodChannel.invokeMethod<String>('decPayload', toDecrypt);
  }

  @override
  Future<bool> detectVpn() async {
    try {
      final value = await methodChannel.invokeMethod<bool>('detectVPN');
      if(value != null) {
        return value;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
