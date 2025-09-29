part of app_strings;

extension DefaultStringBiometric on DefaultString {
  String get biometricDisableSuccessDesc => _i18nText(key: I18nKeys.biometricDisableSuccessDesc, fallback: "Biometric disabled successfully");
  String get biometricDisableMsg         => _i18nText(key: I18nKeys.biometricDisableMsg,         fallback: "Are you sure want to disable the biometric set-up?");
  String get biometric                   => _i18nText(key: I18nKeys.biometric,                   fallback: "Biometric");
  String get biometricAccess             => _i18nText(key: I18nKeys.biometricAccess,             fallback: "Biometric Access");
  String get biometricSuccessDesc        => _i18nText(key: I18nKeys.biometricSuccessDesc,        fallback: "You can now login using using your registered biometric");
  String get biometricSuccessTitle       => _i18nText(key: I18nKeys.biometricSuccessTitle,       fallback: "Biometric Enabled Successfully");
  String get proceedToLogin              => _i18nText(key: I18nKeys.proceedToLogin,              fallback: "Proceed to login");
  String get noBiometricAvailableDesc    => _i18nText(key: I18nKeys.noBiometricAvailableDesc,    fallback: "To enable this feature, first setup biometric unlock in your device settings.");
  String get biometricSecurityTips       => _i18nText(key: I18nKeys.biometricSecurityTips,       fallback: "Biometric Security Tips");
  String get enableYourSecurity          => _i18nText(key: I18nKeys.enableYourSecurity,          fallback: "Enable Your Security");
  String get enableBiometricDesc         => _i18nText(key: I18nKeys.enableBiometricDesc,         fallback: "Enhance the security by registering for biometric Authentication.");
  String get biometricAuthentication     => _i18nText(key: I18nKeys.biometricAuthentication,     fallback: "Biometric Authentication");
  String get mPin                        => _i18nText(key: I18nKeys.mPin,                        fallback: "mPin");
  String get mPinSetup                   => _i18nText(key: I18nKeys.mPinSetup,                   fallback: "mPin Setup");
  String get enterYourMPin               => _i18nText(key: I18nKeys.enterYourMPin,               fallback: "Enter your mPin");
  String get confirmMPin                 => _i18nText(key: I18nKeys.confirmMPin,                 fallback: "Confirm mPin");
  String get skipBiometricSetup          => _i18nText(key: I18nKeys.skipBiometricSetup,          fallback: "Skip Biometric Setup");
  String get skipBiometricMsg            => _i18nText(key: I18nKeys.skipBiometricMsg,            fallback: "Are you sure you want to skip biometric registration?");
  String get biometricSecurityTipsContent=> _i18nText(key: I18nKeys.biometricSecurityTipsContent,fallback: "Biometric Security Tips Content");
  String get useRegistration             => _i18nText(key: I18nKeys.useRegistration,             fallback: "User Registration");
  String get biometrics                  => _i18nText(key: I18nKeys.biometrics,                  fallback: "Biometrics");
  String get deRegister                  => _i18nText(key: I18nKeys.deRegister,                  fallback: "De-Register");
  String get deRegisterDesc              => _i18nText(key: I18nKeys.deRegisterDesc,              fallback: "Are you sure want to de-register biometrics for this user?");
  String get enableBiometrics            => _i18nText(key: I18nKeys.enableBiometrics,            fallback: "Enable Biometrics");
  String get enhanceYourSecurity         => _i18nText(key: I18nKeys.enhanceYourSecurity,         fallback: "Enhance your security");
  String get enhanceSecuritySubtext      => _i18nText(key: I18nKeys.enhanceSecuritySubtext,      fallback: "Enhance the security by registering for biometric authentication.");
  String get enterPin                    => _i18nText(key: I18nKeys.enterPin,                    fallback: "Enter pin");
  String get setMPin                     => _i18nText(key: I18nKeys.setMPin,                     fallback: "Set mPin");
  String get confirmPin                  => _i18nText(key: I18nKeys.confirmPin,                  fallback: "Confirm pin");
  String get toggle                      => _i18nText(key: I18nKeys.toggle,                      fallback: "Toggle");
  String get readAgree                   => _i18nText(key: I18nKeys.readAgree,                   fallback: "I have read and agree to the ");
  String get pinMustBe4Digits            => _i18nText(key: I18nKeys.pinMustBe4Digits,            fallback: "PIN must be 4 digits");
  String get pinDoNotMatch               => _i18nText(key: I18nKeys.pinDoNotMatch,               fallback: "Pin and Confirm Pin do not match");
}
