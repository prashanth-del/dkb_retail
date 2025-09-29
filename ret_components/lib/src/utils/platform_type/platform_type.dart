import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:network_info_plus/network_info_plus.dart';

class PlatformType {
  final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  final networkInfo = NetworkInfo();

  Future<String> getPlatformType({required double shortestSide}) async {

    if (Platform.isAndroid) {
      return shortestSide > 600 ? 'tablet' : 'android';
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      if (iosInfo.model.toLowerCase().contains('ipad')) {
        return 'ipad';
      }
      return 'ios';
    } else if (Platform.isLinux) {
      return 'linux';
    } else if (Platform.isMacOS) {
      return 'macos';
    } else if (Platform.isWindows) {
      return 'windows';
    } else {
      return 'unknown';
    }
  }
}
