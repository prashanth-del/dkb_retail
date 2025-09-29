import 'package:dkb_retail/features/onboarding/domain/entity/onboarding_block_check_entity.dart';
import 'package:dkb_retail/features/onboarding/domain/entity/onboarding_block_journey_entity.dart';
import 'package:dkb_retail/features/onboarding/domain/entity/onboarding_file_upload_entity.dart';
import 'package:dkb_retail/features/onboarding/domain/locator/onboarding_locator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../cards/domain/locator/cards_locator.dart';

part 'onboarding_block_journey_notifier.g.dart';

@riverpod
class OnboardingBlockJourneyNotifier extends _$OnboardingBlockJourneyNotifier {
  @override
  FutureOr<OnboardingBlockJourneyEntity> build() async {
    // fetch(field: field, type: type);
    return future;
  }

  fetch({
    required String mobileNumber,
    required String blockPeriod,
    required String nationalId,
    required String blockReason,
  }) async {
    state = const AsyncLoading();
    final data = await ref
        .read(onboardingRepository)
        .blockJourney(
          mobileNumber: mobileNumber,
          blockPeriod: blockPeriod,
          nationalId: nationalId,
          blockReason: blockReason,
        );
    state = data.fold(
      (l) => AsyncError(l.message, StackTrace.current),
      (r) => AsyncData(r),
    );
  }
}
