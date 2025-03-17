import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FilePickerProvider extends ChangeNotifier {
  PlatformFile? selectedFile;
  bool isLoading = false;
  String? errorMessage;

  Future<void> pickFile({List<String>? allowedExtensions}) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: allowedExtensions != null ? FileType.custom : FileType.any,
        allowedExtensions: allowedExtensions,
      );

      if (result != null && result.files.isNotEmpty) {
        selectedFile = result.files.first;
      } else {
        errorMessage = "No file selected.";
      }
    } catch (e) {
      errorMessage = "Error picking file: $e";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void clearFile() {
    selectedFile = null;
    errorMessage = null;
    notifyListeners();
  }
}
