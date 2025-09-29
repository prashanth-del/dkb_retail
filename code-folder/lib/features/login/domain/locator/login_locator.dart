import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../network/network_client_provider.dart';
import '../../data/datasource/login_datasource.dart';
import '../../data/repository/login_repository_impl.dart';
import '../repository/login_repository.dart';

final loginDatasourceProvider = Provider<LoginDatasource>((ref) {
  final client = ref.watch(networkClientProvider);

  return LoginDatasourceImpl(networkClient: client);
});

final loginRepoProvider = Provider<LoginRepository>((ref) {
  final loginDatasource = ref.watch(loginDatasourceProvider);

  return LoginRepositoryImpl(loginDatasource);
});
