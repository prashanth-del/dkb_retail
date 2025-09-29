part of app_strings;

/// These were previously static const on DefaultString. Keeping them as getters
/// means your call-sites can remain `DefaultString.instance.<name>`.
extension DefaultStringSchoolFees on DefaultString {
  String get schoolFeesPayment     => _i18nText(key: I18nKeys.schoolFeesPayment,     fallback: 'School Fees Payment');
  String get availableBalance      => _i18nText(key: I18nKeys.availableBalance,      fallback: 'Available Balance');
  String get saveTheBiller         => _i18nText(key: I18nKeys.saveTheBiller,         fallback: 'Save the Biller');
  String get nickname              => _i18nText(key: I18nKeys.nickname,              fallback: 'Nickname');
  String get enterNickname         => _i18nText(key: I18nKeys.enterNickname,         fallback: 'Enter Nickname');
  String get pleaseEnterNickname   => _i18nText(key: I18nKeys.pleaseEnterNickname,   fallback: 'Please enter Nickname');
  String get transactionRemarks    => _i18nText(key: I18nKeys.transactionRemarks,    fallback: 'Transaction Remarks');
  String get enterRemarks          => _i18nText(key: I18nKeys.enterRemarks,          fallback: 'Enter Remarks');
  String get pleaseEnterRemarks    => _i18nText(key: I18nKeys.pleaseEnterRemarks,    fallback: 'Please enter Remarks');
  String get note                  => _i18nText(key: I18nKeys.note,                  fallback: 'Note');
  String get paymentCreditNote     => _i18nText(key: I18nKeys.paymentCreditNote,     fallback: 'Payment Credit Note');
  String get payNow                => _i18nText(key: I18nKeys.payNow,                fallback: 'Pay Now');
  String get getBill               => _i18nText(key: I18nKeys.getBill,               fallback: 'Get Bill');
  String get studentName           => _i18nText(key: I18nKeys.studentName,           fallback: 'Student Name');
  String get studentId             => _i18nText(key: I18nKeys.studentId,             fallback: 'Student ID');
  String get enterStudentId        => _i18nText(key: I18nKeys.enterStudentId,        fallback: 'Enter Student ID');
  String get pleaseEnterStudentId  => _i18nText(key: I18nKeys.pleaseEnterStudentId,  fallback: 'Please Enter Student ID');
  String get studentIdMinLength    => _i18nText(key: I18nKeys.studentIdMinLength,    fallback: 'Student ID minimum length required');
  String get schoolName            => _i18nText(key: I18nKeys.schoolName,            fallback: 'School Name');
  String get pleaseSelect          => _i18nText(key: I18nKeys.pleaseSelect,          fallback: 'Please Select');
  String get pleaseEnterSchoolName => _i18nText(key: I18nKeys.pleaseEnterSchoolName, fallback: 'Please Enter School Name');
  String get billTerm              => _i18nText(key: I18nKeys.billTerm,              fallback: 'Bill Term');
  String get search                => _i18nText(key: I18nKeys.search,                fallback: 'Search');
  String get errorLoadingAccounts  => _i18nText(key: I18nKeys.errorLoadingAccounts,  fallback: 'Error loading accounts');
  String get paymentSuccessful     => _i18nText(key: I18nKeys.paymentSuccessful,     fallback: 'Payment Successful');
  String get payAnotherBill        => _i18nText(key: I18nKeys.payAnotherBill,        fallback: 'Pay Another Bill');
  String get billPeriod            => _i18nText(key: I18nKeys.billPeriod,            fallback: 'Bill Period');
  String get fromAccountNumber     => _i18nText(key: I18nKeys.fromAccountNumber,     fallback: 'From Account Number');
  String get referenceNumber       => _i18nText(key: I18nKeys.referenceNumber,       fallback: 'Reference Number');
  String get recordsNotFound       => _i18nText(key: I18nKeys.recordsNotFound,       fallback: 'Records not found');
}
