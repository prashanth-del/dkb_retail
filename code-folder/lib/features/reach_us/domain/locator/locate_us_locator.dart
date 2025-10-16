import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../network/network_client_provider.dart';
import '../../data/datasource/locate_us_datasource.dart';
import '../../data/repository/locate_us_repo_impl.dart';
import '../repository/locate_us_repository.dart';

final locateUsDatasourceProvider = Provider<LocateUsDataSource>((ref) {
  final networkClient = ref.watch(networkClientProvider); // read
  return LocateUsDataSourceImpl(
    networkClient: networkClient,
  ); // return validationAccountModel
});

final locateUsRepositoryprovider = Provider<LocateUsRepository>((ref) {
  final datasource = ref.watch(locateUsDatasourceProvider);
  return LocateUsRepositoryImpl(datasource); //return Entity
});
