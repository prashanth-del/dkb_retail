// Repository implementation for product_offering — bridge Data -> Domain.
import 'package:dartz/dartz.dart';
import 'package:dkb_retail/core/errors/failures.dart';
import 'package:dkb_retail/features/product_offering/data/datasource/product_offering_datasource.dart';
import 'package:dkb_retail/features/product_offering/data/models/apply_products_dto.dart';
import 'package:dkb_retail/features/product_offering/domain/entities/apply_products.dart';

import '../../domain/repository/product_offering_repository.dart';
// import '../datasource/product_offering_datasource.dart';

class ProductOfferingRepositoryImpl implements ProductOfferingRepository {
  final ProductOfferingDataSource productOfferingDataSource;

  ProductOfferingRepositoryImpl({required this.productOfferingDataSource});

  @override
  Future<Either<Failure, List<ApplyProducts>>> getProductOffering() async {
    // TODO: implement myProducts
    // throw UnimplementedError();
    try {
      final response = await productOfferingDataSource.getProducts();

      // if (!response.ok) {
      //   return left(ServiceFailure(response.status.description.toString()));
      // }
      // consoleLog('api status: ${response.appStatus}');
      // consoleLog('api message: ${response.message}');

      final data = response.data;
      if (data == null) {
        return left(ServiceFailure(response.status.description.toString()));
      }
      final entities = data
          .map((dto) => dto.toEntity())
          .toList(growable: false);
      // Convert DTO to domain

      return right(entities);
    } catch (e) {
      return left(ServiceFailure(e.toString()));
    }
  }
}
