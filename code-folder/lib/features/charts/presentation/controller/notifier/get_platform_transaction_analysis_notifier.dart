import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/entity/platform_transaction_entity.dart';
import '../../../domain/entity/request/transaction_filter_req.dart';
import '../../../domain/locator/dashboard_locator.dart';

part 'get_platform_transaction_analysis_notifier.g.dart';

@riverpod
class GetPlatformTransactionAnalysisNotifier
    extends _$GetPlatformTransactionAnalysisNotifier {
  @override
  FutureOr<PlatformTransactionAnalysisEntity> build() {
    return future;
  }

  fetch(TransactionFilterReq req) async {
    state = const AsyncLoading();
    final failureOrSuccess = await ref
        .read(dashboardRepoProvider)
        .getPlatformTransactionMetrixAnalysis(req);
    state = failureOrSuccess.fold(
        (error) => AsyncError(error, StackTrace.current),
        (data) => AsyncData(data));
  }
}
