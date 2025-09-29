import 'package:db_uicomponents/styles.dart';
import 'package:flutter/material.dart';

extension ThemeX on BuildContext {
  ThemeData get theme => Theme.of(this);

  ColorScheme get colorScheme => theme.colorScheme;
  TextTheme get textTheme => theme.textTheme;
  UiThemeExtension get themeX => theme.extension<UiThemeExtension>()!;
}

extension MediaQueryX on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  Size get screenSize => mediaQuery.size;

  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;
  bool get isRTL => Directionality.of(this) == TextDirection.rtl;
  bool get isLTR => Directionality.of(this) == TextDirection.ltr;

  bool get isPortrait => mediaQuery.orientation == Orientation.portrait;
  bool get isLandscape => mediaQuery.orientation == Orientation.landscape;

}

extension TextDirectionExtension on BuildContext {
  TextDirection get localeDirection {
    return Localizations.localeOf(this).languageCode == 'en'
        ? TextDirection.ltr
        : TextDirection.rtl;
  }
}
