import 'package:dkb_retail/core/errors/failures.dart';
import 'package:dkb_retail/features/login/domain/repository/login_failure.dart';
import 'package:dkb_retail/features/onboarding/domain/entity/onboarding_retrieve_journey_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../login/presentation/controller/login_providers.dart';
import '../../../domain/locator/onboarding_locator.dart';
import '../../../domain/repository/onboarding_repository.dart';
import 'onboarding_retrieve_journey_state.dart';

part 'onboarding_retrieve_journey_notifier.g.dart';

@riverpod
class GetOnboardingRetrieveJourneyNotifier
    extends _$GetOnboardingRetrieveJourneyNotifier {
  @override
  FutureOr<OnboardingRetrieveJourneyEntity> build() async {
    fetch();
    return future;
  }

  fetch({
    String nationalId = "1234781876",
    String mobileNumber = "7655369933",
  }) async {
    state = const AsyncLoading();
    final data = await ref
        .read(onboardingRepository)
        .retrieveJourney(nationalId: nationalId, mobileNumber: mobileNumber);
    state = data.fold(
      (l) => AsyncError(l.message, StackTrace.current),
      (r) => AsyncData(r),
    );
  }

  // @override
  // OnboardingRetrieveJourneyState build() {
  //   return const OnboardingRetrieveJourneyState.initial();
  // }
  //
  // OnboardingRepository get _repository => ref.read(onboardingRepository);
  //
  // Future<void> retrieveJourney({
  //   required String nationalId,
  //   required String mobileNumber,
  // }) async {
  //   ref.read(loadingProvider.notifier).state = true;
  //   state = const OnboardingRetrieveJourneyState.loading();
  //   final failureOrSuccess = await _repository.retrieveJourney(
  //     nationalId: "1234781876",
  //     mobileNumber: "7655369933",
  //   );
  //
  //   state = failureOrSuccess.fold(
  //         (failures) {
  //       ref.read(loadingProvider.notifier).state = false;
  //       return OnboardingRetrieveJourneyState.failure(switch (failures) {
  //         // ServiceFailure(message: var m) => m,
  //         InternetFailure(message: var m) => m,
  //         ServerFailure(message: var m) => m,
  //         InvalidOtp() => '',
  //         MaxOtpAttempted(message: var m) => m,
  //         // TODO: Handle this case.
  //         Failure() => throw UnimplementedError(),
  //       });
  //     },
  //         (user) {
  //       ref.read(loadingProvider.notifier).state = false;
  //
  //       // Only create UserProfile if userId and customerNumber are not null
  //       // if (user.userId != null && user.customerNumber != null) {
  //       //   final userProfile = UserProfile(
  //       //     userName: user.userId!,
  //       //     customerNumber: user.customerNumber!,
  //       //     dcUserName: user.dcUserName,
  //       //     userRole: mapStringToUserRoleType(user.userRole),
  //       //   );
  //       //
  //       //   ref.read(userProfileProvider.notifier).updateUserProfile(userProfile);
  //       // }
  //
  //       return OnboardingRetrieveJourneyState.success(user);
  //     },
  //   );
  // }
}
