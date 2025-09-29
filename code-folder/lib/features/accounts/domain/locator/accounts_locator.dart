import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../network/network_client_provider.dart';
import '../../data/datasource/accounts_datasource.dart';
import '../../data/repository/accounts_repo_impl.dart';
import '../repository/accounts_repository.dart';

// part 'accounts_locator.g.dart';

// @riverpod
// AccountsDatasource accountsDatasourceLocator(AccountsDatasourceLocatorRef ref) {
//   return AccountsDatasourceImpl(networkClient: ref.read(networkClientProvider));
// }
//
// @riverpod
// AccountsRepository accountsRepositoryLocator(AccountsRepositoryLocatorRef ref) {
//   return AccountsRepoImpl(datasource: ref.watch(accountsDatasourceLocatorProvider));
// }

final accountsDatasource = Provider<AccountsDatasource>((ref) {
  final networkClient = ref.watch(networkClientProvider);
  return AccountsDatasourceImpl(networkClient: ref.read(networkClientProvider));
});

final accountsRepository = Provider<AccountsRepository>((ref) {
  final datasource = ref.watch(accountsDatasource);
  return AccountsRepoImpl(datasource: datasource);
});
