part of app_strings;

extension DefaultStringRates on DefaultString {
  String get fxRatesTitle =>
      _i18nText(key: I18nKeys.fxRatesTitle, fallback: "FX Rates");

  String get profitRatesTitle =>
      _i18nText(key: I18nKeys.profitRatesTitle, fallback: "Profit Rates");

  String get productTimeDeposit =>
      _i18nText(key: I18nKeys.productTimeDeposit, fallback: "Time Deposit");

  String get productSavings =>
      _i18nText(key: I18nKeys.productSavings, fallback: "Savings");

  String get productFaseel =>
      _i18nText(key: I18nKeys.productFaseel, fallback: "Faseel");

  String get productExceptionalSavingPlus => _i18nText(
    key: I18nKeys.productExceptionalSavingPlus,
    fallback: "Exceptional Saving Plus",
  );

  String get productProfitInAdvanceDeposit => _i18nText(
    key: I18nKeys.productProfitInAdvanceDeposit,
    fallback: "Profit in Advance Deposit",
  );

  String get productExceptionalSavings => _i18nText(
    key: I18nKeys.productExceptionalSavings,
    fallback: "Exceptional Savings",
  );

  String get noDataAvailable =>
      _i18nText(key: I18nKeys.noDataAvailable, fallback: "No data available");

  String get tagRetail => _i18nText(
      key: I18nKeys.tagRetail,
      fallback: "RET"
  );

  String get categoryRetail => _i18nText(
      key: I18nKeys.categoryRetail,
      fallback: "Retail"
  );

  String get buy => _i18nText(
      key: I18nKeys.buy,
      fallback: "Buy"
  );

  String get sell => _i18nText(
      key: I18nKeys.sell,
      fallback: "Sell"
  );

  String get chooseCurrency => _i18nText(
      key: I18nKeys.chooseCurrency,
      fallback: "Choose Currency"
  );

  String get searchCurrency => _i18nText(
      key: I18nKeys.searchCurrency,
      fallback: "Search Currency"
  );

  String get chooseRateType => _i18nText(
    key: I18nKeys.chooseRateType,
    fallback: "Choose the rates type",
  );

  String get creationDate => _i18nText(
      key: I18nKeys.creationDate,
      fallback: "Creation Date"
  );

  String get lastMonthDate => _i18nText(
      key: I18nKeys.lastMonthDate,
      fallback: "Last Month Date"
  );

  String get growthTillDate => _i18nText(
      key: I18nKeys.growthTillDate,
      fallback: "Growth till date"
  );

  String get category => _i18nText(
      key: I18nKeys.category,
      fallback: "Category"
  );

  String get done => _i18nText(
      key: I18nKeys.done,
      fallback: "Done"
  );
}
