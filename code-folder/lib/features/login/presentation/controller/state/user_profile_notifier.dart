import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/user_profile.dart';

// State for UserProfileNotifier
class UserProfileNotifier extends StateNotifier<UserProfile?> {
  UserProfileNotifier() : super(null); // Initial state is null

  // Method to update user profile
  void updateUserProfile(UserProfile userProfile) {
    state = userProfile;
  }

  // Optional: method to clear profile data
  void clearProfile() {
    state = null;
  }
}

// Create a provider for UserProfileNotifier
final userProfileProvider =
    StateNotifierProvider<UserProfileNotifier, UserProfile?>((ref) {
  return UserProfileNotifier();
});
