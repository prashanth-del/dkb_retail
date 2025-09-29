import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../network/network_client_provider.dart';
import '../../data/datasource/reach_us_datasource.dart';
import '../../data/repository/reach_us_repository_impl.dart';
import '../repository/reach_us_repository.dart';

final reachUsDatasourceProvider = Provider<ReachUsDataSource>((ref) {
  final networkClient = ref.watch(networkClientProvider); // read
  return ReachUsDataSourceImpl(
    networkClient: networkClient,
  ); // return validationAccountModel
});

final reachUsRepositoryprovider = Provider<ReachUsRepository>((ref) {
  final datasource = ref.watch(reachUsDatasourceProvider);
  return ReachUsRepositoryImpl(datasource); //return Entity
});
