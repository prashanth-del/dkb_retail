import 'package:dio/dio.dart';
import '../domain/cookie_manager_interface.dart';

class CookieManager implements CookieManagerInterface {
  final Map<String, String> _cookies = {};

  @override
  void updateCookie(Response response) {
    List<String>? setCookies = response.headers['set-cookie'];

    if (setCookies != null) {
      for (var setCookie in setCookies) {
        var cookies = setCookie.split(';');

        for (var cookie in cookies) {
          var trimmedCookie = cookie.trim();
          var cookieParts = trimmedCookie.split('=');

          // Check if the cookie name is JSESSIONID

          if (cookieParts.length > 1 &&
              cookieParts[0].trim().toLowerCase() == 'jsessionid') {
          // if (cookieParts.length > 1) {
            _setCookie(trimmedCookie);
          }
        }
      }
    }
  }

  void _setCookie(String? rawCookie) {
    if (rawCookie != null) {
      var keyValue = rawCookie.split('=');
      if (keyValue.length == 2) {
        var key = keyValue[0].trim();
        var value = keyValue[1];

        if (key == 'path' || key == 'expires') return;

        _cookies[key] = value;
      }
    }
    // _cookies['JSESSIONID'] = rawCookie ?? "";
  }

  @override
  String generateCookieHeader() {
    String cookie = "";

    for (var key in _cookies.keys) {
      if (cookie.isNotEmpty) cookie += ";";
      cookie += "$key=${_cookies[key]!}";
    }

    return cookie;
  }
}