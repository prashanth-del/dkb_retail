part of app_strings;

extension DefaultStringOTP on DefaultString {
  String get otpAuthenticationText =>
      _i18nText(key: I18nKeys.otpAuthenticationText, fallback: "e-OTP has been sent to your registered mobile number/email. Please enter the same to proceed further.");
}
