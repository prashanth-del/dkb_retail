import 'package:db_uicomponents/src/styles/dynamic_theme/data/models/app_theme.dart';
import '../../../../network/domain/models/api_envelope.dart';
import '../../domain/brand.dart';

abstract class ThemeDatasource {
  Future<ApiEnvelope<AppTheme>> getBrandTheme(Brand brand);
}
