import 'package:dartz/dartz.dart';

import '../../../../../network/domain/models/api_error.dart'
    show ApiError, ApiErrorX;
import '../../../domain/entities/bank_products.dart';
import '../../../domain/entities/create_lead_of_products.dart';
import '../../../domain/entities/sub_products_images.dart';
import '../../../domain/repositories/product_offering_repository.dart';
import '../../datasource/product_offering_datasource.dart';
import '../../models/bank_products_dto.dart';
import '../../models/create_lead_of_products_dto.dart';
import '../../models/fetch_apply_products_request.dart';
import '../../models/get_sub_products_imgs_request.dart';
import '../../models/sub_products_images_dto.dart';

class ProductOfferingRepositoryImpl implements ProductOfferingRepository {
  final ProductOfferingDataSource datasource;
  //final ProductOfferingDatasource datasource;

  ProductOfferingRepositoryImpl(this.datasource);
  @override
  Future<Either<ApiError, List<BankProducts>>> fetchApplyProducts({
    required FetchApplyProductsRequest request,
  }) async {
    final env = await datasource.fetchApplyProducts(request: request);
    if (!env.ok) return left(ApiErrorX.fromEnvelope(env));
    // if (!env.ok) return left(ApiError(description: env.status.description));
    final mapped =
        env.data?.map((e) => e.toEntity()).toList() ?? const <BankProducts>[];
    return right(mapped);
  }

  @override
  Future<Either<ApiError, List<CreateLeadOfProducts>>> createLeadApplyProducts({
    required dynamic request,
  }) async {
    final env = await datasource.createLeadApplyProducts(request: request);
    if (!env.ok) return left(ApiErrorX.fromEnvelope(env));
    final mapped =
        env.data?.map((e) => e.toEntity()).toList() ??
        const <CreateLeadOfProducts>[];
    return right(mapped);
  }

  @override
  Future<Either<ApiError, List<SubProductsImages>>> getSubProductsImgs({
    required GetSubProductsImgsRequest request,
  }) async {
    final env = await datasource.getSubProductsImgs(request: request);
    if (!env.ok) return left(ApiErrorX.fromEnvelope(env));
    final mapped =
        env.data?.map((e) => e.toEntity()).toList() ??
        const <SubProductsImages>[];
    return right(mapped);
  }
}
