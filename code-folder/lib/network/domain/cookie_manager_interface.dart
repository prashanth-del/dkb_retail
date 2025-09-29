import 'package:dio/dio.dart';

abstract class CookieManagerInterface {
  void updateCookie(Response response);
  String generateCookieHeader();
}