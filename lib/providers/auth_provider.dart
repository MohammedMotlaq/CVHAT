import 'package:cvhat/app_router.dart';
import 'package:cvhat/providers/auth_form_provider.dart';
import 'package:cvhat/providers/ui_provider.dart';
import 'package:cvhat/services/local_storage_service.dart';
import 'package:cvhat/views/auth/register_screen.dart';
import 'package:cvhat/views/home_screen/home_page.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService.authService;
  final LocalStorageService localStorageService =
      LocalStorageService.localStorageService;
  final AuthFormProvider authFormProvider = AuthFormProvider.authFormProvider;
  bool isLoading = false;
  late String error;
  late String message;
  late var user;

  Future login() async {
    isLoading = true;
    notifyListeners();

    if (!authFormProvider.validateLoginForm()) {
      String emailError = authFormProvider.emailError;
      String passError = authFormProvider.passwordError;
      if (emailError.isNotEmpty) {
        AppRouter.toastificationSnackBar(
            "Error", emailError, ToastificationType.error);
      }
      if (passError.isNotEmpty) {
        AppRouter.toastificationSnackBar(
            "Error", passError, ToastificationType.error);
      }
      isLoading = false;
      notifyListeners();
      return;
    }

    try {
      String email = authFormProvider.emailController.text;
      String password = authFormProvider.passwordController.text;
      final responseData = await _authService.login(email, password);

      final userData = responseData["data"];
      user = User.fromJson(userData);

      message = responseData["message"].isNotEmpty == true
          ? responseData["message"][0]
          : "Login successful";
      await localStorageService.saveUserData(
        token: user.token,
        firstName: user.firstName,
        lastName: user.lastName,
        email: user.email,
      );
      AppRouter.pushWithReplacement(const HomePage());
      AppRouter.toastificationSnackBar(
          "Success", message, ToastificationType.success);
      authFormProvider.clearControllers();
    } catch (e) {
      error = e.toString().split(":")[1]; // Clean exception message
      AppRouter.toastificationSnackBar(
          "Error", error, ToastificationType.error);
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> loadUser() async {
    final userData = await localStorageService.loadUserData();
    print(userData);
    if (userData['auth_token'] != null) {
      user = User(
        token: userData['auth_token']!,
        firstName: userData['first_name']!,
        lastName: userData['last_name']!,
        email: userData['email']!,
      );
    } else {
      user = null;
    }
    notifyListeners();
  }

  Future<void> logout() async {
    isLoading = true;
    notifyListeners();

    String? userToken = await localStorageService.getUserToken();
    bool res = await _authService.logout(userToken!);
    if (res) {
      AppRouter.pushAndRemoveUntil(const RegisterScreen());
      user = null;
      notifyListeners();
      
      await localStorageService.clearUserData();
    }
    isLoading = false;
    notifyListeners();
  }

  Future<bool> signUp() async {
    if (!authFormProvider.validateSignUpForm()) {
      if (authFormProvider.firstNameError.isNotEmpty) {
        AppRouter.toastificationSnackBar(
            "Error", authFormProvider.firstNameError, ToastificationType.error);
      }
      if (authFormProvider.lastNameError.isNotEmpty) {
        AppRouter.toastificationSnackBar(
            "Error", authFormProvider.lastNameError, ToastificationType.error);
      }
      if (authFormProvider.emailError.isNotEmpty) {
        AppRouter.toastificationSnackBar(
            "Error", authFormProvider.emailError, ToastificationType.error);
      }
      if (authFormProvider.passwordError.isNotEmpty) {
        AppRouter.toastificationSnackBar(
            "Error", authFormProvider.passwordError, ToastificationType.error);
      }
      if (authFormProvider.confirmPasswordError.isNotEmpty) {
        AppRouter.toastificationSnackBar("Error",
            authFormProvider.confirmPasswordError, ToastificationType.error);
      }
      return false;
    }

    try {
      isLoading = true;
      notifyListeners();
      String firstName = authFormProvider.firstNameController.text;
      String lastName = authFormProvider.lastNameController.text;
      String email = authFormProvider.emailController.text;
      String password = authFormProvider.passwordController.text;
      final responseMessage = await _authService.signUp(
        firstName,
        lastName,
        email,
        password,
      );

      message = responseMessage.isNotEmpty == true
          ? responseMessage
          : "Sign-up successful";

      AppRouter.toastificationSnackBar(
          "Success", message, ToastificationType.success);
      isLoading = false;
      notifyListeners();
      authFormProvider.clearControllers();
      return true;
    } catch (e) {
      error = e.toString();
      isLoading = false;
      notifyListeners();
      AppRouter.toastificationSnackBar(
          "Error", error, ToastificationType.error);
    }
    return false;
  }
}
