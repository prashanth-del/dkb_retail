class CommonException implements Exception {
  final String message;

  CommonException(this.message);

  @override
  String toString() => message;
}

class ServiceException extends CommonException {
  ServiceException([super.message = 'Unexpected exception occurred']);
}

class GeneralException implements CommonException {
  final String message;

  GeneralException([this.message = "Error Occurred!"]);

  @override
  String toString() {
    return this.message;
  }
}

class DeviceInfoException implements CommonException {
  final String message;

  DeviceInfoException([this.message = "Couldn't get device info!"]);

  @override
  String toString() {
    return this.message;
  }
}

class NetworkException extends CommonException {
  NetworkException([String? message]) : super(message ?? "");
  @override
  String toString() {
    return this.message;
  }
}
