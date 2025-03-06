import 'package:flutter/material.dart';

enum AuthState { login, signup, forgetPassword, otp, confirmPassword }

class UiProvider extends ChangeNotifier {
  AuthState _authState = AuthState.login;

  AuthState get authState => _authState;

  void setAuthState(AuthState state) {
    _authState = state;
    notifyListeners();
  }
}
