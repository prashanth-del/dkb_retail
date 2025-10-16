import 'package:dartz/dartz.dart';
import 'package:dkb_retail/features/reach_us/data/models/bank_info_dto.dart';
import 'package:dkb_retail/features/reach_us/data/models/callback_fields_dto.dart';
import 'package:dkb_retail/features/reach_us/data/models/locate_us_info_dto.dart';

import '../../../../../network/domain/models/api_error.dart'
    show ApiError, ApiErrorX;
import '../../../domain/entities/bank_info.dart';
import '../../../domain/entities/call_back_request.dart';
import '../../../domain/entities/callback_fields.dart';
import '../../../domain/entities/faqs.dart';
import '../../../domain/entities/locate_us_info.dart';
import '../../../domain/repositories/reach_us_repository.dart';
import '../../datasource/reach_us_datasource.dart';
import '../../models/call_back_request_dto.dart';
import '../../models/faqs_dto.dart';
import '../../models/fetch_bank_info_request.dart';
import '../../models/fetch_call_back_request_request.dart';
import '../../models/fetch_callback_fields_request.dart';
import '../../models/fetch_faq_request.dart';
import '../../models/fetch_locate_us_info_request.dart';

class ReachUsRepositoryImpl implements ReachUsRepository {
  final ReachUsDatasource datasource;
  ReachUsRepositoryImpl(this.datasource);
  @override
  Future<Either<ApiError, Faqs>> fetchFaq({
    required FetchFaqRequest request,
  }) async {
    final env = await datasource.fetchFaq(request: request);
    if (!env.ok) return left(ApiErrorX.fromEnvelope(env));
    final mapped = env.data?.toEntity();
    if (mapped == null) return left(ApiErrorX.fromEnvelope(env));
    return right(mapped);
  }

  // @override
  // Future<Either<ApiError, List<CallbackFields>>> fetchCallbackFields({
  //   required FetchCallbackFieldsRequest request,
  // }) async {
  //   final env = await datasource.fetchCallbackFields(request: request);
  //   if (!env.ok) return left(ApiErrorX.fromEnvelope(env));
  //   final mapped =
  //       env.data?.map((e) => e.toEntity()).toList() ?? const <CallbackFields>[];
  //   return right(mapped);
  // }

  @override
  Future<Either<ApiError, List<CallBackRequest>>> fetchCallBackRequest({
    required FetchCallBackRequestRequest request,
  }) async {
    final env = await datasource.fetchCallBackRequest(request: request);
    if (!env.ok) return left(ApiErrorX.fromEnvelope(env));
    final mapped =
        env.data?.map((e) => e.toEntity()).toList() ??
        const <CallBackRequest>[];
    return right(mapped);
  }

  @override
  Future<Either<ApiError, BankInfo>> fetchBankInfo({
    required FetchBankInfoRequest request,
  }) async {
    final env = await datasource.fetchBankInfo(request: request);
    if (!env.ok) return left(ApiErrorX.fromEnvelope(env));
    final mapped = env.data?.toEntity();
    if (mapped == null) return left(ApiErrorX.fromEnvelope(env));
    return right(mapped);
  }

  @override
  Future<Either<ApiError, List<LocateUsInfo>>> fetchLocateUsInfo({
    required FetchLocateUsInfoRequest request,
  }) async {
    final env = await datasource.fetchLocateUsInfo(request: request);
    if (!env.ok) return left(ApiErrorX.fromEnvelope(env));
    final mapped =
        env.data?.map((e) => e.toEntity()).toList() ?? const <LocateUsInfo>[];
    return right(mapped);
  }

  @override
  Future<Either<ApiError, List<CallbackFields>>> fetchCallbackFields({
    required FetchCallbackFieldsRequest request,
  }) async {
    final env = await datasource.fetchCallbackFields(request: request);
    if (!env.ok) return left(ApiErrorX.fromEnvelope(env));
    final mapped =
        env.data?.map((e) => e.toEntity()).toList() ?? const <CallbackFields>[];
    return right(mapped);
  }
}
