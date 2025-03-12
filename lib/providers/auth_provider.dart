import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cvhat/app_router.dart';
import 'package:cvhat/providers/auth_form_provider.dart';
import 'package:cvhat/services/local_storage_service.dart';
import 'package:flutter/material.dart';
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
  late User user;

  Future login() async {
    String email = authFormProvider.emailController.text;
    String password = authFormProvider.passwordController.text;
    if (!authFormProvider.validateLoginForm()) {
      if (authFormProvider.emailError!.isEmpty) {
        error = authFormProvider.passwordError!;
      }
      error = authFormProvider.emailError!;
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
    if (userData['auth_token'] != null) {
      user = User(
        token: userData['auth_token']!,
        firstName: userData['first_name']!,
        lastName: userData['last_name']!,
        email: userData['email']!,
      );
    }
    notifyListeners();
  }

  Future<void> logout() async {
    await localStorageService.clearUserData();
    notifyListeners();
  }
}
