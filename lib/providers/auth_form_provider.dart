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

  String? _firstNameError;
  String? _lastNameError;
  String? _emailError;

  String? _passwordError;

  String? _confirmPasswordError;

  String? get firstNameError => _firstNameError;

  String? get lastNameError => _lastNameError;

  String? get emailError => _emailError;

  String? get passwordError => _passwordError;

  String? get confirmPasswordError => _confirmPasswordError;

  void validateFirstName() {
    _firstNameError =
        firstNameController.text.isEmpty ? 'First name is required' : null;
    notifyListeners();
  }

  void validateLastName() {
    _lastNameError =
        lastNameController.text.isEmpty ? 'Last name is required' : null;
    notifyListeners();
  }

  void validateEmail() {
    String email = emailController.text;
    _emailError = email.isEmpty
        ? 'Email is required'
        : (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)
            ? 'Enter a valid email'
            : null);
    notifyListeners();
  }

  void validatePassword() {
    _passwordError = passwordController.text.length < 6
        ? 'Password must be at least 6 characters'
        : null;
    notifyListeners();
  }

  void validateConfirmPassword() {
    String confirmPassword = confirmPasswordController.text;
    if (confirmPassword.isEmpty) {
      _confirmPasswordError = 'Confirm Password is required';
    } else if (confirmPassword != passwordController.text) {
      _confirmPasswordError = 'Passwords do not match';
    } else {
      _confirmPasswordError = null;
    }
    notifyListeners();
  }

  bool validateLoginForm() {
    validateEmail();
    validatePassword();
    return _emailError == null && _passwordError == null;
  }

  bool validateSignUpForm() {
    validateFirstName();
    validateLastName();
    validateEmail();
    validatePassword();
    validateConfirmPassword();

    return _firstNameError == null &&
        _lastNameError == null &&
        _emailError == null &&
        _passwordError == null &&
        _confirmPasswordError == null;
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
