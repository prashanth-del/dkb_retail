extension TextNewlineExtension on String {
  String insertNewline(String separator) {
    return this.replaceAll(separator, '\n');
  }
}