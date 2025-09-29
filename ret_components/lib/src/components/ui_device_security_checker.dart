import 'dart:io';
import 'package:db_uicomponents/channel.dart';
import 'package:flutter/services.dart';
import 'package:jailbreak_root_detection/jailbreak_root_detection.dart';

enum DeviceSecurityErrorType {
  rooted,
  vpnDetected,
  developerModeEnabled,
  usbDebuggingEnabled,
  notRealDevice,
  untrustedKeyboardDetected,
}

class UiDeviceSecurityChecker {
  static Future<bool> isDeviceRooted() async {
    return await JailbreakRootDetection.instance.isJailBroken;
  }

  static Future<bool> isVpnConnected() async {
    // if (Platform.isAndroid) {
    //   final dbComponentsPlugin = DbChannel();
    //   return await dbComponentsPlugin.detectVpn();
    // }
    return false;
  }

  static Future<bool> isDeveloperModeEnabled() async {
    if (Platform.isAndroid) {
      return await JailbreakRootDetection.instance.isDevMode;
    }
    return false;
  }

  static Future<bool> isUsbDebuggingEnabled() async {
    if (Platform.isAndroid) {
      return await JailbreakRootDetection.instance.isDebugged;
    }
    return false;
  }

  static Future<bool> isRealDevice() async {
    return await JailbreakRootDetection.instance.isRealDevice;
  }

  static Future<bool> checkTrustKeyboard() async{
    if(Platform.isIOS){
      return false;
    } else {
      const channel = MethodChannel('flavor');
      final isThirdParty = await channel.invokeMethod('checkUntrustedKeyBoard');
      return isThirdParty;
    }
  }


  static Future<DeviceSecurityErrorType?> isDeviceSecure() async {
    // final checks = {
    //   DeviceSecurityErrorType.rooted: isDeviceRooted,
    //   DeviceSecurityErrorType.vpnDetected: isVpnConnected,
    //   DeviceSecurityErrorType.developerModeEnabled: isDeveloperModeEnabled,
    //   DeviceSecurityErrorType.usbDebuggingEnabled: isUsbDebuggingEnabled,
    //   DeviceSecurityErrorType.notRealDevice: () async => !(await isRealDevice()),
    //   DeviceSecurityErrorType.untrustedKeyboardDetected: checkTrustKeyboard,
    // };
    //
    // for (var entry in checks.entries) {
    //   final errorType = entry.key;
    //   final check = entry.value;
    //
    //   if (await check()) {
    //     return errorType;
    //   }
    // }

    return null;
  }
}