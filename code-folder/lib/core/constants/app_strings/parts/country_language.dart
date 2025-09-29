part of app_strings;

extension DefaultStringCountryLanguage on DefaultString {
  String get qatar => _i18nText(key: I18nKeys.qatar, fallback: "Qatar");

  String get uae => _i18nText(key: I18nKeys.uae, fallback: "UAE");

  String get kuwait => _i18nText(key: I18nKeys.kuwait, fallback: "Kuwait");

  String get india => _i18nText(key: I18nKeys.india, fallback: "India");

  String get english => _i18nText(key: I18nKeys.english, fallback: "English");

  String get arabic => _i18nText(key: I18nKeys.arabic, fallback: "العربية");

  String get selectCountry =>
      _i18nText(key: I18nKeys.selectCountry, fallback: "Select your Country");

  String get changeLanguage =>
      _i18nText(key: I18nKeys.changeLanguage, fallback: "Change your language");

  String get eng => _i18nText(key: I18nKeys.eng, fallback: "Eng");

  String get ar => _i18nText(key: I18nKeys.ar, fallback: "Ar");
}
