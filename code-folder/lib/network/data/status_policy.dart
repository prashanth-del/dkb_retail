

import '../domain/models/api_error.dart';
import 'model/app_status.dart';

typedef StatusPolicyFn = AppStatus Function(ApiError);

class StatusPolicy {
  static AppStatus defaultPolicy(ApiError s) {
    final c = (s.code ?? '').trim();
    switch (c) {
      case '000000':
        return AppStatus.success;
      case '2':
      case '000002':
        return AppStatus.otpAlreadySent;
      case '6':
      case '000006':
        return AppStatus.otpThrottle;
      default:
        return AppStatus.error;
    }
  }
}
