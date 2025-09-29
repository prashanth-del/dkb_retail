// Domain repository interface for product_offering.
import 'package:dartz/dartz.dart';
import 'package:dkb_retail/core/errors/failures.dart';
import 'package:dkb_retail/features/product_offering/domain/entities/apply_products.dart';

abstract class ProductOfferingRepository {
  // Define the methods your presentation/domain will use.
  // Example:

  Future<Either<Failure, List<ApplyProducts>>> getProductOffering();
}
