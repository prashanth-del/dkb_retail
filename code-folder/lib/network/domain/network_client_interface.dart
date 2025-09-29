import 'package:dio/dio.dart';

abstract class NetworkClientInterface {
  /// Gets the base Dio client instance.
  Dio get baseDio;

  /// Creates a custom Dio client with specified headers.
  ///
  /// Parameters:
  /// - [serviceId] (optional): The ID of the service.
  /// - [authorizationRequired]: A boolean indicating if the Authorization header is required.
  /// - [moduleId] (optional): The module ID.
  /// - [subModuleId] (optional): The sub-module ID.
  /// - [screenId] (optional): The screen ID.
  /// - [customerId]: The ID of the customer.
  ///
  /// Returns a [Dio] instance with the specified headers.
  Dio customDio({
    String? serviceId,
    required bool authorizationRequired,
    String? moduleId,
    String? subModuleId,
    String? screenId,
    String? customerId,
  });
}