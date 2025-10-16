part of app_strings;

extension DefaultStringPrayer on DefaultString {
  String get prayerTimingsTitle =>
      _i18nText(key: I18nKeys.prayerTimings, fallback: "Prayer Timings");

  String get qiblaFinder =>
      _i18nText(key: I18nKeys.qiblaFinder, fallback: "Qibla Finder");

  String get prayerTimeSettings => _i18nText(
    key: I18nKeys.prayerTimeSettings,
    fallback: "Prayer Time Settings",
  );

  String get method => _i18nText(key: I18nKeys.method, fallback: "Method");

  String get hijriDate =>
      _i18nText(key: I18nKeys.hijriDate, fallback: "Hijri Date");

  String get notifications =>
      _i18nText(key: I18nKeys.notifications, fallback: "Notifications");

  String get prayerNotifications => _i18nText(
    key: I18nKeys.prayerNotifications,
    fallback: "Prayer Notifications",
  );

  String get adhanSound =>
      _i18nText(key: I18nKeys.adhanSound, fallback: "Adhan Sound");

  String get fajr => _i18nText(key: I18nKeys.fajr, fallback: "Fajr");

  String get sunrise => _i18nText(key: I18nKeys.sunrise, fallback: "Sunrise");

  String get dhuhr => _i18nText(key: I18nKeys.dhuhr, fallback: "Dhuhr");

  String get asr => _i18nText(key: I18nKeys.asr, fallback: "Asr");

  String get maghrib => _i18nText(key: I18nKeys.maghrib, fallback: "Maghrib");

  String get isha => _i18nText(key: I18nKeys.isha, fallback: "Isha");

  String get silent => _i18nText(key: I18nKeys.silent, fallback: "Silent");

  String get makkah => _i18nText(key: I18nKeys.makkah, fallback: "Makkah");

  String get madina => _i18nText(key: I18nKeys.madina, fallback: "Madina");

  String get abdulBasit =>
      _i18nText(key: I18nKeys.abdulBasit, fallback: "Abdul Basit");
}
