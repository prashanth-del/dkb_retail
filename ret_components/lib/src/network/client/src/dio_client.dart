import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/services.dart';

class DioClient {
  static final _dio = Dio();

  static Future<SecurityContext> _globalContext(
      List<String> certificatePaths) async {
    SecurityContext securityContext = SecurityContext(withTrustedRoots: true);

    for (var path in certificatePaths) {
      final sslCert = await rootBundle.load(path);
      securityContext.setTrustedCertificatesBytes(sslCert.buffer.asUint8List());
    }

    return securityContext;
  }

  static Future<Dio> getClient(List<String> certificatePaths) async {
    final sc = await _globalContext(certificatePaths);

    _dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final HttpClient client = HttpClient(context: sc);
        return client;
      },
    );

    return _dio;
  }
}
