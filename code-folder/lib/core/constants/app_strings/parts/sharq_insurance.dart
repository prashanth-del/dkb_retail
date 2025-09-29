part of app_strings;

extension DefaultStringSharqInsurance on DefaultString {
  // --------------------
  // Sharq Insurance Payment
  // --------------------
  String get sharqInsurancePayment => _i18nText(
      key: I18nKeys.sharqInsurancePayment, fallback: "Sharq Insurance Payment");
  String get policyNumber =>
      _i18nText(key: I18nKeys.policyNumber, fallback: "Policy Number");
  String get enterPolicyNumber => _i18nText(
      key: I18nKeys.enterPolicyNumber, fallback: "Enter Policy Number");
  String get insuredName =>
      _i18nText(key: I18nKeys.insuredName, fallback: "Insured Name");
  String get enterInsuredName =>
      _i18nText(key: I18nKeys.enterInsuredName, fallback: "Enter Insured Name");
  String get payerQid =>
      _i18nText(key: I18nKeys.payerQid, fallback: "Payer QID");
  String get enterPayerQid =>
      _i18nText(key: I18nKeys.enterPayerQid, fallback: "Enter Payer QID");
  String get payerEmail =>
      _i18nText(key: I18nKeys.payerEmail, fallback: "Payer Email");
  String get enterEmail =>
      _i18nText(key: I18nKeys.enterEmail, fallback: "Enter Email");
  String get payerMobile =>
      _i18nText(key: I18nKeys.payerMobile, fallback: "Payer Mobile");
  String get enterMobile =>
      _i18nText(key: I18nKeys.enterMobile, fallback: "Enter Mobile");
  String get paymentDescription => _i18nText(
      key: I18nKeys.paymentDescription, fallback: "Payment Description");
  String get enterPaymentDescription => _i18nText(
      key: I18nKeys.enterPaymentDescription,
      fallback: "Enter Payment Description");
  String get sharqInfoNote1 => _i18nText(
      key: I18nKeys.sharqInfoNote1,
      fallback:
          "Please refer the insurance policy documents for the Policy number, Insured Name and Payment Amount. Sample Policy Number format : P1/50/1501/16/12345");
  String get sharqInfoNote2 => _i18nText(
      key: I18nKeys.sharqInfoNote2,
      fallback:
          "Please make sure to input the correct policy number and other details. In case of any enquiries related to the insurance payment, please contact SharqFinance@Sharqinsurance.com.qa");
}
