import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  LocalStorageService._();

  static LocalStorageService localStorageService = LocalStorageService._();
  static SharedPreferences? _sharedPreferencesInstance;

  initS() async {
    _sharedPreferencesInstance = await SharedPreferences.getInstance();
  }

  Future<void> saveUserData({
    required String token,
    required String firstName,
    required String lastName,
    required String email,
  }) async {
    await _sharedPreferencesInstance!.setString('auth_token', token);
    await _sharedPreferencesInstance!.setString('first_name', firstName);
    await _sharedPreferencesInstance!.setString('last_name', lastName);
    await _sharedPreferencesInstance!.setString('email', email);
  }

  Future<Map<String, String?>> loadUserData() async {
    return {
      'auth_token': _sharedPreferencesInstance!.getString('auth_token'),
      'first_name': _sharedPreferencesInstance!.getString('first_name'),
      'last_name': _sharedPreferencesInstance!.getString('last_name'),
      'email': _sharedPreferencesInstance!.getString('email'),
    };
  }

  Future<String?> getUserToken() async {
    return _sharedPreferencesInstance!.getString("auth_token");
  }

  Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
