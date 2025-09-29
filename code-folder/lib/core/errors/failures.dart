abstract class Failure {
  final String message;
  Failure(this.message);
}

class ServiceFailure extends Failure {
  ServiceFailure([super.message = 'Service Failure Occurred']);

  @override
  String toString() {
    return this.message;
  }
}