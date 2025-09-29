import 'dart:developer';

import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../network/domain/models/api_response.dart';

setSystemBar({Color? color, Brightness? brightness}) {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: color ?? Colors.white,
      statusBarBrightness: brightness ?? Brightness.light,
      statusBarIconBrightness: brightness ?? Brightness.dark));
}

Future<String> getAppVersion() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  return packageInfo.version.toString();
}

void launchEmailApp(String email) async {
  final Uri params = Uri(
    scheme: 'mailto',
    path: email,
  );

  var url = params.toString();
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

Future<Object> getDeviceInfo() async {
  String appVer = await getAppVersion();
  DeviceModel? deviceModel =
      await DeviceInfo(appVer: appVer, endToEndId: '').deviceType();
  if (deviceModel == null) {
    return ApiResponse(error: 'Unable to fetch device info');
  }
  return deviceModel.toJson();
}

consoleLog(dynamic message){
  if(kDebugMode){
    log("$message");
  }
}
