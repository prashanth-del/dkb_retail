import 'package:dkb_retail/features/onboarding/domain/entity/onboarding_block_check_entity.dart';
import 'package:dkb_retail/features/onboarding/domain/entity/onboarding_save_stage_data_entity.dart';
import 'package:dkb_retail/features/onboarding/domain/locator/onboarding_locator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../cards/domain/locator/cards_locator.dart';
import '../../../domain/entity/onboarding_stage_sum_entity.dart';

part 'onboarding_save_stage_data_notifier.g.dart';

@riverpod
class OnboardingSaveStageDataNotifier
    extends _$OnboardingSaveStageDataNotifier {
  @override
  FutureOr<OnboardingSaveStageDataEntity> build() async {
    // fetch(field: field, type: type);
    return future;
  }

  Future<bool> fetch({
    required int custJourneyId,
    required String stageId,
    required Map<String, dynamic> data,
  }) async {
    state = const AsyncLoading();
    final response = await ref
        .read(onboardingRepository)
        .saveStageData(
          custJourneyId: custJourneyId,
          stageId: stageId,
          data: data,
        );
    return response.fold(
      (failure) {
        state = AsyncError(failure.message, StackTrace.current);
        return false;
      },
      (result) {
        state = AsyncData(result);
        return true;
      },
    );
  }
}
