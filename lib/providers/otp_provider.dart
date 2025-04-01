import 'package:cvhat/app_router.dart';
import 'package:cvhat/services/otp_service.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class OTPProvider extends ChangeNotifier {
  final OTPService _otpService = OTPService.otpService;

  bool _isLoading = false;
  String? _errorMessage;
  bool _nextStep = false;
  String? _token;

  bool get isLoading => _isLoading;

  bool get nextStep => _nextStep;

  String? get errorMessage => _errorMessage;

  TextEditingController email = TextEditingController();

  TextEditingController otp1 = TextEditingController();
  TextEditingController otp2 = TextEditingController();
  TextEditingController otp3 = TextEditingController();
  TextEditingController otp4 = TextEditingController();

  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmNewPassword = TextEditingController();

  String getOtpCode() {
    return otp1.text.trim() +
        otp2.text.trim() +
        otp3.text.trim() +
        otp4.text.trim();
  }

  Future<void> sendOtp() async {
    _isLoading = true;
    _nextStep = false;
    _errorMessage = null;
    notifyListeners();

    try {
      String trimmedEmail = email.text.trim();

      if (trimmedEmail.isEmpty) {
        AppRouter.toastificationSnackBar(
            "Error", "Please enter your email", ToastificationType.error);
        return;
      }

      final emailRegex =
          RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
      if (!emailRegex.hasMatch(trimmedEmail)) {
        AppRouter.toastificationSnackBar(
            "Error", "Invalid email format", ToastificationType.error);
        return;
      }

      final response = await _otpService.sendOtp(trimmedEmail);

      if (response.statusCode != 200) {
        _nextStep = false;
        AppRouter.toastificationSnackBar(
            "Error", response.data["message"], ToastificationType.error);
        clearControllers();
      } else {
        _nextStep = true;
        AppRouter.toastificationSnackBar(
            "Success", "OTP sent successfully!", ToastificationType.success);
      }
    } catch (e) {
      _nextStep = false;
      _errorMessage = e.toString();
      AppRouter.toastificationSnackBar("Error",
          "There is no Account with this Email.", ToastificationType.error);
      clearControllers();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> verifyOtp() async {
    _isLoading = true;
    _nextStep = false;
    _errorMessage = null;
    notifyListeners();

    try {
      if (!isValidOtp(getOtpCode())) {
        AppRouter.toastificationSnackBar(
            "Error", "OTP must be 4 digits", ToastificationType.error);
        return;
      }

      final response =
          await _otpService.verifyOtp(email.text.trim(), getOtpCode());

      if (response.statusCode == 200 && response.data["status"] == "success") {
        _token = response.data["data"]["token"];
        _nextStep = true;
        AppRouter.toastificationSnackBar(
            "Success", "OTP Verified!", ToastificationType.success);
      } else {
        _nextStep = false;
        _errorMessage = response.data["message"];
        AppRouter.toastificationSnackBar(
            "Error", _errorMessage!, ToastificationType.error);
      }
    } catch (e) {
      _nextStep = false;
      _errorMessage = e.toString();
      AppRouter.toastificationSnackBar(
          "Error", _errorMessage!, ToastificationType.error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> resetPassword() async {
    _nextStep = false;

    if (_token == null) {
      AppRouter.toastificationSnackBar("Error",
          "OTP verification is required first", ToastificationType.error);
      return;
    }

    if (newPassword.text.length < 8 || newPassword.text.isEmpty) {
      _errorMessage = "Password must be at least 8 characters long!";
      AppRouter.toastificationSnackBar(
          "Error", _errorMessage!, ToastificationType.error);
      notifyListeners();
      return;
    }

    if (newPassword.text.trim() != confirmNewPassword.text.trim()) {
      _errorMessage = "New password and confirm password do not match!";
      AppRouter.toastificationSnackBar(
          "Error", _errorMessage!, ToastificationType.error);
      notifyListeners();
      return;
    }

    _isLoading = true;
    _errorMessage = null;

    notifyListeners();
    try {
      final response =
          await _otpService.resetPassword(_token!, newPassword.text.trim());
      if (response.statusCode == 200 && response.data["status"] == "success") {
        _nextStep = true;
        AppRouter.toastificationSnackBar("Success",
            "Password reset successfully!", ToastificationType.success);
      } else {
        _nextStep = false;
        _errorMessage = response.data["message"];
        AppRouter.toastificationSnackBar(
            "Error", _errorMessage!, ToastificationType.error);
      }
    } catch (e) {
      _nextStep = false;
      _errorMessage = e.toString();
      AppRouter.toastificationSnackBar(
          "Error", _errorMessage!, ToastificationType.error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearControllers() {
    email.clear();
    otp1.clear();
    otp2.clear();
    otp3.clear();
    otp4.clear();
    newPassword.clear();
    confirmNewPassword.clear();
    notifyListeners();
  }

  bool isValidOtp(String otp) {
    final otpRegex = RegExp(r'^\d{4}$');
    return otpRegex.hasMatch(otp);
  }
}
