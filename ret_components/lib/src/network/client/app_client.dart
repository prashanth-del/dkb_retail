export 'src/app_client_stub.dart'
    if (dart.library.html) 'src/app_browser_client.dart'
    if (dart.library.io) 'src/app_io_client.dart';
