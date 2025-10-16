import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/create_biometric.dart';

part 'register_biometric_state.freezed.dart';

@freezed
class RegisterBiometricState with _$RegisterBiometricState {
  const factory RegisterBiometricState.initial() = _Initial;
  const factory RegisterBiometricState.loading() = _Loading;
  const factory RegisterBiometricState.success(CreateBiometric? data) = _Success;
  const factory RegisterBiometricState.failure(String message) = _Failure;
}
