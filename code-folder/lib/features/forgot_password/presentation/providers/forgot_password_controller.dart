import 'package:dkb_retail/features/forgot_password/presentation/providers/state/forgot_password_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../registration/domain/entities/card_validation_modal.dart';

final activeCardProvider = Provider<List<CardValidationModal>>((ref) {
  final data = ref.watch(forgotPasswordNotifierProvider);

  return data.maybeWhen(
    success: (cardList) => cardList as List<CardValidationModal>,
    loading: () => [],
    orElse: () => [],
  );
});
