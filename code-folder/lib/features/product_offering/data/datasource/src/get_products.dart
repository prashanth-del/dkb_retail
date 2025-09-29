part of '../product_offering_datasource.dart';

Future<ApiEnvelope<List<ApplyProductsDto>>> _getProduct(
  NetworkClient client,
) async {
  final logger = Logger();
  try {
    const productsUrl = ProductsUrl.applyProducts;
    // http://34.18.92.50:7575/products/retrieve-eligible-products
    final dio = client.customDio(
      authorizationRequired: false,
      screenId: 'LOGIN',
      serviceId: 'LOGIN',
      subModuleId: 'LGN',
      moduleId: 'LGN',
    );

    final loginBody = {};

    // return executeApiCall<List<ApplyProductsDto>>(
    //   call: () => dio.get(productsUrl),
    //   mapJson: (json) {
    //     return ApiMapper.mapList(
    //       json,
    //       (data) => ApplyProductsDto.fromJson(json),
    //     );
    //   },
    // );

    await Future.delayed(Duration(seconds: 2));

    var dummyData = {
      "status": {"code": "000000", "description": "SUCCESS"},
      "data": [
        {
          "productId": 1,
          "productName": "Credit Card",
          "productCategory": "Financial",
          "productImage": "credit_card.png",
          "active": true,
          "createdAt": "2025-09-11T14:42:18.214489Z",
          "updatedAt": "2025-09-11T14:42:18.214489Z",
          "subProducts": [
            {
              "subProductId": 1,
              "subProductName": "Platinum Credit Card",
              "subProductCategory": "Premium",
              "subProductImage": "platinum.png",
              "description": "High limit platinum card with rewards",
              "active": true,
              "createdAt": "2025-09-11T14:42:40.623393Z",
              "updatedAt": "2025-09-11T14:42:40.623393Z",
            },
            {
              "subProductId": 2,
              "subProductName": "Gold Credit Card",
              "subProductCategory": "Gold",
              "subProductImage": "gold.png",
              "description": "Gold credit card with cashback offers",
              "active": true,
              "createdAt": "2025-09-11T14:42:40.623393Z",
              "updatedAt": "2025-09-11T14:42:40.623393Z",
            },
          ],
        },
        {
          "productId": 2,
          "productName": "Debit Card",
          "productCategory": "Financial",
          "productImage": "debit_card.png",
          "active": true,
          "createdAt": "2025-09-11T14:42:18.214489Z",
          "updatedAt": "2025-09-11T14:42:18.214489Z",
          "subProducts": [
            {
              "subProductId": 3,
              "subProductName": "Salary Debit Card",
              "subProductCategory": "Basic",
              "subProductImage": "salary_debit.png",
              "description": "Debit card linked to salary account",
              "active": true,
              "createdAt": "2025-09-11T14:42:40.623393Z",
              "updatedAt": "2025-09-11T14:42:40.623393Z",
            },
          ],
        },
        {
          "productId": 3,
          "productName": "Loan",
          "productCategory": "Financial",
          "productImage": "loan.png",
          "active": true,
          "createdAt": "2025-09-11T14:42:18.214489Z",
          "updatedAt": "2025-09-11T14:42:18.214489Z",
          "subProducts": [
            {
              "subProductId": 4,
              "subProductName": "Home Loan",
              "subProductCategory": "Housing",
              "subProductImage": "home_loan.png",
              "description": "Long-term home loan with low interest",
              "active": true,
              "createdAt": "2025-09-11T14:42:40.623393Z",
              "updatedAt": "2025-09-11T14:42:40.623393Z",
            },
          ],
        },
        {
          "productId": 4,
          "productName": "Insurance",
          "productCategory": "Financial",
          "productImage": "insurance.png",
          "active": true,
          "createdAt": "2025-09-11T14:42:18.214489Z",
          "updatedAt": "2025-09-11T14:42:18.214489Z",
          "subProducts": [
            {
              "subProductId": 5,
              "subProductName": "Car Insurance",
              "subProductCategory": "Vehicle",
              "subProductImage": "car_insurance.png",
              "description": "Comprehensive car insurance plan",
              "active": true,
              "createdAt": "2025-09-11T14:42:40.623393Z",
              "updatedAt": "2025-09-11T14:42:40.623393Z",
            },
          ],
        },
        {
          "productId": 5,
          "productName": "Investment",
          "productCategory": "Financial",
          "productImage": "investment.png",
          "active": true,
          "createdAt": "2025-09-11T14:42:18.214489Z",
          "updatedAt": "2025-09-11T14:42:18.214489Z",
          "subProducts": [],
        },
      ],
    };

    // return ApiEnvelope.success(

    //   ApiError(code: '00000'),
    //   AppStatus.success,
    // );

    return ApiMapper.mapList<ApplyProductsDto>(
      dummyData,
      (data) => ApplyProductsDto.fromJson(data),
    );
  } catch (e, s) {
    logger.e("Login Error", error: e, stackTrace: s);
    return ApiEnvelope.error(
      const ApiError(description: 'Unable to fetch products'),
      AppStatus.error,
    );
  }
}
