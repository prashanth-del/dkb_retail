
class LoginUrl {
  LoginUrl._();

  static const rpUrl = '/auth/v1/public/rp1'; // new
  //static const rpUrl = '/auth-service/auth/v1/public/rp'; old
  static const authUrl = '/auth/v1/login'; //new
  //static const authUrl = '/auth-service/auth/v1/login'; old
  static const validateOtpUrl = '/common-service/common/validateOtp';
  static const resendOtpUrl = '/common-service/common/generateOtp';
  static const changePwdUrl = '/auth-service/auth/v1/user/change-password';
  static const logoutUrl = '/auth/logout';
  static const menuUrl = '/common-service/common/termsandcondition';
}