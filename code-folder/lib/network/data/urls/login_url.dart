class LoginUrl {
  LoginUrl._();

  static const rpUrl = '/auth/v1/public/rp1'; // new
  //static const rpUrl = '/auth-service/auth/v1/public/rp'; old
  static const authUrl = '/auth/v1/login'; //new
  static const authUrl2 =
      'http://34.18.65.88:8087/rb-user-management/api/users/login'; //new

  //static const authUrl = '/auth-service/auth/v1/login'; old
  static const validateOtpUrl = '/common-service/common/validateOtp';
  static const resendOtpUrl = '/common-service/common/generateOtp';
  static const changePwdUrl = '/auth-service/auth/v1/user/change-password';
  static const logoutUrl = '/auth/logout';
  static const menuUrl = '/common-service/common/termsandcondition';
  static const cardValidations = 'http://34.18.65.88:8087/bin-details';
  static const usernameValidations = 'http://34.1.46.108:7575/users/rules';
  static const String signwithCredentials2 =
      "http://34.1.33.119:9097/rb-user-management/api/users/login";
}
