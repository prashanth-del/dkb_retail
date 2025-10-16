import 'dart:ui' as ui;

import 'package:dkb_retail/core/constants/asset_path/asset_path.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerUtils {
  static Future<BitmapDescriptor> getIcon(String type) async {
    switch (type) {
      case "Branch":
        return _resizeMarker(AssetPath.image.pin_branch);
      case "ATM":
        return _resizeMarker(AssetPath.image.pin_atm);
      case "Kiosk":
        return _resizeMarker(AssetPath.image.pin_kiosk);
      default:
        return BitmapDescriptor.defaultMarker;
    }
  }

  static Future<BitmapDescriptor> _resizeMarker(
    String assetPath, {
    int width = 130,
  }) async {
    final data = await rootBundle.load(assetPath);
    final codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetWidth: width,
    );
    final fi = await codec.getNextFrame();
    final resizedData = await fi.image.toByteData(
      format: ui.ImageByteFormat.png,
    );
    return BitmapDescriptor.fromBytes(resizedData!.buffer.asUint8List());
  }
}
