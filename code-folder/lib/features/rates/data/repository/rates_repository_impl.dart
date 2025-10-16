import 'package:dartz/dartz.dart';
import '../../../../network/domain/models/api_envelope.dart';
import '../../../../network/domain/models/api_error.dart';
import '../../data/datasource/rates_datasource.dart';
import '../../data/models/fx_rates_model/fx_rates_dto.dart';
import '../../data/models/fx_rates_model/get_fx_rates_request.dart';
import '../../domain/entities/fx_rates.dart';
import '../../domain/entities/profit_rates.dart';
import '../../domain/repository/rates_repository.dart';
import '../models/profit_rates_model/get_profit_rates_request.dart';
import '../models/profit_rates_model/profit_rates_dto.dart';

class RatesRepositoryImpl implements RatesRepository {
  final RatesDatasource datasource;

  RatesRepositoryImpl(this.datasource);

  @override
  Future<Either<ApiError, List<FxRates>>> getFxRates({
    required GetFxRatesRequest request,
  }) async {
    try {
      final ApiEnvelope<List<FxRatesDto>> env =
      await datasource.getFxRates(request: request);

      if (!env.ok) {
        return left(ApiErrorX.fromEnvelope(env));
      }

      final List<FxRates> mapped =
          env.data?.map((dto) => dto.toEntity()).toList() ?? [];

      return right(mapped);
    } catch (e, s) {
      // Fallback error handling
      return left(ApiError(description: e.toString()));
    }
  }

  @override
  Future<Either<ApiError, List<ProfitRates>>> getProfitRates({
    required GetProfitRatesRequest request,
  }) async {
    try {
      final ApiEnvelope<List<ProfitRatesDto>> env =
      await datasource.getProfitRates(request: request);

      if (!env.ok) {
        return left(ApiErrorX.fromEnvelope(env));
      }

      final List<ProfitRates> mapped =
          env.data?.map((dto) => dto.toEntity()).toList() ?? [];

      return right(mapped);
    } catch (e, s) {
      // Fallback error handling
      return left(ApiError(description: e.toString()));
    }
  }
}
