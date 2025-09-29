import 'package:dkb_retail/features/onboarding/domain/entity/onboarding_block_check_entity.dart';
import 'package:dkb_retail/features/onboarding/domain/entity/onboarding_file_upload_entity.dart';
import 'package:dkb_retail/features/onboarding/domain/locator/onboarding_locator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../cards/domain/locator/cards_locator.dart';

part 'onboarding_file_upload_notifier.g.dart';

@riverpod
class GetOnboardingFileUploadNotifier
    extends _$GetOnboardingFileUploadNotifier {
  bool isFrontUploaded = false;
  bool isBackUploaded = false;

  @override
  FutureOr<OnboardingFileUploadEntity> build() async {
    // fetch(field: field, type: type);
    return future;
  }

  Future<bool> fetch({
    required String imageType,
    required String fileExtension,
    required String fileSize,
    required String nationalId,
    required String mobileNumber,
    required String fileType,
    required String fileBase64,
  }) async {
    state = const AsyncLoading();
    final data = await ref
        .read(onboardingRepository)
        .sendFileUpload(
          fileExtension: fileExtension,
          fileSize: fileSize,
          nationalId: nationalId,
          mobileNumber: mobileNumber,
          fileType: fileType,
          fileBase64: fileBase64,
        );
    return data.fold(
      (failure) {
        state = AsyncError(failure.message, StackTrace.current);
        return false;
      },
      (result) {
        state = AsyncData(result);
        return true;
      },
    );
    // state = data.fold(
    //       (l) => AsyncError(l.message, StackTrace.current),
    //       (r) {
    //     // Update the corresponding upload flag
    //     if (imageType == "front") {
    //       isFrontUploaded = true;
    //     } else if (imageType == "back") {
    //       isBackUploaded = true;
    //     }
    //         return AsyncData(r);
    //       },
    // );
  }
}

@riverpod
class GetOnboardingSelfieUploadNotifier
    extends _$GetOnboardingSelfieUploadNotifier {
  @override
  FutureOr<OnboardingFileUploadEntity> build() async {
    // fetch(field: field, type: type);
    return future;
  }

  fetch({
    required String imageType,
    required String fileExtension,
    required String fileSize,
    required String nationalId,
    required String mobileNumber,
    required String fileType,
    required String fileBase64,
  }) async {
    state = const AsyncLoading();
    final data = await ref
        .read(onboardingRepository)
        .sendFileUpload(
          fileExtension: fileExtension,
          fileSize: fileSize,
          nationalId: nationalId,
          mobileNumber: mobileNumber,
          fileType: fileType,
          fileBase64: fileBase64,
        );
    state = data.fold((l) => AsyncError(l.message, StackTrace.current), (r) {
      // Update the corresponding upload flag
      return AsyncData(r);
    });
  }
}
