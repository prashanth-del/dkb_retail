import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

class UiFileHandler {
  // Constructor to create instance if needed
  UiFileHandler();

  // Method to open a file using base64 string, auto-detects file format if not provided
  Future<void> openFile({
    required String base64String,
    String? fileFormat,
  }) async {
    try {
      // Check file system permissions
      bool permissionGranted = await getStoragePermission();
      if (!permissionGranted) {
        UiToast().showToast(
            'Permission denied! Allow storage permission in settings.');
        return;
      }

      var bytes = base64Decode(base64String);

      // Get file extension if not provided
      fileFormat ??= _getFileExtension(base64String);

      final file = await _downloadFile(bytes, fileFormat);

      if (file == null) {
        throw Exception('Unable to open file');
      }

      OpenFile.open(file.path);
    } catch (e) {
      debugPrint('Error opening file: $e');
      UiToast().showToast('Unable to download file');
    }
  }

  // Method to download the file and save it locally
  Future<File?> _downloadFile(Uint8List bytes, String fileFormat) async {
    try {
      var uid = const Uuid().v4();
      final appStorage = await getApplicationDocumentsDirectory();
      final file = File('${appStorage.path}/$uid$fileFormat');
      debugPrint('File saved at: ${file.path}');
      await file.writeAsBytes(bytes.buffer.asUint8List());
      return file;
    } catch (e) {
      debugPrint('Error downloading file: $e');
      return null;
    }
  }

  // Private method to get file extension based on base64 string
  String _getFileExtension(String base64String) {
    if (base64String.isEmpty) {
      return '.pdf';
    }

    switch (base64String.characters.first) {
      case "J":
        return '.pdf';
      case "/":
        return '.jpg';
      case "i":
        return '.png';
      case "U":
        return '.webp';
      case "R":
        return '.csv';
      default:
        return '.pdf';
    }
  }

  // Utility method to print large text wrapped in chunks
  void printWrapped(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => debugPrint(match.group(0)));
  }

  // Method to check storage permissions
  Future<bool> getStoragePermission() async {
    if (Platform.isAndroid) {
      DeviceInfoPlugin plugin = DeviceInfoPlugin();
      AndroidDeviceInfo android = await plugin.androidInfo;
      if (android.version.sdkInt < 33) {
        if (await Permission.storage.request().isGranted) {
          return true;
        } else if (await Permission.storage.request().isPermanentlyDenied) {
          await openAppSettings();
          return false;
        } else if (await Permission.storage.request().isDenied) {
          return false;
        } else {
          return false;
        }
      } else {
        if (await Permission.manageExternalStorage.request().isGranted) {
          return true;
        } else if (await Permission.manageExternalStorage
            .request()
            .isPermanentlyDenied) {
          await openAppSettings();
          return false;
        } else if (await Permission.manageExternalStorage.request().isDenied) {
          return false;
        } else {
          return false;
        }
      }
    } else {
      final status = await Permission.storage.request();
      if (status == PermissionStatus.granted) {
        return true;
      } else if (status == PermissionStatus.denied) {
        return false;
      } else if (status == PermissionStatus.permanentlyDenied) {
        return false;
      } else {
        return false;
      }
    }
  }
}
