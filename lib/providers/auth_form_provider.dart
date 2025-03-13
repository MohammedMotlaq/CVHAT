import 'package:flutter/material.dart';

class AuthFormProvider extends ChangeNotifier {
  AuthFormProvider._();

  static AuthFormProvider authFormProvider = AuthFormProvider._();
  bool isPasswordObscure = true;
  bool isConfirmPasswordObscure = true;
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  String firstNameError = "";
  String lastNameError = "";
  String emailError = "";
  String passwordError = "";
  String confirmPasswordError = "";

  void validateFirstName() {
    firstNameError =
        firstNameController.text.isEmpty ? 'First name is required' : "";
    notifyListeners();
  }

  void validateLastName() {
    lastNameError =
        lastNameController.text.isEmpty ? 'Last name is required' : "";
    notifyListeners();
  }

  void validateEmail() {
    String email = emailController.text;
    emailError = email.isEmpty
        ? 'Email is required'
        : (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)
            ? 'Enter a valid email'
            : "");
    notifyListeners();
  }

  void validatePassword() {
    if (passwordController.text.isEmpty) {
      passwordError = "Password is required";
    } else if (passwordController.text.length < 8) {
      passwordError = "Password must be at least 8 characters";
    } else {
      passwordError = "";
    }
    notifyListeners();
  }

  void validateConfirmPassword() {
    String confirmPassword = confirmPasswordController.text;
    if (confirmPassword.isEmpty) {
      confirmPasswordError = 'Confirm Password is required';
    } else if (confirmPassword != passwordController.text) {
      confirmPasswordError = 'Passwords do not match';
    } else {
      confirmPasswordError = "";
    }
    notifyListeners();
  }

  bool validateLoginForm() {
    validateEmail();
    validatePassword();
    return emailError.isEmpty && passwordError.isEmpty;
  }

  bool validateSignUpForm() {
    validateFirstName();
    validateLastName();
    validateEmail();
    validatePassword();
    validateConfirmPassword();

    return firstNameError.isEmpty &&
        lastNameError.isEmpty &&
        emailError.isEmpty &&
        passwordError.isEmpty &&
        confirmPasswordError.isEmpty;
  }

  void clearControllers() {
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    notifyListeners();
  }

  void togglePasswordVisibility() {
    isPasswordObscure = !isPasswordObscure;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordObscure = !isConfirmPasswordObscure;
    notifyListeners();
  }
}
