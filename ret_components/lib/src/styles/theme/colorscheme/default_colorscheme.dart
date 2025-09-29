import 'package:flutter/material.dart';

import 'colors/default_colors.dart';
import 'colorscheme.dart';

class DefaultColorScheme extends AppColorScheme {
  const DefaultColorScheme.light()
      : super(
          primary: DefaultColors.primaryBlue,
          onPrimary: DefaultColors.white,
          primaryContainer: DefaultColors.white,
          secondary: DefaultColors.grayF8,
          onSecondary: DefaultColors.gray8A,
          surface: DefaultColors.whiteFA,
          onSurface: DefaultColors.gray2D,
          error: Colors.red,
          onError: DefaultColors.white,
          scaffoldBackgroundColor: DefaultColors.whiteFA,
          defaultTextColor: Colors.black
        );

  const DefaultColorScheme.dark()
      : super(
          primary: DefaultColors.white,
          onPrimary: DefaultColors.primaryBlue,
          primaryContainer: DefaultColors.blue9C,
          secondary: DefaultColors.gray8A,
          onSecondary: DefaultColors.white,
          surface: DefaultColors.black15,
          onSurface: DefaultColors.white,
          error: Colors.red,
          onError: DefaultColors.black4E,
          scaffoldBackgroundColor: DefaultColors.black26,
          defaultTextColor: Colors.white
        );
}
