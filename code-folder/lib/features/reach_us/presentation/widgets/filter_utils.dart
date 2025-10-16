import 'package:dkb_retail/features/reach_us/data/models/branch_atm_kiosk_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controller/state/reach_notifier.dart';

class FilterUtils {
  static List<Map<String, dynamic>> buildFiltered({
    //required LocationType type,
    required List<LocationItem> branches,
    required List<LocationItem> atms,
    required List<LocationItem> kiosks,
    required ReachUsNotifier notifier,
    required LatLng? currentLocation,
    required int selectedBranchIndex,
    required int selectedAtmIndex,
    required int selectedKioskIndex,
    required WidgetRef ref,
  }) {
    // ✨ You can move your entire filtering logic (_loadMarkers big switch)
    // here. I left it summarized for brevity.
    //
    // Return a List<Map<String, dynamic>> with unified structure:
    // { "id": ..., "type": "Branch"/"ATM"/"Kiosk", "lat": ..., "long": ..., "name": ..., "address": ..., "country": ..., "raw": ... }

    List<Map<String, dynamic>> result = [];

    // if (type == LocationType.all) {
    //   result = [
    //     ...branches.map((b) => _mapBranch(b)),
    //     ...atms.map((a) => _mapAtm(a)),
    //     ...kiosks.map((k) => _mapKiosk(k)),
    //   ];
    // }
    // Add your "Nearest" and filtering logic like in your original _loadMarkers
    return result.where((m) => m["lat"] != null && m["long"] != null).toList();
  }

  static Map<String, dynamic> _mapBranch(LocationItem b) => {
    "type": "Branch",
    // "id": b.id,
    //"name": b.bankBranchName ?? "",
    "lat": b.coordinates?.latitude,
    "long": b.coordinates?.longitude,
    "raw": b,
    // "country": b.countryName,
    "address": b.address,
  };

  static Map<String, dynamic> _mapAtm(LocationItem a) => {
    "type": "ATM",
    // "id": a.id,
    // "name": a.fullAddress ?? "",
    // "lat": double.tryParse(a.latitude!),
    // "long": double.tryParse(a.longitude!),
    "raw": a,
    "country": a.country,
    "address": a.fullAddress,
  };

  static Map<String, dynamic> _mapKiosk(LocationItem k) => {
    "type": "Kiosk",
    //  "id": k.kioskId,
    // "name": k.name ?? "",
    "lat": k.coordinates?.latitude,
    "long": k.coordinates?.longitude,
    "raw": k,
    // "country": k.location!.country,
    // "address": k.location!.townName,
  };
}
