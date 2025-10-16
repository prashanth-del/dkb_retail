import 'package:dartz/dartz.dart';

import '../../../../network/domain/models/api_error.dart';
import '../../data/models/fetch_bank_info_request.dart';
import '../../data/models/fetch_call_back_request_request.dart';
import '../../data/models/fetch_callback_fields_request.dart';
import '../../data/models/fetch_faq_request.dart';
import '../../data/models/fetch_locate_us_info_request.dart';
import '../entities/bank_info.dart';
import '../entities/call_back_request.dart';
import '../entities/callback_fields.dart';
import '../entities/faqs.dart';
import '../entities/locate_us_info.dart';

abstract class ReachUsRepository {
  Future<Either<ApiError, Faqs>> fetchFaq({required FetchFaqRequest request});
  // Future<Either<ApiError, List<CallbackFields>>> fetchCallbackFields({
  //   required FetchCallbackFieldsRequest request,
  // });
  Future<Either<ApiError, List<CallBackRequest>>> fetchCallBackRequest({
    required FetchCallBackRequestRequest request,
  });
  Future<Either<ApiError, BankInfo>> fetchBankInfo({
    required FetchBankInfoRequest request,
  });
  Future<Either<ApiError, List<LocateUsInfo>>> fetchLocateUsInfo({
    required FetchLocateUsInfoRequest request,
  });
  Future<Either<ApiError, List<CallbackFields>>> fetchCallbackFields({
    required FetchCallbackFieldsRequest request,
  });
}
