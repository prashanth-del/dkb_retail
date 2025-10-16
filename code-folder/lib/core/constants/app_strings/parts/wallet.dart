part of app_strings;

extension DefaultStringWallet on DefaultString {
  // --- Card Details ---
  String get walletBankName =>
      _i18nText(key: I18nKeys.walletBankName, fallback: "DUKHAN BANK");

  String get walletCardType =>
      _i18nText(key: I18nKeys.walletCardType, fallback: "VISA");

  String get walletCardNumber => _i18nText(
    key: I18nKeys.walletCardNumber,
    fallback: "1234 5678 9009 8765",
  );

  String get walletCardHolder =>
      _i18nText(key: I18nKeys.walletCardHolder, fallback: "MOHAMMED ALI");

  String get walletCardExpiry =>
      _i18nText(key: I18nKeys.walletCardExpiry, fallback: "08/28");

  // --- Carousel ---
  List<String> get walletCarouselTitles => [
    _i18nText(
      key: I18nKeys.walletCarouselTitle1,
      fallback: "Get Instant Cards with face of your choice",
    ),
    _i18nText(
      key: I18nKeys.walletCarouselTitle2,
      fallback: "Track your card spends and gain insights to save!",
    ),
    // _i18nText(
    //   key: I18nKeys.walletCarouselTitle3,
    //   fallback: "Discover new features",
    // ),
  ];

  List<String> get walletCarouselSubtitles => [
    _i18nText(
      key: I18nKeys.walletCarouselSubtitle1,
      fallback:
          "Earn up to 4%! Grow your savings today and achieve your financial goals as your money works for you.",
    ),
    _i18nText(
      key: I18nKeys.walletCarouselSubtitle2,
      fallback:
          "Track your spending to save money! Spot areas to cut back and improve financial choices.",
    ),
    // _i18nText(
    //   key: I18nKeys.walletCarouselSubtitle3,
    //   fallback: "Make the most of your banking experience",
    // ),
  ];

  String get walletLogin =>
      _i18nText(key: I18nKeys.walletLogin, fallback: "Login");
}
