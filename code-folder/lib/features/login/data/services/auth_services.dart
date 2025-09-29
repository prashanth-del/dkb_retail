// lib/services/auth_service.dart

import 'dart:async';

class AuthService {
  AuthService();

  // Validate debit card number and pin
  Future<bool> validateCardDetails({
    required String cardNumber,
    required String pin,
  }) async {
    if (cardNumber.isEmpty || cardNumber.length != 16) {
      throw Exception("Card number must be 16 digits");
    }
    if (pin.isEmpty || pin.length != 4) {
      throw Exception("PIN must be 4 digits");
    }

    // Uncomment when Network class is available
    // final response = await network.post('/validateCard', data: {'cardNumber': cardNumber, 'pin': pin});
    // if (!response.success) throw Exception(response.message);

    // Simulated success for now
    await Future.delayed(const Duration(milliseconds: 500));
    return true;
  }

  // Send OTP to registered number
  Future<String> sendOtp({required String cardNumber}) async {
    if (cardNumber.isEmpty || cardNumber.length != 16) {
      throw Exception("Card number must be 16 digits");
    }

    // Uncomment when Network class is available
    // final response = await network.post('/sendOtp', data: {'phoneNumber': phoneNumber});
    // if (!response.success) throw Exception(response.message);

    // Simulate OTP sending
    await Future.delayed(const Duration(milliseconds: 500));
    return "123456"; // Simulated OTP
  }

  // Validate OTP
  Future<bool> validateOtp({
    required String otp,
    required String sentOtp,
  }) async {
    if (otp.isEmpty || otp.length != 6) {
      throw Exception("OTP must be 6 digits");
    }
    if (otp != sentOtp) {
      throw Exception("Invalid OTP");
    }

    // Uncomment when Network class is available
    // final response = await network.post('/validateOtp', data: {'otp': otp});
    // if (!response.success) throw Exception(response.message);

    await Future.delayed(const Duration(milliseconds: 300));
    return true;
  }

  // Fetch username's from server
  Future<List<String>> fetchUsername({required String userId}) async {
    if (userId.isEmpty) throw Exception("User ID required");

    // Uncomment when Network class is available
    // final response = await network.get('/fetchUsername/$userId');
    // if (!response.success) throw Exception(response.message);

    await Future.delayed(const Duration(milliseconds: 400));
    return ["SarahAhmed"]; // Simulated username
  }

  // check username availability in server
  Future<bool> checkUsernameAvailability({required String newUsername}) async {
    if (newUsername.isEmpty) throw Exception("Username is Empty");

    // Uncomment when Network class is available
    // final response = await network.get('/fetchUsername/$userId');
    // if (!response.success) throw Exception(response.message);

    await Future.delayed(const Duration(milliseconds: 400));
    return true; // Simulated username
  }

  // Update username and password
  Future<bool> updateCredentials({
    required String userId,
    required String password,
  }) async {
    if (userId.isEmpty) throw Exception("User ID required");
    if (password.isEmpty || password.length < 6) {
      throw Exception("Password must be at least 6 characters");
    }

    // Uncomment when Network class is available
    // final response = await network.post('/updateCredentials', data: {'userId': userId, 'username': username, 'password': password});
    // if (!response.success) throw Exception(response.message);

    await Future.delayed(const Duration(milliseconds: 500));
    return true; // Simulate success
  }
}
