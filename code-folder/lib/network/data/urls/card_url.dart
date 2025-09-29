class CardUrl {
  CardUrl._();

  static const getCardSummaryEndpoint = '/card-service/v1/summary';
  static const getCardStatementEndpoint =
      '/card-service/v1/statement/latest-transaction';
  static const exportCardStatement = '/card-service/v1/card/statement/export';

  static const getCardDetails =
      'http://34.18.92.50:8443/card/op/credit/cards/list';
  static const getCardLoyalty = 'http://34.18.92.50:8443/card/op/loyalty';

  static const getAccountList =
      'http://34.18.92.50:8443/digi-bank/dashboard/account/customer/op';

  static const otpURL =
      'http://34.18.92.50:8443/digi-bank/dashboard/validate/otp';
  static const generationURL =
      'http://34.18.92.50:8443/digi-bank/dashboard/generate/otp';
}
