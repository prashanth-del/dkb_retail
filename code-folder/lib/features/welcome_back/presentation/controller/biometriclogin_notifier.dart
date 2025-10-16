import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dartz/dartz.dart';
import '../state/biometriclogin_state.dart';
import '../../domain/repositories/welcome_back_repository.dart';
import '../welcome_back_providers.dart';
import '../../data/models/biometriclogin_request.dart';

part 'biometriclogin_notifier.g.dart';

@riverpod
class BiometricloginNotifier extends _$BiometricloginNotifier {
  @override
  BiometricloginState build() => const BiometricloginState.initial();

  WelcomeBackRepository get _repo => ref.read(welcomeBackRepoProvider);

    Future<void> biometriclogin({ required BiometricloginRequest request, }) async {
    state = const BiometricloginState.loading();
    final result = await _repo.biometriclogin(request: request);

    result.fold(
      (err) => state = BiometricloginState.failure(err.description ?? err.mwdesc ?? 'Server Error!'),
      (data) {
        state = BiometricloginState.success(data);
      },
    );
  }
}
