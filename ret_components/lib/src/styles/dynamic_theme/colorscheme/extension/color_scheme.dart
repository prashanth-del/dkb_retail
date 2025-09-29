import 'package:flutter/material.dart';

import '../../data/models/color_scheme.dart';

// Extension to convert the model into Flutter's `ColorScheme`
extension DefaultColorScheme on ColorSchemeModel {
  ColorScheme toColorScheme({required bool isLight}) {
    return ColorScheme.fromSeed(
      seedColor: _colorFromHex(primary),
      brightness: isLight ? Brightness.light : Brightness.dark,
      primary: _colorFromHex(primary),
      //for blue button
      onPrimary: _colorFromHex(onPrimary),
      onPrimaryFixed: _colorFromHex(onPrimaryFixed ?? primary),
      surfaceContainerLowest:
      _colorFromHex(surfaceContainerLowest ?? surface),
      secondary: _colorFromHex(secondary),
      onSecondary: _colorFromHex(onSecondary),
      error: _colorFromHex(error),
      //for red button
      onError: _colorFromHex(onError),
      surface: _colorFromHex(surface),
      //for card background
      surfaceDim:
      surfaceDim == null ? Colors.grey : _colorFromHex(surfaceDim!),
      //for datatable row color
      onSurface: _colorFromHex(onSurface),
      tertiary: _colorFromHex(tertiary ?? "#EBEBEB"),
      //for font color
      onTertiary: _colorFromHex(onTertiary ?? "#EBEBEB"),
      tertiaryContainer: _colorFromHex(tertiaryContainer ?? "#EBEBEB"),
      onTertiaryContainer:
      _colorFromHex(onTertiaryContainer ?? "#EBEBEB"),
      tertiaryFixed: _colorFromHex(tertiaryFixed ?? "#EBEBEB"),
      tertiaryFixedDim: _colorFromHex(tertiaryFixedDim ?? "#EBEBEB"),
      primaryFixed: _colorFromHex(primaryFixed ?? "#1c8759"),
      primaryFixedDim: _colorFromHex(primaryFixedDim ?? "#dff0e9"),
      onTertiaryFixedVariant:
      _colorFromHex(onTertiaryFixedVariant ?? "#5A5D6C"),
      onPrimaryFixedVariant:
      _colorFromHex(onPrimaryFixedVariant ?? "#244D83"),
      surfaceContainer: _colorFromHex(surfaceContainer ?? "#113E79"),
      secondaryFixed: _colorFromHex(secondaryFixed ?? "#4E7EE3"),
      secondaryFixedDim: _colorFromHex(secondaryFixedDim ?? "#232954"),
    );
  }

  Color _colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }
}
