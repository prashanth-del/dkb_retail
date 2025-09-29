import 'package:db_uicomponents/src/components/ui_text_new.dart';
import 'package:db_uicomponents/src/styles/dynamic_theme/data/models/app_theme.dart';
import 'package:flutter/material.dart';

import '../../colorscheme/extension/color_scheme.dart';
import '../../data/models/font_sizes.dart';
import '../../data/models/theme_data_model.dart';

class ThemeConfig {
  final ThemeData lightTheme;
  final ThemeData darkTheme;

  ThemeConfig({
    required this.lightTheme,
    required this.darkTheme,
  });

  // Factory method to create ThemeConfig from AppTheme
  factory ThemeConfig.fromAppTheme(AppTheme? appTheme) {
    // If appTheme is null, return default theme
    if (appTheme == null) {
      return ThemeConfig(
        lightTheme: _getDefaultTheme(),
        darkTheme: _getDefaultTheme(),
      );
    }

    // Use appTheme values to build the ThemeConfig
    return ThemeConfig(
      lightTheme: _getThemeDataFromAppTheme(
          appTheme.lightTheme, appTheme.fontSizes, true),
      darkTheme: _getThemeDataFromAppTheme(
          appTheme.darkTheme, appTheme.fontSizes, false),
    );
  }

  static InputBorder _getInputBorder(
      String textFieldType, String borderColorHex, double curve) {
    final Color borderColor = _colorFromHex(borderColorHex);

    if (textFieldType == 'underline') {
      return UnderlineInputBorder(
        borderSide: BorderSide(
          color: borderColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(curve),
      );
    } else {
      return OutlineInputBorder(
        borderSide: BorderSide(
          color: borderColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(curve),
      );
    }
  }

  static DataTableThemeData _dataTableLightTheme(
          String rowColorHex,
          String? headerColorHex,
          TextStyle headTextStyle,
          TextStyle dataTextStyle) =>
      DataTableThemeData(
          dataRowMinHeight: 50,
          dataRowMaxHeight: 80,
          dataRowColor: WidgetStatePropertyAll(
            _colorFromHex(rowColorHex),
          ),
          headingRowColor: WidgetStatePropertyAll(
            _colorFromHex(headerColorHex),
          ),
          headingTextStyle: headTextStyle,
          dataTextStyle: dataTextStyle);

  // Convert AppTheme's individual theme data to ThemeData
  static ThemeData _getThemeDataFromAppTheme(
      ThemeDataModel themeData, FontSizes fontSizes, bool isLight) {
    // Get the input border using the utility method
    final InputBorder inputBorder = _getInputBorder(themeData.textFieldType,
        themeData.focusedBorderColor, themeData.textFieldCurve);

    return ThemeData(
        useMaterial3: true,
        brightness: isLight ? Brightness.light : Brightness.dark,
        primaryColor: _colorFromHex(themeData.colorScheme.primary),
        highlightColor: _colorFromHex(themeData.labelColor),
        colorScheme: themeData.colorScheme.toColorScheme(isLight: isLight),
        scaffoldBackgroundColor: _colorFromHex(themeData.scaffoldBackground),
        canvasColor: _colorFromHex(themeData.scaffoldBackground),
        iconTheme: IconThemeData(
            color: _colorFromHex(themeData.colorScheme.onPrimary)),
        iconButtonTheme: IconButtonThemeData(
            style: ButtonStyle(
                iconColor: WidgetStatePropertyAll(
                    _colorFromHex(themeData.colorScheme.onPrimary)))),
        appBarTheme: AppBarTheme(
          foregroundColor: _colorFromHex(themeData.colorScheme.surface),
          backgroundColor: _colorFromHex(themeData.colorScheme.surface),
          centerTitle: true,
          actionsIconTheme:
              IconThemeData(color: _colorFromHex(themeData.appBarIcon)),
          titleTextStyle: TextStyle(
            color: _colorFromHex(themeData.appBarTitle),
            fontSize: fontSizes.fontSizeBigTitle,
            fontWeight: FontWeight.w700,
          ),
        ),
        dataTableTheme: _dataTableLightTheme(
            isLight ? themeData.colorScheme.surfaceDim! : "#313D4F87",
            isLight ? themeData.colorScheme.surfaceDim : "#313D4F",
            TextStyle(
                color: _colorFromHex(themeData.titleColor),
                fontFamily: _getValidFontFamily(themeData.fontFamilyBody),
                fontSize: fontSizes.fontSizeSubtitle,
                fontWeight: FontWeight.w500),
            TextStyle(
                color: _colorFromHex(themeData.titleColor),
                fontFamily: _getValidFontFamily(themeData.fontFamilyBody),
                fontSize: fontSizes.fontSizeExtraSmall,
                fontWeight: FontWeight.w400)),
        inputDecorationTheme: InputDecorationTheme(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            labelStyle: TextStyle(
                color: _colorFromHex(themeData.labelColor),
                fontFamily: _getValidFontFamily(themeData.fontFamilyBody),
                fontSize: fontSizes.fontSizeSubtitle,
                fontWeight: FontWeight.w500),
            hintStyle: TextStyle(
              color: _colorFromHex(themeData.hintColor),
              fontFamily: _getValidFontFamily(themeData.fontFamilyBody1),
              fontSize: fontSizes.fontSizeExtraSmall,
              fontWeight: FontWeight.normal,
            ),
            focusedBorder: inputBorder,
            enabledBorder: inputBorder,
            border: inputBorder,
            disabledBorder: inputBorder,
            fillColor: _colorFromHex(themeData.inputFillColor),
            errorBorder: inputBorder.copyWith(
                borderSide: inputBorder.borderSide.copyWith(
                    color: _colorFromHex(themeData.errorBorderColor)))),
        // tabBarTheme: TabBarTheme(
        //   labelColor: _colorFromHex(themeData.colorScheme.secondary),
        //   unselectedLabelColor: _colorFromHex(themeData.subtitleColor),
        // ),
        textTheme: TextTheme(
          // Headline
          headlineLarge: TextStyle(
              color: _colorFromHex(themeData.titleColor),
              fontFamily: _getValidFontFamily(themeData.fontFamilyHead),
              fontSize: fontSizes.fontSizeTitle,
              fontWeight: FontWeight.w500),
          headlineMedium: TextStyle(
              color: _colorFromHex(themeData.titleColor),
              fontFamily: _getValidFontFamily(themeData.fontFamilyBody),
              fontSize: fontSizes.fontSizeSubtitle,
              fontWeight: FontWeight.w500),
          headlineSmall: TextStyle(
              color: _colorFromHex(themeData.titleColor),
              fontFamily: _getValidFontFamily(themeData.fontFamilyBody1),
              fontSize: fontSizes.fontSizeExtraSmall,
              fontWeight: FontWeight.w500),
          // Title
          titleLarge: TextStyle(
              color: _colorFromHex(themeData.titleColor),
              fontFamily: _getValidFontFamily(themeData.fontFamilyBody),
              fontSize: fontSizes.fontSizeTitle,
              fontWeight: FontWeight.w400),
          titleMedium: TextStyle(
              color: _colorFromHex(themeData.titleColor),
              fontFamily: _getValidFontFamily(themeData.fontFamilyHead),
              fontSize: fontSizes.fontSizeSubtitle,
              fontWeight: FontWeight.w400),
          titleSmall: TextStyle(
              color: _colorFromHex(themeData.titleColor),
              fontFamily: _getValidFontFamily(themeData.fontFamilyBody),
              fontSize: fontSizes.fontSizeExtraSmall,
              fontWeight: FontWeight.w400),
          bodyLarge: TextStyle(
              color: _colorFromHex(themeData.titleColor),
              fontFamily: _getValidFontFamily(themeData.fontFamilyBody),
              fontSize: fontSizes.fontSizeTitle,
              fontWeight: FontWeight.w500),
          bodyMedium: TextStyle(
              color: _colorFromHex(themeData.titleColor),
              fontFamily: _getValidFontFamily(themeData.fontFamilyBody),
              fontSize: fontSizes.fontSizeSubtitle,
              fontWeight: FontWeight.w500),
          bodySmall: TextStyle(
              color: _colorFromHex(themeData.titleColor),
              fontFamily: _getValidFontFamily(themeData.fontFamilyBody),
              fontSize: fontSizes.fontSizeExtraSmall,
              fontWeight: FontWeight.w400),
          labelLarge: TextStyle(
              color: _colorFromHex(themeData.titleColor),
              fontFamily: _getValidFontFamily(themeData.fontFamilyBody1),
              fontSize: fontSizes.fontSizeTitle,
              fontWeight: FontWeight.w400),
          labelMedium: TextStyle(
              color: _colorFromHex(themeData.titleColor),
              fontFamily: _getValidFontFamily(themeData.fontFamilyBody1),
              fontSize: fontSizes.fontSizeSubtitle,
              fontWeight: FontWeight.w400),
          labelSmall: TextStyle(
              color: _colorFromHex(themeData.subtitleColor),
              fontFamily: _getValidFontFamily(themeData.fontFamilyBody1),
              fontSize: fontSizes.fontSizeExtraSmall,
              fontWeight: FontWeight.w400),
        ),
        switchTheme: SwitchThemeData(
            thumbColor: WidgetStateProperty.resolveWith<Color>(
                (Set<WidgetState> states) {
              if (states.contains(WidgetState.selected)) {
                return _colorFromHex(themeData.colorScheme.primary);
              } else {
                return _colorFromHex(themeData.colorScheme.primary)
                    .withOpacity(0.8);
              }
            }),
            trackColor: WidgetStateProperty.resolveWith<Color>(
                (Set<WidgetState> states) {
              if (states.contains(WidgetState.selected)) {
                return _colorFromHex(themeData.colorScheme.primary)
                    .withOpacity(0.3);
              } else {
                return _colorFromHex(themeData.colorScheme.surfaceDim);
              }
            }),
            trackOutlineColor: WidgetStatePropertyAll(
              _colorFromHex(themeData.colorScheme.primary).withOpacity(0.3),
            ),
            trackOutlineWidth: const WidgetStatePropertyAll<double>(
              1,
            )),
        buttonTheme: ButtonThemeData(
          buttonColor: _colorFromHex(themeData.buttonBackground),
          colorScheme: isLight
              ? ColorScheme.light(
                  primary: _colorFromHex(themeData.buttonBackground),
                  surface: _colorFromHex(themeData.buttonForeground))
              : ColorScheme.dark(
                  primary: _colorFromHex(themeData.buttonBackground),
                  surface: _colorFromHex(themeData.buttonForeground)),
          disabledColor: themeData.colorScheme.surfaceDim != null
              ? _colorFromHex(themeData.colorScheme.surfaceDim!)
              : Colors.grey,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(themeData.textFieldCurve)),
          padding: EdgeInsets.symmetric(
              vertical: themeData.verticalButtonPadding,
              horizontal: themeData.horizontalButtonPadding),
        ),
        radioTheme: RadioThemeData(
          fillColor: WidgetStateProperty.resolveWith<Color>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.selected)) {
                return _colorFromHex(themeData.colorScheme.surfaceDim!);
              }
              return _colorFromHex(themeData.colorScheme.tertiary!);
            },
          ),
        ),
        checkboxTheme: CheckboxThemeData(
          fillColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return _colorFromHex(themeData.colorScheme.surfaceDim);
            }
            return _colorFromHex(themeData.colorScheme.surface);
          }),
          checkColor: WidgetStateProperty.all(
              _colorFromHex(themeData.colorScheme.primary)),
          overlayColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.hovered)) {
              return _colorFromHex(themeData.colorScheme.surfaceDim);
            }
            if (states.contains(WidgetState.focused)) {
              return _colorFromHex(themeData.colorScheme.surfaceDim);
            }
            return null;
          }),
          side: WidgetStateBorderSide.resolveWith((states) {
            return BorderSide(
              color: _colorFromHex(themeData.colorScheme.tertiary),
              width: 1, // Keeps border visible in all states
            );
          }),
        ));
  }

  // Default light theme
  static ThemeData _getDefaultTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: Colors.blue,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        primary: Colors.blue,
        onPrimary: Colors.white,
        secondary: Colors.green,
      ),
      scaffoldBackgroundColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.black),
      appBarTheme: const AppBarTheme(
        foregroundColor: Colors.black,
        backgroundColor: Colors.blue,
        elevation: 1,
        centerTitle: true,
        actionsIconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  // Utility method to convert hex string to Color
  static Color _colorFromHex(String? hexColor) {
    if (hexColor == null) return Colors.white;
    return Color(int.parse(hexColor.replaceFirst('#', '0xff')));
  }

  // Utility method to validate font family against the enum
  static String _getValidFontFamily(String fontFamily) {
    try {
      return Fonts.values
          .firstWhere((font) =>
              font.toString().split('.').last.toLowerCase() ==
              fontFamily.toLowerCase())
          .toString()
          .split('.')
          .last;
    } catch (_) {
      return Fonts.diodrumArabic
          .toString()
          .split('.')
          .last; // default to 'roboto'
    }
  }
}
