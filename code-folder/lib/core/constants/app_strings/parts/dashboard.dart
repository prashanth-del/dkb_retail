part of app_strings;

extension DefaultStringDashboard on DefaultString {
  String get customizeDashtitle => _i18nText(
    key: I18nKeys.customizeDashtitle,
    fallback: "Customized your dashboard",
  );
  String get customizeDashDesc => _i18nText(
    key: I18nKeys.customizeDashDesc,
    fallback: "Explore more banking features",
  );
}
