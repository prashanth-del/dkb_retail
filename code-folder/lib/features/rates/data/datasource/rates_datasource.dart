import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:logger/logger.dart';
import '../../../../common/utils.dart';
import '../../../../network/data/api_mapper.dart';
import '../../../../network/data/execute_api_call.dart';
import '../../../../network/data/model/app_status.dart';
import '../../../../network/data/network_client.dart';
import '../../../../network/data/urls/specialFxRate.dart';
import '../../../../network/domain/models/api_envelope.dart';
import '../../../../network/domain/models/api_error.dart';
import '../models/fx_rates_model/fx_rates_dto.dart';
import '../models/fx_rates_model/get_fx_rates_request.dart';
import '../models/profit_rates_model/get_profit_rates_request.dart';
import '../models/profit_rates_model/profit_rates_dto.dart';

part 'src/fx_rates.dart';

part 'src/profit_rates.dart';

abstract class RatesDatasource {
  Future<ApiEnvelope<List<FxRatesDto>>> getFxRates({
    required GetFxRatesRequest request,
  });

  Future<ApiEnvelope<List<ProfitRatesDto>>> getProfitRates({
    required GetProfitRatesRequest request,
  });
}

class RatesDatasourceImpl implements RatesDatasource {
  RatesDatasourceImpl({required this.networkClient});

  final NetworkClient networkClient;

  @override
  Future<ApiEnvelope<List<FxRatesDto>>> getFxRates({
    required GetFxRatesRequest request,
  }) {
    return _getFxRates(networkClient, request);
  }

  @override
  Future<ApiEnvelope<List<ProfitRatesDto>>> getProfitRates({
    required GetProfitRatesRequest request,
  }) {
    return _getProfitRates(networkClient, request);
  }
}
