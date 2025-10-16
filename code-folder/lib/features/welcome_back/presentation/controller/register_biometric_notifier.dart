import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../state/register_biometric_state.dart';
import '../../domain/repositories/welcome_back_repository.dart';
import '../welcome_back_providers.dart';
import '../../data/models/register_biometric_request.dart';

part 'register_biometric_notifier.g.dart';

@riverpod
class RegisterBiometricNotifier extends _$RegisterBiometricNotifier {
  @override
  RegisterBiometricState build() => const RegisterBiometricState.initial();

  WelcomeBackRepository get _repo => ref.read(welcomeBackRepoProvider);

  Future<void> registerBiometric({
    required RegisterBiometricRequest request,
  }) async {
    state = const RegisterBiometricState.loading();
    final result = await _repo.registerBiometric(request: request);

    result.fold(
      (err) => state = RegisterBiometricState.failure(
        err.description ?? err.mwdesc ?? 'Server Error!',
      ),
      (data) {
        state = RegisterBiometricState.success(data);
      },
    );
  }
}
