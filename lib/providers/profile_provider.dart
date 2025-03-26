import 'package:cvhat/app_router.dart';
import 'package:cvhat/models/profile_model.dart';
import 'package:cvhat/services/local_storage_service.dart';
import 'package:cvhat/services/profile_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:toastification/toastification.dart';

class ProfileProvider extends ChangeNotifier {
  final ProfileService _profileService = ProfileService.profileService;
  Profile? _profile;

  Profile? get profile => _profile;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  final LocalStorageService localStorageService =
      LocalStorageService.localStorageService;

  Future<void> fetchProfile() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      String? userToken = await localStorageService.getUserToken();
      _profile = await _profileService.getUserProfile(userToken!);
    } catch (e) {
      _errorMessage = e.toString();
      print(_errorMessage);
      AppRouter.toastificationSnackBar(
          "Error", _errorMessage!, ToastificationType.error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
