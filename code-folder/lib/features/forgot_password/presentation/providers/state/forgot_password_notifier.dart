import 'package:dkb_retail/features/forgot_password/domain/locator/forgot_password_locator.dart';
import 'package:dkb_retail/features/forgot_password/domain/repositories/forgot_password_repository.dart';
import 'package:dkb_retail/features/forgot_password/presentation/state/forgot_password_state.dart';
import 'package:dkb_retail/features/registration/domain/locator/card_validations_locator.dart';
import 'package:dkb_retail/features/registration/domain/repository/card_validation_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'forgot_password_notifier.g.dart';

@riverpod
class ForgotPasswordNotifier extends _$ForgotPasswordNotifier {
  @override
  ForgotPasswordState build() {
    return const ForgotPasswordState.initial();
  }

  CardValidationRepository get _cardValidationrepo =>
      ref.read(cardValidationsRepoProvider);
  ForgotPasswordRepository get _forgotPasswordrepo =>
      ref.read(forgotPasswordRepoProvider);

  Future<void> getActiveCards() async {
    state = ForgotPasswordState.loading();
    final failureOrSuccess = await _cardValidationrepo.getCardValidations();

    // ref.read(productsloadingProvider.notifier).state = false;
    state = failureOrSuccess.fold(
      (l) => ForgotPasswordState.failure(l.message),
      (activeCardList) {
        return ForgotPasswordState.success(activeCardList);
      },
    );
  }

  Future<void> validateCard({
    required String cardNumber,
    required String cardPin,
  }) async {
    state = ForgotPasswordState.loading();
    final failureOrSuccess = await _forgotPasswordrepo.validateCard(
      cardNumber: cardNumber,
      cardPin: cardPin,
    );

    state = failureOrSuccess.fold(
      (l) => ForgotPasswordState.failure(l.message),
      (activeCardList) {
        return ForgotPasswordState.cardValidated(activeCardList);
      },
    );
  }
}
