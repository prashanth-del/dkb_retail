part of app_strings;

extension DefaultStringLogin on DefaultString {
  String get loginPageTitle =>
      _i18nText(key: I18nKeys.loginPageTitle, fallback: "Login");
  String get userNameTextField =>
      _i18nText(key: I18nKeys.userNameTextField, fallback: "Enter Username");
  String get passwordTextField =>
      _i18nText(key: I18nKeys.passwordTextField, fallback: "Enter Password");
  String get forgetUsername =>
      _i18nText(key: I18nKeys.forgetUsername, fallback: "Forget Username?");
  String get forgetPassword =>
      _i18nText(key: I18nKeys.forgetPassword, fallback: "Forget Password?");
  String get loginButton =>
      _i18nText(key: I18nKeys.loginButton, fallback: "LOGIN");
  String get newUser => _i18nText(key: I18nKeys.newUser, fallback: "New User?");
  String get signUP => _i18nText(key: I18nKeys.signUP, fallback: "SIGN UP");
  String get passwdRstSucc => _i18nText(
    key: I18nKeys.passwdRstSucc,
    fallback: "Password reset successfully",
  );

  String get userIDTextField =>
      _i18nText(key: I18nKeys.userIDTextField, fallback: "Enter User ID");

  String get validationError =>
      _i18nText(key: I18nKeys.validationError, fallback: "Validation Error");

  String get becomeCustomer => _i18nText(
    key: I18nKeys.becomeCustomer,
    fallback: "Become a Doha Bank Customer",
  );

  String get openInstantAccount => _i18nText(
    key: I18nKeys.openInstantAccount,
    fallback: "0pen a New Account Instantly",
  );

  String get overlay => _i18nText(key: I18nKeys.overlay, fallback: "Overlay");

  String get customerNumberTextField => _i18nText(
    key: I18nKeys.customerNumberTextField,
    fallback: "Enter Customer Number",
  );
  /////////Reach_us/////////////
  String get reachUsTitle =>
      _i18nText(key: I18nKeys.reachUs, fallback: "Reach Us");
  String get faqsTitle => _i18nText(key: I18nKeys.reachUs, fallback: "FAQs");

  String get nearestBranchTitle =>
      _i18nText(key: I18nKeys.nearestBranch, fallback: "Nearest branch");
  String get cityCenterDohaLocation =>
      _i18nText(key: I18nKeys.cityCenterDoha, fallback: "City Center, Doha");
  String get bookAndMeetTitle =>
      _i18nText(key: I18nKeys.bookAndMeet, fallback: "Book and Meet");
  String get atTheBranchSubTitle =>
      _i18nText(key: I18nKeys.atTheBranch, fallback: "At the branch");
  String get weWillCallYouTitle =>
      _i18nText(key: I18nKeys.weWillCallYou, fallback: "We will call you");
  String get requestCallBackTitle =>
      _i18nText(key: I18nKeys.weWillCallYou, fallback: "Request Callback");
  String get callUsTitle =>
      _i18nText(key: I18nKeys.callUs, fallback: "Call Us");
  String get emailUsTitle =>
      _i18nText(key: I18nKeys.emailUs, fallback: "Email Us");
  String get followUsTitle =>
      _i18nText(key: I18nKeys.followUs, fallback: "Follow Us");
  String get facebookTitle =>
      _i18nText(key: I18nKeys.facebook, fallback: "Facebook");
  String get twitterTittle =>
      _i18nText(key: I18nKeys.twitter, fallback: "Twitter");
  String get instagramTittle =>
      _i18nText(key: I18nKeys.instagram, fallback: "Instagram");
  String get youtubeTittle =>
      _i18nText(key: I18nKeys.youTube, fallback: "YouTube");
  String get snapChatTittle =>
      _i18nText(key: I18nKeys.snapChat, fallback: "Snapchat");
  String get dukhanBankTittle =>
      _i18nText(key: I18nKeys.dukhanBank, fallback: "Dukhan Bank");

  String get searchForFaqTitle =>
      _i18nText(key: I18nKeys.searchForFaq, fallback: "Search for a FAQs");

  String get noResultSearch =>
      _i18nText(key: I18nKeys.noResultSearch, fallback: "No results found");
}
