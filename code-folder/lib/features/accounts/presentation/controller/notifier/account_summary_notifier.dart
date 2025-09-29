import 'package:dkb_retail/features/accounts/domain/locator/accounts_locator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/entity/account_summary_entity.dart';

part 'account_summary_notifier.g.dart';

@riverpod
class GetAccountSummary extends _$GetAccountSummary {
  @override
  FutureOr<AccountSummaryEntity> build() async {
    fetch();
    return future;
  }

  Future<void> fetch({
    String field = "accountType",
    String type = "asc",
  }) async {
    state = const AsyncLoading();
    final requestBody = {"field": field, "type": type};

    final data = await ref
        .read(accountsRepository)
        .getAccountSummary(requestBody: requestBody);
    state = data.fold(
      (l) => AsyncError(l.message, StackTrace.current),
      (r) => AsyncData(r),
    );
  }
}
