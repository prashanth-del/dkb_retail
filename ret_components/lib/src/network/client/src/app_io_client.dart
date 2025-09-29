import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/io_client.dart';
import 'package:http/http.dart' as http;

part 'ssl_pin.dart';

class AppClient extends IOClient {
  static final AppClient _instance = AppClient._internal();

  AppClient._internal();

  factory AppClient() {
    return _instance;
  }

  static void initialize({required List<String> certificatePaths}) {
    _globalContext(certificatePaths).then((ctx) {
      HttpClient client = HttpClient(context: ctx);
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => false;
      IOClient ioClient = IOClient(client);
      _client = ioClient;
    });
  }

  static late http.Client _client;

  @override
  Future<http.Response> post(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) async {
    http.Response response = await _client.post(
      url,
      body: body,
      headers: headers,
    );

    return response;
  }
}
