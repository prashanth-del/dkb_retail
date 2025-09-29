import 'package:http/http.dart';

class AppClient extends BaseClient {
  @override
  Future<StreamedResponse> send(BaseRequest request) {
    throw UnimplementedError();
  }

  static void initialize({required List<String> certificatePaths}) =>
      throw UnimplementedError();
}
