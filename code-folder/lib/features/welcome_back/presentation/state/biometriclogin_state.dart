import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/biometric_auth.dart';

part 'biometriclogin_state.freezed.dart';

@freezed
class BiometricloginState with _$BiometricloginState {
  const factory BiometricloginState.initial() = _Initial;
  const factory BiometricloginState.loading() = _Loading;
  const factory BiometricloginState.success(BiometricAuth? data) = _Success;
  const factory BiometricloginState.failure(String message) = _Failure;
}
