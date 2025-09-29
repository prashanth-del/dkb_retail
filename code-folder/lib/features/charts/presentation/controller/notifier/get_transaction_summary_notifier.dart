import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/entity/request/transaction_filter_req.dart';
import '../../../domain/entity/transaction_summary_entity.dart';
import '../../../domain/locator/dashboard_locator.dart';

part 'get_transaction_summary_notifier.g.dart';

@riverpod
class GetTransactionSummaryNotifier extends _$GetTransactionSummaryNotifier {
  @override
  FutureOr<TransactionSummaryEntity> build() {
    return future;
  }

  fetch(TransactionFilterReq req) async {
    state = const AsyncLoading();
    final failureOrSuccess =
        await ref.read(dashboardRepoProvider).getTransactionSummary(req);
    state = failureOrSuccess.fold(
        (error) => AsyncError(error, StackTrace.current),
        (data) => AsyncData(data));
  }
}
