part of app_strings;

extension DefaultStringQuickLinks on DefaultString {
  String get quickLinksTitle         => _i18nText(key: I18nKeys.quickLinksTitle,         fallback: "Quick Links");
  String get helpAndSupportTitle     => _i18nText(key: I18nKeys.helpAndSupportTitle,     fallback: "Help & Support");
  String get activateCards           => _i18nText(key: I18nKeys.activateCards,           fallback: "Activate\nCards");
  String get blockCards              => _i18nText(key: I18nKeys.blockCards,              fallback: "Block\nCards");
  String get internationalActivation => _i18nText(key: I18nKeys.internationalActivation, fallback: "International\nActivation");
  String get chequeBookRequest       => _i18nText(key: I18nKeys.chequeBookRequest,       fallback: "Cheque Book Request");
  String get activeCvv               => _i18nText(key: I18nKeys.activeCvv,               fallback: "Active CVV");
  String get applyNow                => _i18nText(key: I18nKeys.applyNow,                fallback: "Apply Now");
  String get cards                   => _i18nText(key: I18nKeys.cards,                   fallback: "Cards");
  String get loans                   => _i18nText(key: I18nKeys.loans,                   fallback: "Loans");
  String get insurance               => _i18nText(key: I18nKeys.insurance,               fallback: "Insurance");
  String get deposits                => _i18nText(key: I18nKeys.deposits,                fallback: "Deposits");
  String get branch                  => _i18nText(key: I18nKeys.branch,                  fallback: "Branch");
  String get atm                     => _i18nText(key: I18nKeys.atm,                     fallback: "ATM");
  String get whatsAppConnect         => _i18nText(key: I18nKeys.whatsAppConnect,         fallback: "WhatsApp\nConnect");
  String get contactUs               => _i18nText(key: I18nKeys.contactUs,               fallback: "Contact\nUs");
  String get faq                     => _i18nText(key: I18nKeys.faq,                     fallback: "FAQ");
  String get howToVideos             => _i18nText(key: I18nKeys.howToVideos,             fallback: "How to\nVideos");
  String get tc                      => _i18nText(key: I18nKeys.tc,                      fallback: "T&C");
  String get socioConnect            => _i18nText(key: I18nKeys.socioConnect,            fallback: "Socio Connect");
  String get dohaVersion             => _i18nText(key: I18nKeys.dohaVersion,             fallback: "Version $appVersion  Copyright © ${DateTime.now().year} Doha Bank");
}
