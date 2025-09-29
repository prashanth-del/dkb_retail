import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/app_theme.dart';
import '../models/font_sizes.dart';
import '../models/theme_data_model.dart';

abstract class AppThemeDatasource {
  Future<AppTheme?> fetchThemeData(
      {required String themeUrl,
      required String themeAssetPath,
      String? token});
}

class AppThemeDatasourceImpl implements AppThemeDatasource {
  @override
  Future<AppTheme?> fetchThemeData(
      {required String themeUrl,
      required String themeAssetPath,
      String? token}) async {
    debugPrint('Theme api call');
    print('Theme api call');
    try {
      return _fetchThemeDataAsset(assetPath: themeAssetPath);
      // Load the JSON file

      // final response = await http.post(
      //   Uri.parse(themeUrl),
      //   headers: {"token": "Bearer $token", "product": ""},
      // );

      // final responseBody = jsonDecode(response.body);

      // if (responseBody['status']['code'] != '000000') {
      //   // throw ServiceException('Error in getting theme');
      //   _fetchThemeDataAsset(assetPath: themeAssetPath);
      // }

      // // Decode JSON directly into a Map
      // final Map<String, dynamic> jsonMap = responseBody['data'][0];

      // final lightThemeData = jsonMap['lightTheme'];
      // final darkThemeData = jsonMap['darkTheme'];
      // final fontSizesData = jsonMap['fontSizes'];

      // if (lightThemeData == null || fontSizesData == null) {
      //   debugPrint('Light theme or font sizes are missing');
      //   return null;
      // }

      // // Parse data into models
      // final lightTheme = ThemeDataModel.fromJson(lightThemeData);
      // final darkTheme = darkThemeData != null
      //     ? ThemeDataModel.fromJson(darkThemeData)
      //     : lightTheme; // Use light theme as fallback for dark theme
      // final fontSizes = FontSizes.fromJson(fontSizesData);

      // await Future.delayed(const Duration(seconds: 2)); // Simulate a delay

      // return AppTheme(
      //   lightTheme: lightTheme,
      //   darkTheme: darkTheme,
      //   fontSizes: fontSizes,
      // );
    } catch (e) {
      log('Error from AppThemeDatasource: $e');
      return null;
    }
  }

  Future<AppTheme?> _fetchThemeDataAsset({required String assetPath}) async {
    debugPrint('inside local asset theme json');
    try {
      // Load the JSON file
      final jsonString = await rootBundle.loadString(assetPath);

      // Decode JSON directly into a Map
      final Map<String, dynamic> jsonMap = jsonDecode(jsonString);

      final lightThemeData = jsonMap['lightTheme'];
      final darkThemeData = jsonMap['darkTheme'];
      final fontSizesData = jsonMap['fontSizes'];

      if (lightThemeData == null || fontSizesData == null) {
        debugPrint('Light theme or font sizes are missing');
        return null;
      }

      // Parse data into models
      final lightTheme = ThemeDataModel.fromJson(lightThemeData);
      final darkTheme = darkThemeData != null
          ? ThemeDataModel.fromJson(darkThemeData)
          : lightTheme; // Use light theme as fallback for dark theme
      final fontSizes = FontSizes.fromJson(fontSizesData);

      await Future.delayed(const Duration(seconds: 2)); // Simulate a delay

      return AppTheme(
        lightTheme: lightTheme,
        darkTheme: darkTheme,
        fontSizes: fontSizes,
      );
    } catch (e) {
      log('Error from AppThemeDatasource: $e');
      return null;
    }
  }
}
