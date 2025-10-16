part of app_strings;

extension DefaultStringLogin on DefaultString {
  String get loginPageTitle =>
      _i18nText(key: I18nKeys.loginPageTitle, fallback: "Login");
  String get userNameTextField =>
      _i18nText(key: I18nKeys.userNameTextField, fallback: "Username");
  String get passwordTextField =>
      _i18nText(key: I18nKeys.passwordTextField, fallback: "Password");
  String get forgetPassword =>
      _i18nText(key: I18nKeys.forgetPassword, fallback: "Forget Password?");
  String get registerNow =>
      _i18nText(key: I18nKeys.registerNow, fallback: "Register Now");

  //bottom bar
  String get emergencyBlock =>
      _i18nText(key: I18nKeys.emergencyBlock, fallback: "Emergency Block");

  String get rates => _i18nText(key: I18nKeys.rates, fallback: "Rates");

  String get more => _i18nText(key: I18nKeys.more, fallback: "More");

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
  String get enableLocation => _i18nText(
    key: I18nKeys.enableLocation,
    fallback:
        "Please enable location to view nearest branch/atm/kioskPlease enable location to view nearest branch/atm/kiosk",
  );
  String get requestCallback =>
      _i18nText(key: I18nKeys.requestCallback, fallback: "Request CallBack");

  String get mobileNum =>
      _i18nText(key: I18nKeys.mobileNumberRequest, fallback: "Mobile Number");
  String get emailOptional =>
      _i18nText(key: I18nKeys.emailOptional, fallback: "Email (Optional)");

  String get reason => _i18nText(key: I18nKeys.reason, fallback: "Reason");
  String get selectReason =>
      _i18nText(key: I18nKeys.selectReason, fallback: "Select Reason");

  String get all => _i18nText(key: I18nKeys.All, fallback: "All");
  String get branchFilter =>
      _i18nText(key: I18nKeys.BranchFilter, fallback: "Branch");
  String get atmFilter => _i18nText(key: I18nKeys.AtmFilter, fallback: "ATM");
  String get kiosk => _i18nText(key: I18nKeys.kiosk, fallback: "Kiosk");
  String get locateUs =>
      _i18nText(key: I18nKeys.locateUs, fallback: "locate Us");
  String get direction =>
      _i18nText(key: I18nKeys.direction, fallback: "Directions");
  String get nextTitle => _i18nText(key: I18nKeys.nextTitle, fallback: "Next");

  String get requiredFieldTitle => _i18nText(
    key: I18nKeys.requiredTitle,
    fallback: "This field is required",
  );
  String get onlyNumberValidate => _i18nText(
    key: I18nKeys.onlyNumberValidate,
    fallback: "Only numeric digits are allowed",
  );

  String get mobileNumberValidate => _i18nText(
    key: I18nKeys.mobileNumberValidate,
    fallback: "Mobile number should be of 8 characters.",
  );
  String get qatarMobileValidate => _i18nText(
    key: I18nKeys.mobileQatarValidate,
    fallback: "Mobile number should start only with 3, 5, 6 and 7",
  );
  String get fullNameValidate => _i18nText(
    key: I18nKeys.fullNameValidate,
    fallback: "Only alphabets and spaces are allowed",
  );
  String get nameSpaceValidate => _i18nText(
    key: I18nKeys.nameSpaceValidate,
    fallback: "The name should consist of two words separated by a space",
  );
  String get nameProfanityValidate => _i18nText(
    key: I18nKeys.nameProfanityValidate,
    fallback: "Inappropriate words are not allowed",
  );

  String get emailValidate => _i18nText(
    key: I18nKeys.emailValidate,
    fallback: "Enter a valid email address",
  );
  String get nearestTitle =>
      _i18nText(key: I18nKeys.nearestTitle, fallback: 'Nearest');
  String get allBranchesTitle =>
      _i18nText(key: I18nKeys.allBranchesTitle, fallback: 'All Branches');
  String get allKiosksTitle =>
      _i18nText(key: I18nKeys.allKiosks, fallback: 'All Kiosks');

  String get allAtmsTitle =>
      _i18nText(key: I18nKeys.allAtms, fallback: 'All ATMs');

  String get cashDepositTitle =>
      _i18nText(key: I18nKeys.cashDeposit, fallback: 'Cash Deposit');

  String get cashWithdrawalsTitle =>
      _i18nText(key: I18nKeys.cashWithdrawals, fallback: 'Cash Withdrawals');

  String get chequeDepositTitle =>
      _i18nText(key: I18nKeys.chequeDeposit, fallback: 'cheque Deposit');
  String get specialNeedsTitle =>
      _i18nText(key: I18nKeys.specialNeeds, fallback: 'special Needs');
  String get someThingError => _i18nText(
    key: I18nKeys.someThingError,
    fallback: 'Something went wrong. Please try again later',
  );

  String get noEmailConfigured => _i18nText(
    key: I18nKeys.noEmailConfigured,
    fallback:
        'No email application configured. Please set up your email account to use this feature',
  );
  String get branchNameLoading => _i18nText(
    key: I18nKeys.branchNameLoading,
    fallback: 'Fetching nearest branch...',
  );
  String get successRequestTitle => _i18nText(
    key: I18nKeys.successRequest,
    fallback: 'Thank you for your callback request',
  );
  String get weWillCallYouWithin1dayTitle => _i18nText(
    key: I18nKeys.weWillCallYouWithin1day,
    fallback: "We will call you back within 1 business day",
  );
  String get referenceNumTitle =>
      _i18nText(key: I18nKeys.referenceNum, fallback: "Reference number:");

  String get bookAnAppointment => _i18nText(
    key: I18nKeys.bookAnAppointment,
    fallback: "Book your appointment at the bank you wish you meet us.",
  );
  String get doneTitle => _i18nText(key: I18nKeys.done, fallback: "Done");
  String get kiosks => _i18nText(key: I18nKeys.kiosks, fallback: "Kiosks");
  String get atms => _i18nText(key: I18nKeys.atms, fallback: "ATMs");
  String get branches =>
      _i18nText(key: I18nKeys.branches, fallback: "Branches");

  String get operationHours =>
      _i18nText(key: I18nKeys.OperationHours, fallback: "Operation Hours");

  String get infoTitle => _i18nText(key: I18nKeys.infoTitle, fallback: "Info");

  String get okTitle => _i18nText(key: I18nKeys.okTitle, fallback: "Ok");

  //prayer
  String get nextPrayerTime =>
      _i18nText(key: I18nKeys.nextPrayerTime, fallback: "Next Prayer Time");
}
