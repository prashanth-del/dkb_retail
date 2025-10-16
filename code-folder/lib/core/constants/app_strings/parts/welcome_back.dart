part of app_strings;

extension DefaultStringWelcomeBack on DefaultString {
  String get welcomeBack =>
      _i18nText(key: I18nKeys.welcomeBack, fallback: "Welcome back,");

  String get switchProfile =>
      _i18nText(key: I18nKeys.switchProfile, fallback: "Switch Profile");

  String get login => _i18nText(key: I18nKeys.login, fallback: "Login");

  String get useFaceId =>
      _i18nText(key: I18nKeys.useFaceId, fallback: "Use Face ID");

  String get useFingerprint =>
      _i18nText(key: I18nKeys.useFingerprint, fallback: "Use fingerprint");

  String get forgotUsernamePassword => _i18nText(
    key: I18nKeys.forgotUsernamePassword,
    fallback: "Forgot Username/Password?",
  );

  String get viewAccountBalance => _i18nText(
    key: I18nKeys.viewAccountBalance,
    fallback: "View Account Balance",
  );

  String get biometricNotAvailable => _i18nText(
    key: I18nKeys.biometricNotAvailable,
    fallback: "Biometric authentication not available",
  );

  String get fingerprintNotAvailable => _i18nText(
    key: I18nKeys.fingerprintNotAvailable,
    fallback: "Fingerprint not available on this device",
  );

  String get faceIdNotAvailable => _i18nText(
    key: I18nKeys.faceIdNotAvailable,
    fallback: "Face ID not available on this device",
  );

  String get authFingerprintReason => _i18nText(
    key: I18nKeys.authFingerprintReason,
    fallback: "Authenticate with Fingerprint to login",
  );

  String get authFaceIdReason => _i18nText(
    key: I18nKeys.authFaceIdReason,
    fallback: "Authenticate with Face ID to login",
  );

  String get passwordEmptyError => _i18nText(
    key: I18nKeys.passwordEmptyError,
    fallback: "Password cannot be empty.",
  );
}
