abstract class I18nSource {
  String text(String key, {required String fallback});
  String validation(String key, {required String fallback});
}
