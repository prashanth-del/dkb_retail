import 'package:riverpod/riverpod.dart';

import '../../../../network/network_client_provider.dart';
import '../../data/datasource/dashboard_datasource.dart';
import '../../data/repository/dashboard_respository_impl.dart';

final dashboardDataSourceProvider = Provider((ref) {
  return DashboardDatasourceImpl(ref.watch(networkClientProvider));
});

final dashboardRepoProvider = Provider((ref) {
  return DashboardRespositoryImpl(ref.watch(dashboardDataSourceProvider));
});
