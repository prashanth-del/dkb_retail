import 'package:dartz/dartz.dart';

import '../../../../network/domain/models/api_error.dart';
import '../../data/models/fetch_apply_products_request.dart';
import '../../data/models/get_sub_products_imgs_request.dart';
import '../entities/bank_products.dart';
import '../entities/create_lead_of_products.dart';
import '../entities/sub_products_images.dart';

abstract class ProductOfferingRepository {
  Future<Either<ApiError, List<BankProducts>>> fetchApplyProducts({
    required FetchApplyProductsRequest request,
  });
  Future<Either<ApiError, List<CreateLeadOfProducts>>> createLeadApplyProducts({
    required dynamic request,
  });
  Future<Either<ApiError, List<SubProductsImages>>> getSubProductsImgs({
    required GetSubProductsImgsRequest request,
  });
}
