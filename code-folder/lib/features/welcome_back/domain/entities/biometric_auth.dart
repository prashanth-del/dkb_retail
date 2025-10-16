import 'package:freezed_annotation/freezed_annotation.dart';


part 'biometric_auth.freezed.dart';

@freezed
class BiometricAuth with _$BiometricAuth {
  const factory BiometricAuth({
    required bool success,
    required String message,
    required String token,
    required String userId,
    required String domainId,
    required String userType,
    required String deviceId,
    required dynamic deviceName,
    required String imei,
  }) = _BiometricAuth;
}
