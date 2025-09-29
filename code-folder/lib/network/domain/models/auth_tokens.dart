import 'dart:convert';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:dkb_retail/common/utils.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


part 'auth_tokens.freezed.dart';

@freezed
class AuthTokens with _$AuthTokens {
  const factory AuthTokens({
    required String atkn,
    required String reftkn,
  }) = _AuthTokens;

  const AuthTokens._();

  bool get isAccessTokenExpired => isExpiredToken(atkn);
  bool get isRefreshTokenExpired => isExpiredToken(reftkn);

  bool isExpiredToken(String? token) {
    if (token == null) {
      consoleLog('toke is null');
      return true;
    }

    try {
      final expTime = JWT.decode(token).payload!["exp"] as int;
      final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      return expTime < now;
    } catch (e) {
      return true;
    }
  }
}
