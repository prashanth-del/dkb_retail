//reach_us_notifier

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/locator/reach_us_locator.dart';

part 'reach_us_notifier.g.dart';

@riverpod
class GetLoansDashResponse extends _$GetLoansDashResponse {
  @override
  FutureOr<dynamic> build() async {
    //await fetchLoansDashResponse();
    return future;
  }

  Future<void> fetchLoansDashResponse({
    String field = "assetsType",
    String type = "asc",
  }) async {
    final result = await ref
        .read(reachUsRepositoryprovider)
        .getTestEntity(requestBody: {}); // Add actual request body if needed

    result.fold(
      (l) => state = AsyncError(l.message, StackTrace.current),
      (r) => state = AsyncData(r),
    );
  }
}
