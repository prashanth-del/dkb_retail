import 'package:dkb_retail/features/onboarding/domain/entity/onboarding_block_check_entity.dart';
import 'package:dkb_retail/features/onboarding/domain/locator/onboarding_locator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../cards/domain/locator/cards_locator.dart';
import '../../../domain/entity/onboarding_stage_sum_entity.dart';

part 'onboarding_stage_sum_notifier.g.dart';

@riverpod
class GetOnboardingStageSumNotifier extends _$GetOnboardingStageSumNotifier {
  @override
  FutureOr<OnboardingStageSumEntity> build() async {
    // fetch(field: field, type: type);
    return future;
  }

  fetch() async {
    state = const AsyncLoading();
    final data = await ref.read(onboardingRepository).getStageSum();
    state = data.fold(
      (l) => AsyncError(l.message, StackTrace.current),
      (r) => AsyncData(r),
    );
  }
}
