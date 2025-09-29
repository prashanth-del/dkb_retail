import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_theme_failure.freezed.dart';

@freezed
class AppThemeFailure with _$AppThemeFailure {
  const factory AppThemeFailure.serverFailure() = _ServerFailure;
}
