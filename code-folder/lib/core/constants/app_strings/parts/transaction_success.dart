part of app_strings;

extension DefaultStringTransactionSuccess on DefaultString {
  String get transactionSuccessful => _i18nText(key: I18nKeys.transactionSuccessful, fallback: "Transaction Successful");
  String get shareDownload         => _i18nText(key: I18nKeys.shareDownload,         fallback: "Share / Download");
  String get favourite             => _i18nText(key: I18nKeys.favourite,             fallback: "Favourite");
  String get makeAnotherTransfer   => _i18nText(key: I18nKeys.makeAnotherTransfer,   fallback: "Make Another Transfer");
  String get dueBills              => _i18nText(key: I18nKeys.dueBills,              fallback: "Due Bills");
  String get total                 => _i18nText(key: I18nKeys.total,                 fallback: "Total");
  String get billPaymentStatus     => _i18nText(key: I18nKeys.billPaymentStatus,     fallback: "Bill Payment Status");
  String get due                   => _i18nText(key: I18nKeys.due,                   fallback: "Due");
  String get otpAuthenticaiton     => _i18nText(key: I18nKeys.otpAuthenticaiton,     fallback: "OTP Authentication");
  String get pay                   => _i18nText(key: I18nKeys.pay,                   fallback: "PAY");
  String get refNo                 => _i18nText(key: I18nKeys.refNo,                 fallback: "Ref No.");
  String get qatarCurrencyCode     => _i18nText(key: I18nKeys.qatarCurrencyCode,     fallback: "QAR");
  String get download              => _i18nText(key: I18nKeys.download,              fallback: "Download");
  String get serviceNo             => _i18nText(key: I18nKeys.serviceNo,             fallback: "Service No.");
  String get confirm               => _i18nText(key: I18nKeys.confirm,               fallback: "CONFIRM");
  String get confirmTransaction    => _i18nText(key: I18nKeys.confirmTransaction,    fallback: "Confirm Transaction");
}
