part of app_strings;

extension DefaultStringForgotPassword on DefaultString {
  String get forgotCredentials => _i18nText(
    key: I18nKeys.forgotCredentials,
    fallback: "Forgot Credentials",
  );
  String get enterYourCardDetails => _i18nText(
    key: I18nKeys.enterYourCardDetails,
    fallback: "Enter Your Card Details",
  );
  String get enterCardNumber => _i18nText(
    key: I18nKeys.enterCardNumber,
    fallback: "Enter debit/prepaid card number",
  );
  String get pinHint => _i18nText(key: I18nKeys.pinHint, fallback: "----");
  String get getOtp => _i18nText(key: I18nKeys.getOtp, fallback: "Get OTP");

  String get otpDescriptionRegisteredNumber => _i18nText(
    key: I18nKeys.otpDescriptionRegisteredNumber,
    fallback: "You will receive the OTP on your registered mobile number",
  );
  String get confirmOrUpdateUsername => _i18nText(
    key: I18nKeys.confirmOrUpdateUsername,
    fallback: "Confirm or Update Username",
  );
  String get createSelectUsername => _i18nText(
    key: I18nKeys.createSelectUsername,
    fallback: "Create/ Select a username",
  );
  String get createStrongPassword => _i18nText(
    key: I18nKeys.createStrongPassword,
    fallback: "Create a Strong Password for Your Account",
  );
  String get passwordUpdatedSuccessfully => _i18nText(
    key: I18nKeys.passwordUpdatedSuccessfully,
    fallback: "Password Updated Successfully",
  );
}
