import 'package:dkb_retail/features/onboarding/data/datasource/onboarding_datasource.dart';
import 'package:dkb_retail/features/onboarding/domain/entity/onboarding_block_check_entity.dart';
import 'package:dkb_retail/features/onboarding/domain/entity/onboarding_retrieve_journey_entity.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/typedefs.dart';
import '../../domain/entity/onboarding_block_journey_entity.dart';
import '../../domain/entity/onboarding_create_journey_entity.dart';
import '../../domain/entity/onboarding_file_upload_entity.dart';
import '../../domain/entity/onboarding_save_stage_data_entity.dart';
import '../../domain/entity/onboarding_stage_sum_entity.dart';
import '../../domain/entity/onboarding_update_account_entity.dart';
import '../../domain/repository/onboarding_repository.dart';

class OnboardingRepositoryImpl extends OnboardingRepository {
  final OnboardingDatasource onboardingDataSource;
  OnboardingRepositoryImpl(this.onboardingDataSource);

  @override
  ResultEither<OnboardingBlockCheckEntity> getBlockCheck() async {
    try {
      final response = await onboardingDataSource.getBlockCheck();
      final cardSummary = response;
      return Either.right(cardSummary.toDomain());
    } on ServiceException catch (e) {
      return Either.left(ServiceFailure(e.message));
    }
  }

  @override
  ResultEither<OnboardingStageSumEntity> getStageSum() async {
    try {
      final response = await onboardingDataSource.getStageSum();
      final cardSummary = response;
      return Either.right(cardSummary.toDomain());
    } on ServiceException catch (e) {
      return Either.left(ServiceFailure(e.message));
    }
  }

  @override
  ResultEither<OnboardingSaveStageDataEntity> saveStageData({
    required int custJourneyId,
    required String stageId,
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await onboardingDataSource.saveStageData(
        custJourneyId: custJourneyId,
        stageId: stageId,
        data: data,
      );
      final cardSummary = response;
      return Either.right(cardSummary.toDomain());
    } on ServiceException catch (e) {
      return Either.left(ServiceFailure(e.message));
    }
  }

  @override
  ResultEither<OnboardingUpdateAccountEntity> updateAccount({
    required int custJourneyId,
    required String accountNumber,
  }) async {
    try {
      final response = await onboardingDataSource.updateAccount(
        custJourneyId: custJourneyId,
        accountNumber: accountNumber,
      );
      final data = response;
      return Either.right(data.toDomain());
    } on ServiceException catch (e) {
      return Either.left(ServiceFailure(e.message));
    }
  }

  @override
  ResultEither<OnboardingCreateJourneyEntity> createJourney({
    required String nationalId,
    required String mobileNumber,
  }) async {
    try {
      final response = await onboardingDataSource.createJourney(
        nationalId: nationalId,
        mobileNumber: mobileNumber,
      );
      final data = response;
      return Either.right(data.toDomain());
    } on ServiceException catch (e) {
      return Either.left(ServiceFailure(e.message));
    }
  }

  @override
  ResultEither<OnboardingRetrieveJourneyEntity> retrieveJourney({
    required String nationalId,
    required String mobileNumber,
  }) async {
    try {
      final response = await onboardingDataSource.retrieveJourney(
        nationalId: nationalId,
        mobileNumber: mobileNumber,
      );
      final data = response;
      return Either.right(data.toDomain());
    } on ServiceException catch (e) {
      return Either.left(ServiceFailure(e.message));
    }
  }

  @override
  ResultEither<OnboardingBlockJourneyEntity> blockJourney({
    required String mobileNumber,
    required String blockPeriod,
    required String nationalId,
    required String blockReason,
  }) async {
    try {
      final response = await onboardingDataSource.blockJourney(
        mobileNumber: mobileNumber,
        blockPeriod: blockPeriod,
        nationalId: nationalId,
        blockReason: blockReason,
      );
      final summary = response;
      return Either.right(summary.toDomain());
    } on ServiceException catch (e) {
      return Either.left(ServiceFailure(e.message));
    }
  }

  @override
  ResultEither<OnboardingFileUploadEntity> sendFileUpload({
    required String fileExtension,
    required String fileSize,
    required String nationalId,
    required String mobileNumber,
    required String fileType,
    required String fileBase64,
  }) async {
    try {
      final response = await onboardingDataSource.sendFileUpload(
        fileExtension: fileExtension,
        fileSize: fileSize,
        nationalId: nationalId,
        mobileNumber: mobileNumber,
        fileType: fileType,
        fileBase64: fileBase64,
      );
      final summary = response;
      return Either.right(summary.toDomain());
    } on ServiceException catch (e) {
      return Either.left(ServiceFailure(e.message));
    }
  }
}
