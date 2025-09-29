import 'src/db_platform_interface.dart';

class DbChannel {
  Future<String?> getPlatformVersion() {
    return DbPlatformInterface.instance.getPlatformVersion();
  }

  Future<String?> encrypt({required Map<String, String> toEncrypt}) async {
    return DbPlatformInterface.instance.encrypt(toEncrypt: toEncrypt);
  }

  Future<String?> decryptPayLoad({required Map<String, String> toDecrypt}) async {
    return DbPlatformInterface.instance.decryptPayLoad(toDecrypt: toDecrypt);
  }

  Future<bool> detectVpn() async {
    return DbPlatformInterface.instance.detectVpn();
  }
}
