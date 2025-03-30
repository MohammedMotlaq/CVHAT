import 'package:cvhat/app_router.dart';
import 'package:cvhat/models/profile_model.dart';
import 'package:cvhat/services/local_storage_service.dart';
import 'package:cvhat/services/profile_service.dart';
import 'package:cvhat/views/auth/register_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:toastification/toastification.dart';

class ProfileProvider extends ChangeNotifier {
  final ProfileService _profileService = ProfileService.profileService;
  Profile? _profile;

  Profile? get profile => _profile;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  PlatformFile? selectedFile;

  bool _isChangePassword = false;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

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
      //print(_errorMessage);
      AppRouter.toastificationSnackBar(
          "Error", _errorMessage!, ToastificationType.error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateProfile() async {
    _isLoading = true;
    notifyListeners();

    try {
      if (selectedFile != null) {
        await _postAvatar();
      }
      if (firstNameController.text.isNotEmpty &&
          lastNameController.text.isNotEmpty) {
        await _updateUserName();
      }

      if (oldPasswordController.text.isNotEmpty &&
          newPasswordController.text.isNotEmpty) {
        _isChangePassword = true;
        notifyListeners();
        await _changePassword();
      }
      if (selectedFile == null &&
          firstNameController.text.isEmpty &&
          lastNameController.text.isEmpty &&
          oldPasswordController.text.isEmpty &&
          newPasswordController.text.isEmpty) {
        AppRouter.toastificationSnackBar(
            "All Set", "Nothing To Be Updated!", ToastificationType.info);
        return;
      }

      clearFile();
      _clearControllers();
      if (!_isChangePassword) {
        fetchProfile();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      } else {
        AppRouter.toastificationSnackBar(
            "Error", "Something Went Wrong!", ToastificationType.error);
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _postAvatar() async {
    _isLoading = true;
    notifyListeners();
    try {
      if (selectedFile == null) {
        AppRouter.toastificationSnackBar(
            "Error", "Please Select Avatar!", ToastificationType.error);
        return;
      }
      if (selectedFile!.extension != "jpg") {
        AppRouter.toastificationSnackBar(
            "Error", "Please select jpg file", ToastificationType.error);
        return;
      }
      if (kDebugMode) {
        print("Uploading Avatar in profile provider");
      }
      String? userToken = await localStorageService.getUserToken();
      await _profileService.postAvatar(userToken!, selectedFile!);
      notifyListeners();
      AppRouter.toastificationSnackBar(
          "Success", "Avatar Updated Successfully", ToastificationType.success);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      } else {
        AppRouter.toastificationSnackBar(
            "Error",
            "Something Went Wrong! Upload Avatar Failed!",
            ToastificationType.error);
      }
    }
  }

  Future<void> _updateUserName() async {
    _isLoading = true;
    notifyListeners();
    try {
      String? userToken = await localStorageService.getUserToken();
      await _profileService.updateUserName(userToken!,
          firstNameController.text.trim(), lastNameController.text.trim());
      notifyListeners();
      AppRouter.toastificationSnackBar(
          "Success", "Name Updated Successfully", ToastificationType.success);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      } else {
        AppRouter.toastificationSnackBar(
            "Error",
            "Something Went Wrong! Update User Name Failed!",
            ToastificationType.error);
      }
    }
  }

  Future<void> _changePassword() async {
    if (newPasswordController.text.trim() !=
        confirmPasswordController.text.trim()) {
      _errorMessage = "New password and confirm password do not match!";
      AppRouter.toastificationSnackBar(
          "Error", _errorMessage!, ToastificationType.error);
      notifyListeners();
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      String? userToken = await localStorageService.getUserToken();
      await _profileService.changePassword(userToken!,
          oldPasswordController.text.trim(), newPasswordController.text.trim());
      AppRouter.toastificationSnackBar(
          "Success",
          "Password changed successfully! Please Login Again.",
          ToastificationType.success);
      await localStorageService.clearUserData();
      AppRouter.pushAndRemoveUntil(const RegisterScreen());
    } catch (e) {
      if (kDebugMode) {
        print(_errorMessage);
      }
      AppRouter.toastificationSnackBar(
          "Error",
          "Something Wont Wrong!\nMake Sure you Provide the Correct Password!",
          ToastificationType.error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> pickFile({List<String>? allowedExtensions}) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: allowedExtensions != null ? FileType.custom : FileType.image,
        allowedExtensions: allowedExtensions,
      );

      if (result != null && result.files.isNotEmpty) {
        selectedFile = result.files.first;
      } else {
        _errorMessage = "No file selected.";
      }
    } catch (e) {
      _errorMessage = "Error picking file: $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearFile() {
    selectedFile = null;
    _errorMessage = null;
    notifyListeners();
  }

  void _clearControllers() {
    firstNameController.clear();
    lastNameController.clear();
    oldPasswordController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
    notifyListeners();
  }
}
