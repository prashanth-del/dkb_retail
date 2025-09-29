part of app_strings;

extension DefaultStringTransfersPayments on DefaultString {
  String get payments => _i18nText(key: I18nKeys.payments, fallback: "Payment");
  String get fundTransfer =>
      _i18nText(key: I18nKeys.fundTransfer, fallback: "Fund Transfer");
  String get domesticTransfer =>
      _i18nText(key: I18nKeys.domesticTransfer, fallback: "Domestic Transfer");
  String get internationalTransfer => _i18nText(
      key: I18nKeys.internationalTransfer, fallback: "International Transfer");
  String get iftTransfer =>
      _i18nText(key: I18nKeys.iftTransfer, fallback: "International Transfer");
  String get toMyOwnDB =>
      _i18nText(key: I18nKeys.toMyOwnDB, fallback: "To My Own Account");
  String get toAnotherDB =>
      _i18nText(key: I18nKeys.toAnotherDB, fallback: "To Another DB Account");
  String get toAnotherLocal => _i18nText(
      key: I18nKeys.toAnotherLocal, fallback: "To Another Local Bank");
  String get dCardLess =>
      _i18nText(key: I18nKeys.dCardLess, fallback: "D-Cardless Withdrawal");
  String get cashPayout =>
      _i18nText(key: I18nKeys.cashPayout, fallback: "Cash Payout");
  String get masterCard =>
      _i18nText(key: I18nKeys.masterCard, fallback: "Master Card Transfer");
  String get westUnion => _i18nText(
      key: I18nKeys.westUnion, fallback: "Western Union Money Transfer");
  String get fawran => _i18nText(key: I18nKeys.fawran, fallback: "Fawran");
  String get favourites =>
      _i18nText(key: I18nKeys.favourites, fallback: "Favourites");
  String get transfer =>
      _i18nText(key: I18nKeys.transfer, fallback: "Transfer");
  String get history => _i18nText(key: I18nKeys.history, fallback: "History");
  String get profile => _i18nText(key: I18nKeys.profile, fallback: "Profile");
  String get schTransfer =>
      _i18nText(key: I18nKeys.schTransfer, fallback: "Schedule Transfer");
  String get tranStatus =>
      _i18nText(key: I18nKeys.tranStatus, fallback: "Transaction Status");
  String get donation =>
      _i18nText(key: I18nKeys.donation, fallback: "Donations");
  String get addBen =>
      _i18nText(key: I18nKeys.addBen, fallback: "Add Beneficiary");
  String get ben => _i18nText(key: I18nKeys.ben, fallback: "Beneficiary");
  String get viewBen =>
      _i18nText(key: I18nKeys.viewBen, fallback: "View Beneficiary");
  String get viewAll => _i18nText(key: I18nKeys.viewAll, fallback: "VIEW ALL");
  String get fromAccount =>
      _i18nText(key: I18nKeys.fromAccount, fallback: "From Account");
  String get sendTo => _i18nText(key: I18nKeys.sendTo, fallback: "Send To");
  String get beneficiary =>
      _i18nText(key: I18nKeys.beneficiary, fallback: "Select Beneficiary");
  String get amount => _i18nText(key: I18nKeys.amount, fallback: "Amount");
  String get transRemark => _i18nText(
      key: I18nKeys.transRemark, fallback: "Transaction Remark (Optional)");
  String get plsSelect =>
      _i18nText(key: I18nKeys.plsSelect, fallback: "Please Select");
  String get sendLater =>
      _i18nText(key: I18nKeys.sendLater, fallback: "Send Later");
  String get sendNow => _i18nText(key: I18nKeys.sendNow, fallback: "Send Now");
  String get searchBen =>
      _i18nText(key: I18nKeys.searchBen, fallback: "Search Beneficiary");
  String get selectBen =>
      _i18nText(key: I18nKeys.selectBen, fallback: "Select Beneficiary");
  String get addNew => _i18nText(key: I18nKeys.addNew, fallback: "Add New");
  String get noCardsAvailable =>
      _i18nText(key: I18nKeys.noCardsAvailable, fallback: "No cards available");
  String get mobileNumber =>
      _i18nText(key: I18nKeys.mobileNumber, fallback: "Mobile Number");
  String get selectCards =>
      _i18nText(key: I18nKeys.selectCards, fallback: "Select Card");
  String get Funds =>
      _i18nText(key: I18nKeys.Funds, fallback: "Source Of Funds");
  String get regisTermsAndCondText1 => _i18nText(
      key: I18nKeys.regisTermsAndCondText1,
      fallback:
          "These terms and conditions (\"Terms and Conditions\") set out the rights and obligations of you \"the customer\", and us, Doha Bank QSC \"Doha Bank\" in connection with your use of the Service. All the terms and conditions of this agreement are legally binding, so please read them through carefully before you agree to be bound by them.");
  String get regisTermsAndCondText2 =>
      _i18nText(key: I18nKeys.regisTermsAndCondText2, fallback: "Definitions");
  String get regisTermsAndCondText3 => _i18nText(
      key: I18nKeys.regisTermsAndCondText3,
      fallback:
          "The following terms when used in these Terms and Conditions shall have the meanings ascribed to such terms as under:");
  String get regisTermsAndCondText4 => _i18nText(
      key: I18nKeys.regisTermsAndCondText4,
      fallback:
          "Some words and expressions used in this agreement have particular meanings as follows:");
  String get regisTermsAndCondText5 => _i18nText(
      key: I18nKeys.regisTermsAndCondText5,
      fallback:
          "\"Business Day\" means any day except a Friday, Saturday or public holiday in Qatar. Otherwise defined as any day on which banks are open for transaction of business in Qatar.");
  String get regisTermsAndCondText6 => _i18nText(
      key: I18nKeys.regisTermsAndCondText6,
      fallback:
          "\"Password\" means the Electronic Banking personal identification number or secret number chosen by you (or if you do not elect to change it, the initial secret number given to you) that is used to confirm your identity whenever you use the Service.");
  String get regisTermsAndCondText7 => _i18nText(
      key: I18nKeys.regisTermsAndCondText7,
      fallback:
          "\"Security Codes\" means the user identification code together with the Password details agreed between you and us that are used to identify you whenever you use the Service.");
  String get regisTermsAndCondText8 => _i18nText(
      key: I18nKeys.regisTermsAndCondText8,
      fallback:
          "\"Service\" means the services provided by us which enable you to obtain information from us and give instructions to us by computer, telephone, mobile telephone, watch, personal digital assistant or other device linked to our system by any means (among other things).");
  String get regisTermsAndCondText9 => _i18nText(
      key: I18nKeys.regisTermsAndCondText9,
      fallback:
          "\"Service Software\" means any software supplied to you whenever you access the Service and any other software we supply to you for the purpose of accessing the Service from time to time.");
  String get vouchersAndOffers =>
      _i18nText(key: I18nKeys.vouchersAndOffers, fallback: "Vouchers & Offers");
  String get failLoadAccount => _i18nText(
      key: I18nKeys.failLoadAccount, fallback: "Failed To Load Accounts");
  String get from => _i18nText(key: I18nKeys.from, fallback: "From");
  String get selectType =>
      _i18nText(key: I18nKeys.selectType, fallback: "Select Type");
  String get individual =>
      _i18nText(key: I18nKeys.individual, fallback: "Individual");
  String get corporate =>
      _i18nText(key: I18nKeys.corporate, fallback: "Corporate");
  String get aliasType =>
      _i18nText(key: I18nKeys.aliasType, fallback: "Alias Type");
  String get aliasID => _i18nText(key: I18nKeys.aliasID, fallback: "Alias ID");
  String get iBan => _i18nText(key: I18nKeys.iBan, fallback: "IBAN");
  String get crNumber =>
      _i18nText(key: I18nKeys.crNumber, fallback: "CR Number");
  String get establishmentID =>
      _i18nText(key: I18nKeys.establishmentID, fallback: "Establishment ID");
  String get coIbanNumber =>
      _i18nText(key: I18nKeys.coIbanNumber, fallback: "Corporate IBAN Number");
  String get fawranHistory =>
      _i18nText(key: I18nKeys.fawranHistory, fallback: "Fawran History");
  String get transactions =>
      _i18nText(key: I18nKeys.transactions, fallback: "Transactions");
  String get purposeOfTran =>
      _i18nText(key: I18nKeys.purposeOfTran, fallback: "Purpose Of Transfer");

  // sender information
  String get sendInformation =>
      _i18nText(key: I18nKeys.sendInformation, fallback: "Send Information");
  String get senderFullName =>
      _i18nText(key: I18nKeys.senderFullName, fallback: "Sender Full Name");
  String get dateOfBirth =>
      _i18nText(key: I18nKeys.dateOfBirth, fallback: "Date of Birth");
  String get localAddress =>
      _i18nText(key: I18nKeys.localAddress, fallback: "Local Address");
  String get placeOfBirth =>
      _i18nText(key: I18nKeys.placeOfBirth, fallback: "Place of Birth");
  String get qidExpiryDate =>
      _i18nText(key: I18nKeys.qidExpiryDate, fallback: "QID Expiry Date");
  String get passportNumber =>
      _i18nText(key: I18nKeys.passportNumber, fallback: "Passport Number");
  String get city => _i18nText(key: I18nKeys.city, fallback: "City");
  String get next => _i18nText(key: I18nKeys.next, fallback: "Next");
  String get grossAmount => _i18nText(
      key: I18nKeys.grossAmount,
      fallback: "• Total gross amount will be debited from the account");
}
