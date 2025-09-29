import 'dart:convert';

import 'package:dkb_retail/features/accounts/data/model/account_selected_items.dart';
import 'package:dkb_retail/features/login/data/models/user_dto.dart';
import 'package:dkb_retail/features/login/domain/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../network/domain/models/auth_tokens.dart';
import 'adapter/auth_tokens_adapter.dart';

/// An example utility class to cache simple data in hive.
/// This can be utilized like shared preferences.
///
/// If we want more caching implementations define them in this `cache` folder.
class GlobalCache {
  GlobalCache._(this._box);

  final Box<dynamic> _box;

  static late final GlobalCache _instance;

  static GlobalCache get instance => _instance;

  static const String _boxName = 'globalCacheBox';
  static const String _themeKey = 'themeMode';
  static const String _athKey = 'token';
  static const String _userType = 'userType';
  static const String _consentKey = 'consent';
  static const String _preferenceKey = 'preference';
  static const String _changePwdKey = 'change_pwd';
  static const String _primaryUser = 'primary_user';
  static const String _usernameKey = 'username';
  static const String _userDetailkey = 'user_detail';
  static const String _encFlag = 'N';
  static const String _selectedLangFlag = 'selected_flag';
  static const String _selectedLanguage = 'selected_lang';
  static const String _selectedAccPageItemsKey = 'selected_acc_page_items';
  static const String _allAccPageItemsKey = 'all_acc_page_items';

  static Future<void> init() async {
    final box = await Hive.openBox<dynamic>(_boxName);
    _instance = GlobalCache._(box);
  }

  T _getValue<T>(dynamic key, {T? defaultValue}) =>
      _box.get(key, defaultValue: defaultValue) as T;

  Future<void> _setValue<T>(dynamic key, T value) => _box.put(key, value);

  // Theme
  bool isLightTheme() => _getValue(_themeKey, defaultValue: true);

  Future<void> setThemeMode({required bool isLightTheme}) =>
      _setValue(_themeKey, isLightTheme);

  // Auth Token
  AuthTokens? getTkn() => _getValue(_athKey, defaultValue: null);

  Future<void> setToken({required AuthTokens? token}) =>
      _setValue(_athKey, token);

  // User Type
  String? getUserType() => _getValue(_userType, defaultValue: "approver");

  Future<void> setUserType({required String userType}) =>
      _setValue(_userType, userType);

  // Consent
  bool isConsentSeen() => _getValue(_consentKey, defaultValue: false);

  Future<void> setConsentSeen() => _setValue(_consentKey, true);

  String getSelectedLanguage() =>
      _getValue(_selectedLanguage, defaultValue: 'en');

  Future<void> setSelectedLanguage(String lang) =>
      _setValue(_selectedLanguage, lang);

  String getSelectedLangFlag() =>
      _getValue(_selectedLangFlag, defaultValue: 'assets/images/flags/qa.png');

  Future<void> setSelectedLangFlag(String flag) =>
      _setValue(_selectedLangFlag, flag);

  // Preference
  bool isPreferenceSeen() => _getValue(_preferenceKey, defaultValue: false);

  Future<void> setPreferenceSeen() => _setValue(_preferenceKey, true);

  bool isChangePwdSeen() => _getValue(_changePwdKey, defaultValue: false);

  Future<void> setChangePwdSeen() => _setValue(_changePwdKey, true);

  bool get isPrimaryUser => _getValue(_primaryUser, defaultValue: false);

  Future<void> setPrimaryUser(bool value) => _setValue(_primaryUser, value);

  String? getEncFlag() => _getValue(_encFlag, defaultValue: "N");

  Future<void> setEncFlag({required String encFlag}) =>
      _setValue(_encFlag, encFlag);

  // Selected Account Page Items
  Future<List<AccountSelectedItems>> getSelectedAccountPageItems() async {
    try {
      final jsonString = _getValue(_selectedAccPageItemsKey);
      if (jsonString == null) {
        return [];
      }
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList
          .map(
            (json) =>
                AccountSelectedItems.fromJson(json as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      print('Error retrieving selected account page items: $e');
      return [];
    }
  }

  Future<void> setSelectedAccountPageItems(
    List<AccountSelectedItems> items,
  ) async {
    try {
      final jsonString = jsonEncode(
        items.map((item) => item.toJson()).toList(),
      );
      await _setValue(_selectedAccPageItemsKey, jsonString);
    } catch (e) {
      print('Error storing selected account page items: $e');
    }
  }

  // All Account Page Items
  Future<List<AccountSelectedItems>> getAllAccountPageItems() async {
    try {
      final jsonString = _getValue(_allAccPageItemsKey);
      if (jsonString == null) {
        return [];
      }
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList
          .map(
            (json) =>
                AccountSelectedItems.fromJson(json as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<void> setAllAccountPageItems(List<AccountSelectedItems> items) async {
    try {
      final jsonString = jsonEncode(
        items.map((item) => item.toJson()).toList(),
      );
      await _setValue(_allAccPageItemsKey, jsonString);
    } catch (e) {
      debugPrint('Error storing all account page items: $e');
    }
  }

  //auth

  // UserDto? getCurrentUserDetails() {
  //   final jsonString = _getValue(_userDetailkey);
  //   if (jsonString == null) {
  //     return null;
  //   }
  //   final UserDto userDetail = UserDto.fromJson(jsonString);
  //   return userDetail;
  // }

  // Future<void> setCurrentUserDetails(UserDto userDetail) async {
  //   try {
  //     final jsonString = jsonEncode(userDetail);
  //     await _setValue(_userDetailkey, jsonString);
  //   } catch (e) {
  //     debugPrint('Error storing all account page items: $e');
  //   }
  // }

  // We can expand more cache methods here depending on the requirement.
  // Use this if the data stored is of primary type, like bool, string, etc.

  // Username
  String getUsername() => _getValue(_usernameKey, defaultValue: "");
  Future<void> setUsername(String name) => _setValue(_usernameKey, name);
}

/*
  Example Usage:
  GlobalCache.isLightTheme() --> Returns true or false from cache.
  GlobalCache.setThemeMode(isLightTheme: false) --> Stores themeMode in cache
*/
