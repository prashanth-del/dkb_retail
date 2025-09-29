class ApprovalUrl {
  ApprovalUrl._();

  static const _basePath = "/transfer-service/v1/transfers";

  static const getTransactionEndpoint = '$_basePath/transferList';
  static const getCompletedTransactionEndpoint = '$_basePath/completedList';
  static const getTransactionDetailsEndpoint = "$_basePath/detail";

  static const sendPreprocessReqEndPoint = "$_basePath/preprocess";

  static const resendTransactionOTP = "$_basePath/resend";

  static const checkActionConfirmation = "$_basePath/confirm";

  static const getTransactionViewMoreDetails = "$_basePath/details/viewMore";
  static const exportSIF = "$_basePath/fileDownload";
}
