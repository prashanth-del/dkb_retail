import 'dart:math';

import 'package:dkb_retail/features/reach_us/domain/entities/bank_info.dart';
import 'package:dkb_retail/features/reach_us/domain/entities/locate_us_info.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../core/constants/app_strings/default_string.dart';
import '../../../domain/entities/locate_us_info_branche.dart';

class ReachUsState {
  final List<LocateUsInfoBranche> branches;
  final List<LocateUsInfoBranche> atms;
  final List<LocateUsInfoBranche> kiosks;
  final LocateUsInfoBranche? nearestBranch;
  final Set<Marker> markers;
  final LatLng? currentLocation; // <-- Add current location
  final BankInfo? bankDetails;
  final List<LocateUsInfo>? locateUsEntity;
  final String? errorFromServer;
  final String? failedLocateUsService;
  ReachUsState({
    this.branches = const [],
    this.atms = const [],
    this.kiosks = const [],
    this.nearestBranch,
    this.markers = const {},
    this.currentLocation,
    this.bankDetails,
    this.locateUsEntity,
    this.errorFromServer,
    this.failedLocateUsService,
  });

  ReachUsState copyWith({
    List<LocateUsInfoBranche>? branches,
    List<LocateUsInfoBranche>? atms,
    List<LocateUsInfoBranche>? kiosks,
    LocateUsInfoBranche? nearestBranch,
    Set<Marker>? markers,
    LatLng? currentLocation,
    BankInfo? bankDetails,
    List<LocateUsInfo>? locateUsEntity,
    String? errorFromServer,
    String? failedLocateUsService,
  }) {
    return ReachUsState(
      branches: branches ?? this.branches,
      atms: atms ?? this.atms,
      kiosks: kiosks ?? this.kiosks,
      nearestBranch: nearestBranch ?? this.nearestBranch,
      markers: markers ?? this.markers,
      currentLocation: currentLocation ?? this.currentLocation,
      bankDetails: bankDetails ?? this.bankDetails,
      locateUsEntity: locateUsEntity ?? this.locateUsEntity,
      errorFromServer: errorFromServer ?? this.errorFromServer,
      failedLocateUsService:
          failedLocateUsService ?? this.failedLocateUsService,
    );
  }
}

class ReachUsNotifier extends StateNotifier<ReachUsState> {
  ReachUsNotifier() : super(ReachUsState());

  void setMarkers(Set<Marker> newMarkers) {
    state = state.copyWith(markers: newMarkers);
  }

  List<String> tabsList = [];

  void updateTabs() {
    tabsList = [DefaultString.instance.all]; // Always include "All"

    if (state.branches.isNotEmpty) {
      tabsList.add(DefaultString.instance.branchFilter);
    }
    if (state.atms.isNotEmpty) {
      tabsList.add(DefaultString.instance.atmFilter);
    }
    if (state.kiosks.isNotEmpty) {
      tabsList.add(DefaultString.instance.kiosk);
    }
  }

  void setErrorFromServer(String error) {
    state = state.copyWith(errorFromServer: error);
  }

  void failedLocateUsService(String error) {
    state = state.copyWith(failedLocateUsService: error);
  }

  void setBranches(List<LocateUsInfoBranche> branches) {
    state = state.copyWith(branches: branches);
    updateTabs(); // Update tabs whenever branches change
  }

  void setAtms(List<LocateUsInfoBranche> atms) {
    state = state.copyWith(atms: atms);
    updateTabs(); // Update tabs whenever ATMs change
  }

  void setKiosks(List<LocateUsInfoBranche> kiosks) {
    state = state.copyWith(kiosks: kiosks);
    updateTabs(); // Update tabs whenever kiosks change
  }

  void fetchBankDetailsFromServer(BankInfo bankDetails) {
    state = state.copyWith(bankDetails: bankDetails);
  }

  void fetchLocateUsFromServer(List<LocateUsInfo> locateUsEntity) {
    state = state.copyWith(locateUsEntity: locateUsEntity);
  }

  void setNearestBranch(LocateUsInfoBranche branch) {
    state = state.copyWith(nearestBranch: branch);
  }

  void setCurrentLocation(LatLng location) {
    state = state.copyWith(currentLocation: location);
  }

  double calculateDistance(double lat1, double lng1, double lat2, double lng2) {
    const double earthRadius = 6371000; // meters
    final double dLat = (lat2 - lat1) * (pi / 180);
    final double dLng = (lng2 - lng1) * (pi / 180);
    final double a =
        sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1 * (pi / 180)) *
            cos(lat2 * (pi / 180)) *
            sin(dLng / 2) *
            sin(dLng / 2);
    final double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadius * c;
  }

  LocateUsInfoBranche? findNearestBranch(double lat, double lng) {
    if (state.branches.isEmpty) return null;

    LocateUsInfoBranche? nearest;
    double minDistance = double.infinity;

    for (final branch in state.branches) {
      if (branch.coordinates != null) {
        final distance = calculateDistance(
          lat,
          lng,
          branch.coordinates!.latitude!,
          branch.coordinates!.longitude!,
        );
        if (distance < minDistance) {
          minDistance = distance;
          nearest = branch;
        }
      }
    }
    return nearest;
  }

  LocateUsInfoBranche? findNearestAtm(double lat, double lng) {
    if (state.atms.isEmpty) return null;

    LocateUsInfoBranche? nearest;
    double minDistance = double.infinity;
    for (final atm in state.atms) {
      // Safely get latitude and longitude with default values
      final latStr = atm.coordinates!.latitude ?? 51.5333;
      final lngStr = atm.coordinates!.longitude ?? 25.3245;

      // Check if they are not empty after fallback
      if (latStr != null && lngStr != null) {
        final atmLat = latStr;
        final atmLng = lngStr;

        final distance = calculateDistance(lat, lng, atmLat, atmLng);

        if (distance < minDistance) {
          minDistance = distance;
          nearest = atm;
        }
      }
    }

    // for (final atm in state.atms) {
    //   if (atm.latitude!.isNotEmpty && atm.longitude!.isNotEmpty) {
    //     final distance = calculateDistance(
    //       lat,
    //       lng,
    //       double.tryParse(atm.latitude!) ?? 0,
    //       double.tryParse(atm.longitude!) ?? 0,
    //     );
    //     if (distance < minDistance) {
    //       minDistance = distance;
    //       nearest = atm;
    //     }
    //   }
    // }
    return nearest;
  }

  LocateUsInfoBranche? findNearestKiosk(double lat, double lng) {
    if (state.kiosks.isEmpty) return null;

    LocateUsInfoBranche? nearest;
    double minDistance = double.infinity;

    for (final kiosk in state.kiosks) {
      if (kiosk.coordinates != null) {
        final distance = calculateDistance(
          lat,
          lng,
          kiosk!.coordinates!.latitude!,
          kiosk.coordinates!.longitude!,
        );
        if (distance < minDistance) {
          minDistance = distance;
          nearest = kiosk;
        }
      }
    }
    return nearest;
  }
}
