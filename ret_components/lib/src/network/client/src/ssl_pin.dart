part of 'app_io_client.dart';

Future<SecurityContext> _globalContext(List<String> certificatePaths) async {
  SecurityContext securityContext = SecurityContext(withTrustedRoots: false);

  for (var path in certificatePaths) {
    final sslCert = await rootBundle.load(path);
    securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());
  }

  return securityContext;
}
