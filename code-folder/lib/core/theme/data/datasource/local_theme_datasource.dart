import 'dart:convert';
import 'package:dkb_retail/core/theme/data/datasource/theme_datasource.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:db_uicomponents/src/styles/dynamic_theme/data/models/app_theme.dart';
import '../../../../network/data/model/app_status.dart';
import '../../../../network/domain/models/api_envelope.dart';
import '../../../../network/domain/models/api_error.dart';
import '../../domain/brand.dart';

class LocalThemeDatasource implements ThemeDatasource {
  const LocalThemeDatasource();

  @override
  Future<ApiEnvelope<AppTheme>> getBrandTheme(Brand brand) async {
    try {
      final path = 'assets/app_theme_${brand.key}.json';
      final map = json.decode(await rootBundle.loadString(path)) as Map<String, dynamic>;
      return ApiEnvelope.success(AppTheme.fromJson(map), const ApiError(), AppStatus.success);
    } catch (e) {
      debugPrint('Error : $e');
      return ApiEnvelope.error(const ApiError(description: 'Theme load failed'), AppStatus.error);
    }
  }
}
