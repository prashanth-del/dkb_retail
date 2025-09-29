import 'dart:convert';

import 'package:http/browser_client.dart';
import 'package:http/http.dart' as http;

class AppClient extends BrowserClient {
  static final AppClient _instance = AppClient._internal();

  AppClient._internal();

  factory AppClient() => _instance;

  static void initialize({required List<String> certificatePaths}) =>
      _client = http.Client();

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
