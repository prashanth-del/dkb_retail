import 'api_envelope.dart';

extension ApiEnvelopeX<T> on ApiEnvelope<T> {
  String get code => status.code?.trim() ?? '';
  bool hasCode(String c) => code == c;
  bool hasAny(Iterable<String> codes) => codes.contains(code);
}
