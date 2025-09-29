extension StringExtensions on String? {
  String orEmpty() {
    return this ?? '';
  }

  String orElse([String value = ""]) {
    return this ?? value;
  }
}