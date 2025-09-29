import 'package:freezed_annotation/freezed_annotation.dart';

part 'color_scheme.freezed.dart';
part 'color_scheme.g.dart';

@freezed
class ColorSchemeModel with _$ColorSchemeModel {
  const factory ColorSchemeModel({
    String? primaryContainer,
    String? onPrimaryContainer,
    String? primaryFixed,
    String? primaryFixedDim,
    String? onPrimaryFixed,
    String? onPrimaryFixedVariant,
    required String primary,
    required String onPrimary,
    required String secondary,
    required String onSecondary,
    required String background,
    required String onBackground,
    required String error,
    required String onError,
    required String surface,
    required String onSurface,
    String? secondaryContainer,
    String? onSecondaryContainer,
    String? secondaryFixed,
    String? secondaryFixedDim,
    String? onSecondaryFixed,
    String? onSecondaryFixedVariant,
    String? tertiary,
    String? onTertiary,
    String? tertiaryContainer,
    String? onTertiaryContainer,
    String? tertiaryFixed,
    String? tertiaryFixedDim,
    String? onTertiaryFixed,
    String? onTertiaryFixedVariant,
    String? errorContainer,
    String? onErrorContainer,
    String? surfaceDim,
    String? surfaceBright,
    String? surfaceContainerLowest,
    String? surfaceContainerLow,
    String? surfaceContainer,
    String? surfaceContainerHigh,
    String? surfaceContainerHighest,
    String? onSurfaceVariant,
    String? outline,
    String? outlineVariant,
    String? shadow,
    String? scrim,
    String? inverseSurface,
    String? onInverseSurface,
    String? inversePrimary,
    String? surfaceTint,
    String? surfaceVariant,
  }) = _ColorSchemeModel;

  factory ColorSchemeModel.fromJson(Map<String, dynamic> json) =>
      _$ColorSchemeModelFromJson(json);
}

//

