import 'package:dkb_retail/features/onboarding/data/model/onboarding_stage_sum_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entity/onboarding_retrieve_journey_entity.dart';

final isFromPassportPageProvider = StateProvider<bool>((ref) => false);
final isFromSignatureVerifiedProvider = StateProvider<bool>((ref) => false);
final isFrontCardImageProvider = StateProvider<String>((ref) => "");
final isSubmittedRequestProvider = StateProvider<bool>((ref) => false);

final getQidNumber = StateProvider<String>((ref) => "");
final getMobileNumber = StateProvider<String>((ref) => "");

final retrieveJourneyProvider = StateProvider<OnboardingRetrieveJourneyEntity?>(
  (ref) {
    return null; // Initial state is null
  },
);

final stageSumProvider = StateProvider<List<StageData>?>((ref) {
  return null; // Initial state is null
});

final qidDetailsProvider = StateProvider<Map<String, dynamic>>((ref) {
  return {}; // Initial state is null
});

StageData? getStageById(WidgetRef ref, String stageId) {
  final stageSum = ref.read(stageSumProvider);

  if (stageSum == null) {
    return null; // No data available
  }

  // Use `firstWhere` safely
  return stageSum.firstWhere((stage) => stage.stageId == stageId);
}

StageData? getStageByPriority(WidgetRef ref, int priority) {
  final stageSum = ref.read(stageSumProvider);

  if (stageSum == null) {
    return null; // No data available
  }

  // Use `firstWhere` safely
  return stageSum.firstWhere((stage) => stage.priority == priority);
}

final customerJourneyId = StateProvider<int>((ref) => 0);
final scanAgainAttemptsProvider = StateProvider<int>((ref) => 0);
final retakeSelfieAttemptsProvider = StateProvider<int>((ref) => 0);

final searchProvider = StateProvider.autoDispose((ref) => '');

final getEmploymentStatusForStudHomeRetired = StateProvider<bool>(
  (ref) => false,
);

class CurrentStageNotifier extends StateNotifier<int> {
  CurrentStageNotifier() : super(1); // Start with the first stage

  void moveToNextStage() {
    state++; // Increment to the next stage
  }
}

final currentStageProvider = StateNotifierProvider<CurrentStageNotifier, int>((
  ref,
) {
  return CurrentStageNotifier();
});
