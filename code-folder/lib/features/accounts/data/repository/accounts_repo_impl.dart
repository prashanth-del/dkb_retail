import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/typedefs.dart';
import '../../domain/entity/account_summary_entity.dart';
import '../../domain/repository/accounts_repository.dart';
import '../datasource/accounts_datasource.dart';

class AccountsRepoImpl implements AccountsRepository {
  final AccountsDatasource datasource;

  AccountsRepoImpl({required this.datasource});

  @override
  ResultEither<AccountSummaryEntity> getAccountSummary(
      {required Map<String, dynamic> requestBody}) async {
    try {
      final response =
          await datasource.getAccountSummary(requestBody: requestBody);
      final accountSummary = response;
      return Either.right(accountSummary.toDomain());
    } on ServiceException catch (e) {
      return Either.left(ServiceFailure(e.message));
    }
  }
}
