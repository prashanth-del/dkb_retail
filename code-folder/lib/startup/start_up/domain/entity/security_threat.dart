import 'package:freezed_annotation/freezed_annotation.dart';

part 'security_threat.freezed.dart';

@freezed
class SecurityThreat with _$SecurityThreat {
  const factory SecurityThreat.noInternet() = _NoInternet;
  const factory SecurityThreat.rooted() = _Rooted;
  const factory SecurityThreat.vpnDetected() = _VpnDetected;
  const factory SecurityThreat.developerModeEnabled() =
      _DeveloperModeEnabled;
  const factory SecurityThreat.debuggingEnabled() =
      _DebuggingEnabled;
  const factory SecurityThreat.notRealDevice() = _NotRealDevice;
  const factory SecurityThreat.untrustedKeyboardDetected() =
      _UntrustedKeyboardDetected;
  const factory SecurityThreat.noThreat() = _NoThreat;

}

String getMessage({required SecurityThreat securityThreat, required String localeId}) {
  return securityThreat.when(
    noInternet: () => localeId == 'ar'
        ? "يبدو أنك غير متصل بالإنترنت. يرجى التحقق من اتصالك بالإنترنت والمحاولة مرة أخرى. تأكد من تمكين شبكة Wi-Fi أو بيانات الهاتف المحمول لديك لمواصلة استخدام التطبيق."
        : "It seems you’re offline. Please check your internet connection and try again. Ensure your Wi-Fi or mobile data is enabled to continue using the app.",
    rooted: () => localeId == 'ar' ? "This device is rooted or does not minimum requirement to launch Dukhan Bank Corporate Application." : "This device is rooted or does not minimum requirement to launch Dukhan Bank Corporate Application.",
    vpnDetected: () =>
    localeId == 'ar' ? "VPN is detected. Please disable VPN and Relaunch Dukhan Bank Corporate Application." : "VPN is detected. Please disable VPN and Relaunch Dukhan Bank Corporate Application.",
    developerModeEnabled: () =>
    localeId == 'ar' ? "Developer Mode is enabled. Please turn off Developer Mode and Relaunch Dukhan Bank Corporate Application." : "Developer Mode is enabled. Please turn off Developer Mode and Relaunch Dukhan Bank Corporate Application.",
    debuggingEnabled: () => localeId == 'ar'
        ? "USB debugging is enabled. Please turn off USB debugging and Relaunch Dukhan Bank Corporate Application."
        : "USB debugging is enabled. Please turn off USB debugging and Relaunch Dukhan Bank Corporate Application.",
    notRealDevice: () =>
    localeId == 'ar' ? "This device does not meet the requirements to launch Dukhan Bank Corporate Application." : "This device does not meet the requirements to launch Dukhan Bank Corporate Application.",
    untrustedKeyboardDetected: () => localeId == 'ar'
        ? "Untrusted Keyboard detected. Please uninstall the untrusted keyboard and relaunch Tadbeer App"
        : "Untrusted Keyboard detected. Please uninstall the untrusted keyboard and relaunch Tadbeer App",
    noThreat: () =>
    localeId == 'ar' ? "No security threat detected." : "No security threat detected.",
  );
}
