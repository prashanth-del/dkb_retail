part of app_strings;

extension DefaultStringAmexCardPayment on DefaultString {
  // --------------------
  // AMEX Card Payment
  // --------------------
  String get amexCardNumber =>
      _i18nText(key: I18nKeys.amexCardNumber, fallback: "Amex Card Number");
  String get enterAmexCardNumber => _i18nText(
      key: I18nKeys.enterAmexCardNumber, fallback: "Enter Amex Card Number");
  String get cardHolderName =>
      _i18nText(key: I18nKeys.cardHolderName, fallback: "Card Holder Name");
  String get enterCardHolderName => _i18nText(
      key: I18nKeys.enterCardHolderName, fallback: "Enter Card Holder Name");
  String get amexInfoNote1 => _i18nText(
      key: I18nKeys.amexInfoNote1,
      fallback:
          "If the Amex Card billing currency is same as the currency of payment, exact payment received will be credited to the Amex card account. If payment is not in the Amex Card billing currency, Amex will apply their own conversion rates.");
  String get amexInfoNote2 => _i18nText(
      key: I18nKeys.amexInfoNote2,
      fallback: "Maximum allowed payment amount is QAR36,000 only.");
}
