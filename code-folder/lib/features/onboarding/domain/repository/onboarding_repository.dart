import 'package:dkb_retail/features/onboarding/domain/entity/onboarding_block_check_entity.dart';

import '../../../../core/utils/typedefs.dart';
import '../entity/onboarding_block_journey_entity.dart';
import '../entity/onboarding_create_journey_entity.dart';
import '../entity/onboarding_file_upload_entity.dart';
import '../entity/onboarding_retrieve_journey_entity.dart';
import '../entity/onboarding_save_stage_data_entity.dart';
import '../entity/onboarding_stage_sum_entity.dart';
import '../entity/onboarding_update_account_entity.dart';

abstract class OnboardingRepository {
  ResultEither<OnboardingBlockCheckEntity> getBlockCheck(
    // {
    // required String deviceId,
    // }
  );

  ResultEither<OnboardingStageSumEntity> getStageSum();
  ResultEither<OnboardingSaveStageDataEntity> saveStageData({
    required int custJourneyId,
    required String stageId,
    required Map<String, dynamic> data,
  });
  ResultEither<OnboardingUpdateAccountEntity> updateAccount({
    required int custJourneyId,
    required String accountNumber,
  });

  ResultEither<OnboardingCreateJourneyEntity> createJourney({
    required String nationalId,
    required String mobileNumber,
  });

  ResultEither<OnboardingRetrieveJourneyEntity> retrieveJourney({
    required String nationalId,
    required String mobileNumber,
  });

  ResultEither<OnboardingFileUploadEntity> sendFileUpload({
    required String fileExtension,
    required String fileSize,
    required String nationalId,
    required String mobileNumber,
    required String fileType,
    required String fileBase64,
  });

  ResultEither<OnboardingBlockJourneyEntity> blockJourney({
    required String mobileNumber,
    required String blockPeriod,
    required String nationalId,
    required String blockReason,
  });
}
