import 'package:flutter/material.dart';

class UiProvider extends ChangeNotifier {
  bool haveAccount = true;
  bool resetPassword = false;

  void resetPasswordChange() {
    resetPassword = !resetPassword;
    notifyListeners();
  }

  void haveAccountChange() {
    haveAccount = !haveAccount;
    notifyListeners();
  }
}
