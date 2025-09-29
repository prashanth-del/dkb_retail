import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:db_uicomponents/components.dart';
import '../../../../core/utils/method_channel/custom_method_channel.dart';
import '../entity/security_threat.dart';
import '../module/overlay_protection.dart';

class DeviceSecurityService {

  Future<SecurityThreat> detectSecurityThreat() async {
    if (Platform.isIOS) {
      final isVpnDetected = await detectIosVpn();
      if (isVpnDetected) {
        return const SecurityThreat.vpnDetected();
      }
    }

    final securityStatus = await UiDeviceSecurityChecker.isDeviceSecure();

    if (securityStatus == null) {
      return const SecurityThreat.noThreat();
    }

    late SecurityThreat threat;

    switch (securityStatus) {
      case DeviceSecurityErrorType.rooted:
        threat = const SecurityThreat.rooted();
        break;
      case DeviceSecurityErrorType.vpnDetected:
        threat = const SecurityThreat.vpnDetected();
        break;
      case DeviceSecurityErrorType.developerModeEnabled:
        threat = const SecurityThreat.developerModeEnabled();
        break;
      case DeviceSecurityErrorType.usbDebuggingEnabled:
        threat = const SecurityThreat.debuggingEnabled();
        break;
      case DeviceSecurityErrorType.notRealDevice:
        threat = const SecurityThreat.notRealDevice();
        break;
      case DeviceSecurityErrorType.untrustedKeyboardDetected:
        threat = const SecurityThreat.untrustedKeyboardDetected();
        break;
      default:
        threat = const SecurityThreat.noThreat();
        break;
    }

    return threat;
  }

  Future<bool> detectIosVpn() async {
    CustomMethodChannel customMethodChannel = CustomMethodChannel();
    return await customMethodChannel.detectVpn();
  }

  Future<SecurityThreat> noInternetFound() async {
    final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
    bool notConnected = connectivityResult.contains(ConnectivityResult.none);
    if(notConnected) {
      return const SecurityThreat.noInternet();
    } else {
      return const SecurityThreat.noThreat();
    }
  }

  Future<void> hideOverlay() async {
    await OverlayProtection.hideOverlay();
  }

}