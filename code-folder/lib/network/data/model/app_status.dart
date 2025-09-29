enum AppStatus {
  success,           // 000000
  otpAlreadySent,    // e.g., 000002
  otpThrottle,       // e.g., 000006
  error,             // anything else
}