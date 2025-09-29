import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'custom_method_channel.dart';

abstract class MethodChannelPlatform extends PlatformInterface {
  MethodChannelPlatform() : super(token: _token);

  static final Object _token = Object();
  static MethodChannelPlatform _instance = CustomMethodChannel();

  static MethodChannelPlatform get instance => _instance;

  static set instance(MethodChannelPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> clearClipboard() {
    throw UnimplementedError("clearClipboard() is not implemented");
  }

  Future<String?> encryptCode({required Map<String, String> toEncrypt}){
    throw UnimplementedError("encryptCode() is not implemented");
  }

  Future<String?> decryptPayload({required Map<String, String> toDecrypt}) async {
    throw UnimplementedError("decryptPayload() is not implemented");
  }

  Future<bool> detectVpn() async {
    throw UnimplementedError("detectVPN() is not implemented");
  }
}
