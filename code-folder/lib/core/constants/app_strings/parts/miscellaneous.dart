part of app_strings;

extension DefaultStringMiscelleneous on DefaultString {
  String get iDisagree =>
      _i18nText(key: I18nKeys.iDisagree, fallback: "I Disagree");
  String get iAgree => _i18nText(key: I18nKeys.iAgree, fallback: "I Agree");
  String get termsConditions => _i18nText(
      key: I18nKeys.termsConditions, fallback: "Terms And Conditions");
  String get userRegistration =>
      _i18nText(key: I18nKeys.userRegistration, fallback: "User Registration");
  String get debitCardNumber =>
      _i18nText(key: I18nKeys.debitCardNumber, fallback: "Debit card number");
  String get qId => _i18nText(key: I18nKeys.qId, fallback: "QID");
  String get userName =>
      _i18nText(key: I18nKeys.userName, fallback: "Username");
  String get enterQid =>
      _i18nText(key: I18nKeys.enterQid, fallback: "Enter QID");
  String get enterUsername =>
      _i18nText(key: I18nKeys.enterUsername, fallback: "Enter Username");
  String get setPassword =>
      _i18nText(key: I18nKeys.setPassword, fallback: "Set Password");
  String get enterPassword =>
      _i18nText(key: I18nKeys.enterPassword, fallback: "Enter Password");
  String get confirmPassword =>
      _i18nText(key: I18nKeys.confirmPassword, fallback: "Confirm Password");
  String get enhanceSecurity => _i18nText(
      key: I18nKeys.enhanceSecurity, fallback: "Enhance your security");
  String get enhanceSecuritySubText => _i18nText(
      key: I18nKeys.enhanceSecuritySubText,
      fallback:
          "Enhance the security by registering for biometric Authentication");
  String get enterMPin =>
      _i18nText(key: I18nKeys.enterMPin, fallback: "Enter pin");
  String get haveAgreedTo => _i18nText(
      key: I18nKeys.haveAgreedTo, fallback: "I have read and agree to the");
  String get termsAndConditions => _i18nText(
      key: I18nKeys.termsAndConditions, fallback: " terms and conditions.");
  String get welcomeToDohaBank => _i18nText(
      key: I18nKeys.welcomeToDohaBank, fallback: "Welcome to Doha Bank");
  String get successfullyRegisteredAccount => _i18nText(
      key: I18nKeys.successfullyRegisteredAccount,
      fallback:
          "You have successfully registered your account for mobile banking");
  String get continueToLogin =>
      _i18nText(key: I18nKeys.continueToLogin, fallback: "Continue to Login");
  String get sureWantToSkipBiometricRegistration => _i18nText(
      key: I18nKeys.sureWantToSkipBiometricRegistration,
      fallback: "Are you sure you want skip biometric registration?");
  String get termsAndConditionsHeaderText => _i18nText(
      key: I18nKeys.termsAndConditionsHeaderText,
      fallback: "Terms and Conditions");
  String get checkAvailability =>
      _i18nText(key: I18nKeys.checkAvailability, fallback: "Check Availablity");
  String get vouchers =>
      _i18nText(key: I18nKeys.vouchers, fallback: "Vouchers");
  String get offers => _i18nText(key: I18nKeys.offers, fallback: "Offers");
  String get validUpto =>
      _i18nText(key: I18nKeys.validUpto, fallback: "Valid upto:");
  String get clickHere =>
      _i18nText(key: I18nKeys.clickHere, fallback: "Click Here");
  String get forTermsAndConditions => _i18nText(
      key: I18nKeys.forTermsAndConditions,
      fallback: " for Terms and Conditions");
  String get expiredCoupons =>
      _i18nText(key: I18nKeys.expiredCoupons, fallback: "Expired Coupons");
  String get ok => _i18nText(key: I18nKeys.ok, fallback: "Ok");
  String get debitCardNumberFormat => _i18nText(
      key: I18nKeys.debitCardNumberFormat,
      fallback: "Enter first 8 & last 4 Digit Debit Card Number");
  String get funds =>
      _i18nText(key: I18nKeys.funds, fallback: "Source Of Funds");
  String get chargeType =>
      _i18nText(key: I18nKeys.chargeType, fallback: "All Charges Borne by Me");
  String get remittance =>
      _i18nText(key: I18nKeys.remittance, fallback: "Purpose of Remittance");
  String get debitCardHintText => _i18nText(
      key: I18nKeys.debitCardHintText, fallback: "____-____-XXXX-____");
  String get passwordDoNotMatch => _i18nText(
      key: I18nKeys.passwordDoNotMatch,
      fallback: "Password and Confirm Password do not match");
  String get account => _i18nText(
        key: I18nKeys.account,
        fallback: "Accounts",
      );
  String get usernameAvailable => _i18nText(
        key: I18nKeys.account,
        fallback: "Username is available",
      );
  String get usernameNotAvailable => _i18nText(
        key: I18nKeys.account,
        fallback: "Username is not available",
      );
  String get securityError           => _i18nText(key: I18nKeys.securityError,           fallback: "Security Error");
  String get securityDesc           => _i18nText(key: I18nKeys.securityDesc,           fallback: "Due to Security Reasons Application cannot be launched in this device.");
  String get exit           => _i18nText(key: I18nKeys.exit,           fallback: "Exit");
}
