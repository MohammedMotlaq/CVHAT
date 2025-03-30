import 'package:cvhat/app_router.dart';
import 'package:cvhat/models/profile_model.dart';
import 'package:cvhat/services/local_storage_service.dart';
import 'package:cvhat/services/profile_service.dart';
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

  Future<void> postAvatar(PlatformFile? selectedFile) async {
    _isLoading = true;
    notifyListeners();
    try {
      if (selectedFile == null) {
        AppRouter.toastificationSnackBar(
            "Error", "Please Select Avatar!", ToastificationType.error);
        return;
      }
      if (selectedFile.extension != "jpg") {
        AppRouter.toastificationSnackBar(
            "Error", "Please select jpg file", ToastificationType.error);
        return;
      }
      if (kDebugMode) {
        print("Uploading Avatar in profile provider");
      }
      String? userToken = await localStorageService.getUserToken();
      await _profileService.postAvatar(userToken!, selectedFile);
      notifyListeners();
      AppRouter.toastificationSnackBar(
          "Success", "Avatar Updated Successfully", ToastificationType.success);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      } else {
        AppRouter.toastificationSnackBar(
            "Error", "Something Went Wrong!", ToastificationType.error);
      }
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
}
