part of app_strings;

extension DefaultStringRegistration on DefaultString {
  String get registrationCard => _i18nText(
    key: I18nKeys.registrationCard,
    fallback: "Register Using Card",
  );
  String get registrationQIDPassport => _i18nText(
    key: I18nKeys.registrationQIDPassport,
    fallback: "Enter QID/passport",
  );
  String get enterRegisteredMobileNumber => _i18nText(
    key: I18nKeys.enterRegisteredMobileNumber,
    fallback: "Enter Registered Mobile number",
  );
  String get next => _i18nText(key: I18nKeys.next, fallback: "Next");
  String get enterDebitPerpaidCardNumber => _i18nText(
    key: I18nKeys.enterDebitPerpaidCardNumber,
    fallback: "Enter Debit/Perpaid Card Number",
  );

  String get enterPin =>
      _i18nText(key: I18nKeys.enterPin, fallback: "Enter PIN");

  String get acceptTermsMessage => _i18nText(
    key: I18nKeys.acceptTermsMessage,
    fallback: "By clicking on Next you accept our  ",
  );

  String get termsAndConditions => _i18nText(
    key: I18nKeys.termsAndConditions,
    fallback: "Terms and Conditions",
  );

  String get enterOtp =>
      _i18nText(key: I18nKeys.enterOtp, fallback: "Enter OTP");

  String get otpReceiveMessage => _i18nText(
    key: I18nKeys.otpReceiveMessage,
    fallback: "You will receive the OTP on your registered mobile number.",
  );

  String get verify => _i18nText(key: I18nKeys.verify, fallback: "Verify");

  String get createUsername =>
      _i18nText(key: I18nKeys.createUsername, fallback: "Create Username");

  String get availableUsernames => _i18nText(
    key: I18nKeys.availableUsernames,
    fallback: "Available usernames for you",
  );

  String get setNewPassword =>
      _i18nText(key: I18nKeys.setNewPassword, fallback: "Set New Password");

  String get confirmPassword =>
      _i18nText(key: I18nKeys.confirmPassword, fallback: "Confirm Password");

  String get createPin =>
      _i18nText(key: I18nKeys.createPin, fallback: "Create PIN");

  String get confirmPin =>
      _i18nText(key: I18nKeys.confirmPin, fallback: "Confirm PIN");

  String get cardActivatedSuccessfully => _i18nText(
    key: I18nKeys.cardActivatedSuccessfully,
    fallback: "Card Activated Successfully",
  );

  String get cardInactiveMessage => _i18nText(
    key: I18nKeys.cardInactiveMessage,
    fallback: "You card is inactive\nKindly activate your card to register",
  );

  String get register =>
      _i18nText(key: I18nKeys.register, fallback: "Register");

  String get activateNow =>
      _i18nText(key: I18nKeys.activateNow, fallback: "Activate Now");

  String get resendOtp =>
      _i18nText(key: I18nKeys.resendOtp, fallback: "Resend OTP");

  String get enterValidPassword => _i18nText(
    key: I18nKeys.enterValidPassword,
    fallback: "Enter Valid Password",
  );
  String get enterQidPassportAndMobileNumber => _i18nText(
    key: I18nKeys.enterQidPassportAndMobileNumber,
    fallback: "Enter QID/Passport and mobile number",
  );

  String get createOrSelectAUsername => _i18nText(
    key: I18nKeys.createOrSelectAUsername,
    fallback: "Create / Select a username",
  );

  String get enterYourDebitOrPrepaidCardNumber => _i18nText(
    key: I18nKeys.enterYourDebitOrPrepaidCardNumber,
    fallback: "Enter your debit or prepaid card number",
  );

  String get createNewPinToActivateYourCard => _i18nText(
    key: I18nKeys.createNewPinToActivateYourCard,
    fallback: "Create new PIN to activate your card",
  );

  String get oopsYourCardIsInactive => _i18nText(
    key: I18nKeys.oopsYourCardIsInactive,
    fallback: "Oops! Your card is inactive",
  );

  String get yourInterests =>
      _i18nText(key: I18nKeys.yourInterests, fallback: "Your Interests?");

  String get selectYourInterestsToCurateYourExperience => _i18nText(
    key: I18nKeys.selectYourInterestsToCurateYourExperience,
    fallback: "Select Your Interests to curate your experience",
  );

  String get registrationCompletedSuccessfully => _i18nText(
    key: I18nKeys.registrationCompletedSuccessfully,
    fallback: "Registration Completed Successfully",
  );

  String get takingYouToLogin => _i18nText(
    key: I18nKeys.takingYouToLogin,
    fallback: "Taking you to login",
  );

  String get completeRegistration => _i18nText(
    key: I18nKeys.completeRegistration,
    fallback: "Complete Registration",
  );

  String get skipForNow =>
      _i18nText(key: I18nKeys.skipForNow, fallback: "Skip For now");

  String get youCanSetYourInterestLaterOnceYouLogin => _i18nText(
    key: I18nKeys.youCanSetYourInterestLaterOnceYouLogin,
    fallback: "You can set your interest later once you login",
  );

  String get products =>
      _i18nText(key: I18nKeys.products, fallback: "Products");

  String get apply => _i18nText(key: I18nKeys.apply, fallback: "Apply");

  String get contactDetails =>
      _i18nText(key: I18nKeys.contactDetails, fallback: "Contact Details");

  String get provideYourDetailsAndWeWillCallYouToExplainTheProduct => _i18nText(
    key: I18nKeys.provideYourDetailsAndWeWillCallYouToExplainTheProduct,
    fallback:
        "Provide your details, and we'll call you to explain the product.",
  );
}
