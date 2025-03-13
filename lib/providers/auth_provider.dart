import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cvhat/app_router.dart';
import 'package:cvhat/providers/auth_form_provider.dart';
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
    String email = authFormProvider.emailController.text;
    String password = authFormProvider.passwordController.text;
    if (!authFormProvider.validateLoginForm()) {
      List<String> errors = [];
      if (authFormProvider.emailError != null) {
        errors.add(authFormProvider.emailError!);
      }
      if (authFormProvider.passwordError != null) {
        errors.add(authFormProvider.passwordError!);
      }
      error = error = errors.join("\n");
      AppRouter.awesomeSnackBar("Error", error, ContentType.failure);
      return;
    }

    try {
      final responseData = await _authService.login(email, password);

      // Extract user data from response
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
      AppRouter.awesomeSnackBar("Success", message, ContentType.success);
    } catch (e) {
      error = e.toString(); // Clean exception message
      AppRouter.awesomeSnackBar("Error", error, ContentType.failure);
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
    await localStorageService.clearUserData();
    AppRouter.pushAndRemoveUntil(RegisterScreen());
    notifyListeners();
  }

  Future signUp() async {
    isLoading = true;
    notifyListeners();
    String firstName = authFormProvider.firstNameController.text;
    String lastName = authFormProvider.lastNameController.text;
    String email = authFormProvider.emailController.text;
    String password = authFormProvider.passwordController.text;
    String confirmPassword = authFormProvider.confirmPasswordController.text;

    if (!authFormProvider.validateSignUpForm()) {
      if (authFormProvider.firstNameError != null) {
        AppRouter.toastificationSnackBar("Error",
            authFormProvider.firstNameError!, ToastificationType.error);
      }
      if (authFormProvider.lastNameError != null) {
        AppRouter.toastificationSnackBar(
            "Error", authFormProvider.lastNameError!, ToastificationType.error);
      }
      if (authFormProvider.emailError != null) {
        AppRouter.toastificationSnackBar(
            "Error", authFormProvider.emailError!, ToastificationType.error);
      }
      if (authFormProvider.passwordError != null) {
        AppRouter.toastificationSnackBar(
            "Error", authFormProvider.passwordError!, ToastificationType.error);
      }
      if (authFormProvider.confirmPasswordError != null) {
        AppRouter.toastificationSnackBar("Error",
            authFormProvider.confirmPasswordError!, ToastificationType.error);
      }

      return;
    }
    try {
      final responseMessage = await _authService.signUp(
        firstName,
        lastName,
        email,
        password,
      );

      message = responseMessage["message"].isNotEmpty == true
          ? responseMessage["message"][0]
          : "Sign-up successful";

      AppRouter.toastificationSnackBar(
          "Success", message, ToastificationType.success);
      AppRouter.pushWithReplacement(const HomePage());
    } catch (e) {
      error = e.toString();
      AppRouter.toastificationSnackBar(
          "Error", error, ToastificationType.error);
    }

    isLoading = false;
    notifyListeners();
  }
}
