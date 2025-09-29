import '../../../../network/domain/models/api_envelope.dart';
import '../entity/i18n_asset.dart';

abstract class I18nRepository {
  /// Returns a normalized i18n payload:
  /// { "i18": <labels map>, "validation": <validations map> }
  Future<ApiEnvelope<I18nAsset>> getLocaleAsset(String localeId);
}