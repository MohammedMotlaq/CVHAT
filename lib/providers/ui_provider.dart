import 'package:flutter/material.dart';

class UiProvider extends ChangeNotifier {
  bool haveAccount = true;

  void haveAccountChange() {
    haveAccount = !haveAccount;
    notifyListeners();
  }
}
