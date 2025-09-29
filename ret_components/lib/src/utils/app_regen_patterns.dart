class AppRegexPatterns {
  static final RegExp emailRegex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
  static final RegExp emailMultiRegex =
      RegExp(r'^[\w-.+]+@([\w-]+\.)+[\w-]{2,4}$');
  static final RegExp mobileRegex = RegExp(r'^\d{10}$');
}
