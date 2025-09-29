import '../../../../network/data/api_mapper.dart';
import '../../../../network/data/execute_api_call.dart';
import '../../../../network/data/network_client.dart';
import '../../../../network/data/urls/i18n.dart';
import '../../../../network/domain/models/api_envelope.dart';
import '../../domain/entity/i18n_asset.dart';
import 'i18n_datasource.dart';

class RemoteI18nDatasource implements I18nDatasource {
  RemoteI18nDatasource(this.client);
  final NetworkClient client;

  @override
  Future<ApiEnvelope<I18nAsset>> getLocaleAsset(String localeId) {
    final dio = client.baseDio;

    return executeApiCall<I18nAsset>(
      call: () => dio.post(
        i18nUrl.labelUrl,
        data: const {},
      ),
      mapJson: (json) => ApiMapper.mapData<I18nAsset>(
        json,
            (data) {
          final normalized = normalizeToI18AndValidation({'data': data});
          return I18nAsset(normalized);
        },
      ),
    );
  }
}
