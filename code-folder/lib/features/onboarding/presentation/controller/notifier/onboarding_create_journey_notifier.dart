import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entity/onboarding_create_journey_entity.dart';
import '../../../domain/locator/onboarding_locator.dart';

part 'onboarding_create_journey_notifier.g.dart';

@riverpod
class GetOnboardingCreateJourneyNotifier extends _$GetOnboardingCreateJourneyNotifier {
  @override
  FutureOr<OnboardingCreateJourneyEntity> build() async {
    // fetch();
    return future;
  }

  fetch({String nationalId = "1234781876", String mobileNumber = "7655369933"}) async {
    state = const AsyncLoading();
    final data = await ref
        .read(onboardingRepository)
        .createJourney(nationalId: nationalId, mobileNumber: mobileNumber);
    state = data.fold(
          (l) => AsyncError(l.message, StackTrace.current),
          (r) => AsyncData(r),
    );
  }

}


