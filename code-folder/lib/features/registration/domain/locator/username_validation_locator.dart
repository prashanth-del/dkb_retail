import 'package:dkb_retail/features/registration/data/datasource/username_validations_datasource.dart';
import 'package:dkb_retail/features/registration/data/repository/username_rules_repo_impl.dart';
import 'package:dkb_retail/features/registration/domain/repository/username_rules_repository.dart';
import 'package:dkb_retail/network/network_client_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final usernameValidationDatasourceProvider =
    Provider<UsernameValidationsDatasource>((ref) {
      final client = ref.watch(networkClientProvider);

      return UsernameValidationsDatasourceImpl(client: client);
    });

final usernameValidationsRepoProvider = Provider<UsernameRulesRepository>((
  ref,
) {
  final usernameValidationDatasource = ref.watch(
    usernameValidationDatasourceProvider,
  );

  return UsernameRulesRepoImpl(
    usernameValidationsDatasource: usernameValidationDatasource,
  );
});
