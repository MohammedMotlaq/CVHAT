import 'package:cvhat/core/resources/app_colors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

  Widget buildFilePreview() {
    var selectedFileExtension = selectedFile!.extension!;
    if (["jpg", "png", "jpeg"].contains(selectedFileExtension.toLowerCase())) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.memory(
          selectedFile!.bytes!,
          fit: BoxFit.cover,
        ),
      );
    } else if (selectedFileExtension == "pdf") {
      return Icon(Icons.picture_as_pdf, color: AppColors.bgWhite, size: 48.sp);
    } else {
      return Icon(Icons.insert_drive_file,
          color: AppColors.bgWhite, size: 48.sp);
    }
  }
}
