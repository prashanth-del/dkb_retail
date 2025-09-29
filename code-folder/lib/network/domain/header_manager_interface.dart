abstract class HeaderManagerInterface {
  /// Generates headers for HTTP requests
  ///
  /// Parameters:
  /// - [serviceId] (optional): The ID of the service. If not provided, the current screen name from [ScreenTrackingObserver] is used.
  /// - [authorizationRequired]: A boolean indicating if the Authorization header is required.
  /// - [moduleId] (optional): The module ID. If not provided, the current screen name from [ScreenTrackingObserver] is used.
  /// - [subModuleId] (optional): The sub-module ID. If not provided, the current path name from [ScreenTrackingObserver] is used.
  /// - [screenId] (optional): The screen ID. If not provided, the current path name from [ScreenTrackingObserver] is used.
  /// - [customerId]: The ID of the customer.
  ///
  /// Returns a [Map] of headers.
  Map<String, String> getHeaders({
    String? serviceId,
    String? moduleId,
    String? subModuleId,
    String? screenId,
    String? customerId,
  });
}