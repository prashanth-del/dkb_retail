import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../network/network_client_provider.dart';
import '../../data/datasource/forgot_password_datasource.dart';
import '../../data/repository/forgot_password_repository_impl.dart';
import '../repositories/forgot_password_repository.dart';

final forgotPasswordDatasourceProvider = Provider<ForgotPasswordDatasource>((
  ref,
) {
  final client = ref.watch(networkClientProvider);
  return ForgotPasswordDatasourceImpl(networkClient: client);
});

final forgotPasswordRepoProvider = Provider<ForgotPasswordRepository>((ref) {
  final ds = ref.watch(forgotPasswordDatasourceProvider);
  return ForgotPasswordRepositoryImpl(ds);
});
