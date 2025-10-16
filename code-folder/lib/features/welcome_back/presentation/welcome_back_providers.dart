import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../network/network_client_provider.dart';
import '../data/datasource/welcome_back_datasource.dart';
import '../data/repositories/impl/welcome_back_repository_impl.dart';
import '../domain/repositories/welcome_back_repository.dart';

final welcomeBackDatasourceProvider = Provider<WelcomeBackDatasource>((ref) {
  final client = ref.watch(networkClientProvider);
  return WelcomeBackDatasource(client);
});

final welcomeBackRepoProvider = Provider<WelcomeBackRepository>((ref) {
  final ds = ref.watch(welcomeBackDatasourceProvider);
  return WelcomeBackRepositoryImpl(ds);
});
