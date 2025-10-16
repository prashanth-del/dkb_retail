import 'package:dkb_retail/common/utils.dart';
import 'package:dkb_retail/features/registration/domain/locator/card_validations_locator.dart';
import 'package:dkb_retail/features/registration/domain/repository/card_validation_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'registration_notifiers.g.dart';

@riverpod
class RegistrationNotifier extends _$RegistrationNotifier {
  @override
  FutureOr<dynamic> build() async {
    return future;
  }

  CardValidationRepository get _cardvalidationrepository =>
      ref.read(cardValidationsRepoProvider);

  Future<void> getCardValidations() async {
    // ref.read(productsloadingProvider.notifier).state = true;
    state = const AsyncLoading();
    final failureOrSuccess = await _cardvalidationrepository
        .getCardValidations();

    // ref.read(productsloadingProvider.notifier).state = false;
    state = failureOrSuccess.fold(
      (l) => AsyncError(l.message, StackTrace.current),
      (r) {
        consoleLog('card validation success $r');
        return AsyncData(r);
      },
    );
  }
}
