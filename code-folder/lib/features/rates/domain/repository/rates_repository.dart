import 'package:dartz/dartz.dart';
import 'package:dkb_retail/features/rates/domain/entities/profit_rates.dart';
import '../../../../network/domain/models/api_error.dart';
import '../../data/models/fx_rates_model/get_fx_rates_request.dart';
import '../../data/models/profit_rates_model/get_profit_rates_request.dart';
import '../entities/fx_rates.dart';

abstract class RatesRepository {
  Future<Either<ApiError, List<FxRates>>> getFxRates({ required GetFxRatesRequest request, });
  Future<Either<ApiError, List<ProfitRates>>> getProfitRates({ required GetProfitRatesRequest request, });
}
