class AccountUrl {
  AccountUrl._();

  static const getAccountStatementEndpoint =
      '/v1/acc/transaction/op';
  static const accountStatementExportEndpoint =
      '/account-service/v1/statement/export';
  static const getAccountSummaryEndpoint = '/v1/acc/customer/op';
  static const getTransactionAccountDetailsEndpoint =
      '/account-service/v1/acc/details';
}
