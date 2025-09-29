
import '../../../../core/utils/typedefs.dart';
import '../entity/account_summary_entity.dart';

abstract class AccountsRepository {

  ResultEither<AccountSummaryEntity> getAccountSummary(
      {required Map<String, dynamic> requestBody});

}
