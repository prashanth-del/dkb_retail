import 'package:db_uicomponents/src/styles/dynamic_theme/data/models/app_theme.dart';
import 'package:dkb_retail/core/theme/data/datasource/theme_datasource.dart';
import '../../../../network/data/api_mapper.dart';
import '../../../../network/data/execute_api_call.dart';
import '../../../../network/data/network_client.dart';
import '../../../../network/domain/models/api_envelope.dart';
import '../../domain/brand.dart';

// TODO: put your real URL
class RemoteThemeDatasource implements ThemeDatasource {
  final NetworkClient client;
  RemoteThemeDatasource(this.client);

  @override
  Future<ApiEnvelope<AppTheme>> getBrandTheme(Brand brand) {
    final dio = client.baseDio;
    return executeApiCall<AppTheme>(
      call: () => dio.post('/theme', data: {'brand': brand.key}),
      mapJson: (json) => ApiMapper.mapData<AppTheme>(json, (data) {
        // API returns { data: {...AppTheme json...} }
        return AppTheme.fromJson((data as Map).cast<String, dynamic>());
      }),
    );
  }
}
