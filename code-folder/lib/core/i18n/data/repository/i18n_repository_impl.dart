import 'package:flutter/Material.dart';

import '../../../../network/data/model/app_status.dart';
import '../../../../network/domain/models/api_envelope.dart';
import '../../../../network/domain/models/api_error.dart';
import '../../../cache/locale_cache.dart';
import '../../domain/entity/i18n_asset.dart';
import '../../domain/repository/i18n_repository.dart';
import '../datasource/i18n_datasource.dart';

class I18nRepositoryImpl implements I18nRepository {
  I18nRepositoryImpl(this._ds, this._cache);
  final I18nDatasource _ds;
  final LocaleCache _cache;

  Future<ApiEnvelope<I18nAsset>> getLocaleAsset(String localeId) async {
    final env = await _ds.getLocaleAsset(localeId);

    if (env.ok && env.data != null) {
      _cache.setLocaleAsset(env.data!.raw); // persist normalized
      return env;
    }

    final cached = _cache.getLocaleAsset();
    if (cached != null) {
      return ApiEnvelope.success(
        I18nAsset(Map<String, dynamic>.from(cached)),
        const ApiError(description: 'Used cached i18n'),
        AppStatus.success,
      );
    }

    return ApiEnvelope.error(
      const ApiError(description: 'i18n unavailable'),
      AppStatus.error,
    );
  }
}
