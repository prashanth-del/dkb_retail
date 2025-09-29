import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:db_uicomponents/src/styles/dynamic_theme/data/models/app_theme.dart';
import '../../domain/brand.dart';

part 'theme_state.freezed.dart';

@freezed
class ThemeState with _$ThemeState {
  const factory ThemeState.idle() = _Idle;

  /// While resolving brand theme (remote/local/cache)
  const factory ThemeState.loading({Brand? brand}) = _Loading;

  /// Loaded theme + where it came from
  const factory ThemeState.data({
    required AppTheme theme,
    required Brand brand,
    @Default(false) bool fromCache,
  }) = _Data;

  /// Failure to load (after cache fallback)
  const factory ThemeState.error({
    required String message,
    Brand? brand,
  }) = _Error;
}
