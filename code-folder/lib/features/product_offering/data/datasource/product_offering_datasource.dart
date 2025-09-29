// Data source for product_offering — implement your API calls here.
import 'package:dkb_retail/features/product_offering/data/models/apply_products_dto.dart';
import 'package:dkb_retail/network/data/api_mapper.dart';
import 'package:dkb_retail/network/data/execute_api_call.dart';
import 'package:dkb_retail/network/data/model/app_status.dart';
import 'package:dkb_retail/network/data/network_client.dart';
import 'package:dkb_retail/network/data/urls/products_url.dart';
import 'package:dkb_retail/network/domain/models/api_envelope.dart';
import 'package:dkb_retail/network/domain/models/api_error.dart';
import 'package:logger/logger.dart';

part 'src/get_products.dart';

abstract class ProductOfferingDataSource {
  // Example:
  // Future<Map<String, dynamic>> login({required String username, required String password});
  Future<ApiEnvelope<List<ApplyProductsDto>>> getProducts();
}

class ProductOfferingDatasourceImpl extends ProductOfferingDataSource {
  final NetworkClient networkClient;

  ProductOfferingDatasourceImpl({required this.networkClient});
  @override
  Future<ApiEnvelope<List<ApplyProductsDto>>> getProducts() {
    return _getProduct(networkClient);
  }
}
