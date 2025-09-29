import 'dart:io';

import 'package:db_uicomponents/src/utils/device_info/src/device_model.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:network_info_plus/network_info_plus.dart';

class DeviceInfo {
  final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  final networkInfo = NetworkInfo();
  final String appVer;
  final String endToEndId;

  DeviceInfo({required this.appVer, required this.endToEndId});

  static Future<String> getDeviceModel({required BuildContext context}) async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    DeviceInfoPlugin deviceInfo2 = DeviceInfoPlugin();
    deviceInfo2.deviceInfo.then(
      (value) {
        final deviceData = value.data;
        debugPrint("device data ${deviceData.toString()}");
      },
    );
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.utsname.machine;
    } else if (Theme.of(context).platform == TargetPlatform.android) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.model;
    } else {
      return "Unknown Device";
    }
  }

  Future<DeviceModel?> deviceType() async {
    String? ip = await _fetchIp();

    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        return DeviceModel(
            deviceType: androidInfo.model,
            devicePlatform: 'android',
            deviceId: androidInfo.id,
            ipAddress: ip ?? '127.0.0.1',
            vendorId: androidInfo.id,
            osVersion: androidInfo.version.baseOS,
            appVersion: appVer,
            endToEndId: endToEndId);
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        return DeviceModel(
            deviceType: iosInfo.modelName,
            devicePlatform: 'iPhone',
            deviceId: iosInfo.identifierForVendor,
            ipAddress: ip ?? '127.0.0.1',
            vendorId: iosInfo.identifierForVendor,
            osVersion: iosInfo.systemVersion,
            appVersion: appVer,
            endToEndId: endToEndId);
      } else {
        return null;
      }
    } on PlatformException {
      debugPrint('Error Exception : ');
      return null;
    } catch (e) {
      debugPrint('Error : $e');
      return null;
    }
  }

  Future<String?> _fetchIp() async {
    try {
      final ipAddress = await networkInfo.getWifiIP();
      return ipAddress;
    } catch (e) {
      return '127.0.0.1';
    }
  }
}
