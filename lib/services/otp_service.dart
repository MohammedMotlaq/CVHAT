import 'package:cvhat/constants/api_endpoints.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class OTPService {
  OTPService._();

  static OTPService otpService = OTPService._();
  final Dio _dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 20),
    receiveTimeout: const Duration(seconds: 20),
  ));

  Future<Response> sendOtp(String email) async {
    try {
      Response response = await _dio.post(
        ApiEndPoints.sendOtp,
        data: {"email": email},
      );
      if (kDebugMode) {
        print("-------------------${response.data}");
      }
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print("OTP sent successfully");
          print(response.data["message"]);
        }
        return response;
      } else {
        throw Exception("Failed to send OTP");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
      throw Exception("Error sending OTP: $e");
    }
  }

  Future<Response> verifyOtp(String email, String otpCode) async {
    try {
      Response response = await _dio.post(
        ApiEndPoints.verifyOtp,
        data: {"email": email, "otp": otpCode},
      );
      if (kDebugMode) {
        print("-------------------${response.data}");
      }
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print("OTP verified successfully");
          print(response.data["message"]);
        }
        return response;
      } else {
        throw Exception("Invalid OTP code");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
      throw Exception("Invalid OTP code");
    }
  }

  Future<Response> resetPassword(String token, String newPassword) async {
    try {
      Response response = await _dio.post(
        ApiEndPoints.resetPassword,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
        data: {
          "newPassword": newPassword,
        },
      );

      if (kDebugMode) {
        print("-------------------${response.data}");
      }

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print("Password reset successfully");
          print(response.data["message"]);
        }
        return response;
      } else {
        throw Exception("Failed to reset password");
      }
    } catch (e) {
      throw Exception("Error resetting password: $e");
    }
  }
}
