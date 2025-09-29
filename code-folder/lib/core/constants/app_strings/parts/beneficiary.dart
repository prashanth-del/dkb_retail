part of app_strings;

extension DefaultStringBeneficiary on DefaultString {
  String get country           => _i18nText(key: I18nKeys.country,           fallback: "Country");
  String get beneFullName      => _i18nText(key: I18nKeys.beneFullName,      fallback: "Beneficiary Full Name");
  String get beneNickName      => _i18nText(key: I18nKeys.beneNickName,      fallback: "Beneficiary Nick Name");
  String get beneAddress       => _i18nText(key: I18nKeys.beneAddress,       fallback: "Beneficiary Address");
  String get beneCity          => _i18nText(key: I18nKeys.beneCity,          fallback: "City");
  String get beneRelationship  => _i18nText(key: I18nKeys.beneRelationship,  fallback: "Beneficiary Relationship");
  String get beneAccountNo     => _i18nText(key: I18nKeys.beneAccountNo,     fallback: "Beneficiary Account Number/IBAN");
  String get swiftCode         => _i18nText(key: I18nKeys.swiftCode,         fallback: "Swift Code");
  String get bankName          => _i18nText(key: I18nKeys.bankName,          fallback: "Bank Name");
  String get branchName        => _i18nText(key: I18nKeys.branchName,        fallback: "Branch Name");
  String get branchAddress     => _i18nText(key: I18nKeys.branchAddress,     fallback: "Branch Address");
  String get sortCode          => _i18nText(key: I18nKeys.sortCode,          fallback: "Sort Code");
  String get bankSwiftCode     => _i18nText(key: I18nKeys.bankSwiftCode,     fallback: "Intermediary Bank SWIFT code (Optional)");
  String get purpose           => _i18nText(key: I18nKeys.purpose,           fallback: "Purpose");
  String get benRelation       => _i18nText(key: I18nKeys.benRelation,       fallback: "Beneficiary Relationship");
  String get youSend           => _i18nText(key: I18nKeys.youSend,           fallback: "You Send");
  String get recGet            => _i18nText(key: I18nKeys.recGet,            fallback: "Recipient Gets");
  String get remitCurrency     => _i18nText(key: I18nKeys.remitCurrency,     fallback: "Remit Currency");
  String get selectBenCountry  => _i18nText(key: I18nKeys.selectBenCountry,  fallback: "Select your Countries");
  String get currency          => _i18nText(key: I18nKeys.currency,          fallback: "Currency");
  String get beneType          => _i18nText(key: I18nKeys.beneType,          fallback: "Beneficiary Type");
  String get donationAmount    => _i18nText(key: I18nKeys.donationAmount,    fallback: "Donation Amount");
}
