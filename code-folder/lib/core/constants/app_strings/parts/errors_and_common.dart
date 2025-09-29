part of app_strings;

extension DefaultStringErrorsAndCommon on DefaultString {
  // ---- app-level
  String get appVersion  => _i18nText(key: I18nKeys.appVersion,  fallback: "1.0.0");
  String get versionText => _i18nText(key: I18nKeys.versionText, fallback: "Version ");
  String get appName     => _i18nText(key: I18nKeys.appName,     fallback: "Doha");

  // ---- common errors
  String get serverError       => _i18nText(key: I18nKeys.serverError,       fallback: "Unable to process your request");
  String get noInternet        => _i18nText(key: I18nKeys.noInternet,        fallback: "No internet, please check your connection");
  String get connectionTimeout => _i18nText(key: I18nKeys.connectionTimeout, fallback: "Connection timeout, please check network connection");

  // ---- misc common
  String get error        => _i18nText(key: I18nKeys.error,        fallback: "Error");
  String get loading      => _i18nText(key: I18nKeys.loading,      fallback: "Loading");
  String get cancel       => _i18nText(key: I18nKeys.cancel,       fallback: "Cancel");
  String get yes          => _i18nText(key: I18nKeys.yes,          fallback: "Yes");
  String get no           => _i18nText(key: I18nKeys.no,           fallback: "No");
  String get success      => _i18nText(key: I18nKeys.success,      fallback: "Success");
  String get continueText => _i18nText(key: I18nKeys.continueText, fallback: "Continue");
  String get proceed      => _i18nText(key: I18nKeys.proceed,      fallback: "Proceed");
  String get digitsOnly   => _i18nText(key: I18nKeys.digitsOnly,   fallback: "Digits Only");
  String get doneCapital      => _i18nText(key: I18nKeys.doneCapital,      fallback: "DONE");
  String get submit   => _i18nText(key: I18nKeys.submit,   fallback: "SUBMIT");
}
