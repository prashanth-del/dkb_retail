import '../../core/router/observers/screen_tracking_observer.dart';
import '../domain/header_manager_interface.dart';

class HeaderManager implements HeaderManagerInterface {
  final ScreenTrackingObserver screenTrackingObserver;

  HeaderManager(this.screenTrackingObserver);

  @override
  Map<String, String> getHeaders({
    String? serviceId,
    String? moduleId,
    String? subModuleId,
    String? screenId,
    String? customerId,
  }) {
    Map<String, String> headers = {};

    if(serviceId != null) headers['serviceId'] = serviceId;
    if(moduleId != null) headers['moduleId'] = moduleId;
    if(subModuleId != null) headers['subModuleId'] = subModuleId;
    if(screenId != null) headers['screenId'] = screenId;
    if(customerId != null) headers['customerId'] = customerId;

    return headers;
  }
}