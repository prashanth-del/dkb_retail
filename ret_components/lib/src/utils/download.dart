import 'dart:io';

import 'package:path_provider/path_provider.dart';

enum FileType {
  pdf('.pdf'),
  csv('.csv'),
  excel('.xlsx');

  final String extension;
  const FileType(this.extension);
}

Future<bool> download({
  required List<int> bytes,
  required FileType fileType,
  String? filename,
}) async {
  Directory? directory;

  if (Platform.isAndroid) {
    directory = Directory('/storage/emulated/0/Download');

    if (!await directory.exists()) {
      directory = await getExternalStorageDirectory();
    }
  }

  if (Platform.isIOS) {
    directory = await getApplicationDocumentsDirectory();
  }

  String? dir = directory?.path;
  if (dir == null) {
    return false;
  }

  File file = File(
    "$dir/${filename ?? DateTime.now().millisecondsSinceEpoch}${fileType.extension}",
  );

  try {
    await file.writeAsBytes(bytes);
    return true;
  } catch (e) {
    return false;
  }
}
