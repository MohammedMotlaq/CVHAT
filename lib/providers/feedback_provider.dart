import 'package:cvhat/app_router.dart';
import 'package:cvhat/models/cv_model.dart';
import 'package:cvhat/models/review_model.dart';
import 'package:cvhat/services/local_storage_service.dart';
import 'package:cvhat/services/reviews_service.dart';
import 'package:cvhat/views/feedback_screen/feedback_page.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart' show ToastificationType;

class FeedBackProvider extends ChangeNotifier {
  final LocalStorageService localStorageService =
      LocalStorageService.localStorageService;
  final ReviewsService _reviewsService = ReviewsService.reviewsService;
  TextEditingController submitCvController = TextEditingController();
  CV? postCVResponse;
  Review? singleFeedBack;
  bool isReviewFavorite = false;
  bool _isLoading = false;
  bool _isUploading = false;
  bool _isAnalyzing = false;
  PlatformFile? selectedCV;

  bool get isUploading => _isUploading;

  bool get isAnalyzing => _isAnalyzing;

  bool get isLoading => _isLoading;

  toggleIsReviewFavorite() {
    isReviewFavorite = !isReviewFavorite;
    notifyListeners();
  }

  Future<void> fetchReviewByID(int reviewId) async {
    _isLoading = true;
    singleFeedBack = null;
    isReviewFavorite = false;
    notifyListeners();
    AppRouter.pushWidget(const FeedbackPage());

    try {
      String? userToken = await localStorageService.getUserToken();
      Review review =
          await _reviewsService.fetchReviewByID(userToken!, reviewId);
      singleFeedBack = review;
      isReviewFavorite = singleFeedBack!.isFavorite;
      notifyListeners();
    } catch (e) {
      AppRouter.toastificationSnackBar(
          "Error", e.toString(), ToastificationType.error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> postCV(PlatformFile? selectedFile) async {
    _isUploading = true;
    notifyListeners();
    try {
      if (selectedFile == null) {
        AppRouter.toastificationSnackBar(
            "Error", "Please Select a File", ToastificationType.error);
        return;
      }
      if (submitCvController.text.isEmpty) {
        AppRouter.toastificationSnackBar(
            "Error", "Please Enter a Title", ToastificationType.error);
        return;
      }
      if (selectedFile.extension != "pdf") {
        AppRouter.toastificationSnackBar(
            "Error", "Please select  a PDF file", ToastificationType.error);
        return;
      }
      if (kDebugMode) {
        print("Uploading cv in provider Cv in Service");
      }

      String? userToken = await localStorageService.getUserToken();
      postCVResponse = await _reviewsService.postCV(userToken!, selectedFile);
      notifyListeners();
      if (postCVResponse != null) {
        AppRouter.toastificationSnackBar(
            "Success", "CV uploaded successfully", ToastificationType.success);
        await postAIReview();
      }
    } catch (e) {
      AppRouter.toastificationSnackBar(
          "Error", "Something Went Wrong!", ToastificationType.error);
    } finally {
      _isUploading = false;
      notifyListeners();
    }
  }

  Future postAIReview() async {
    singleFeedBack = null;
    isReviewFavorite = false;
    _isAnalyzing = true;
    notifyListeners();
    AppRouter.pushWithReplacement(const FeedbackPage());
    try {
      if (kDebugMode) {
        print("getting review in provider Cv in Service");
        print("CV id is:${postCVResponse!.id!}");
      }
      String? userToken = await localStorageService.getUserToken();
      singleFeedBack = await _reviewsService.postAiReview(
          userToken!, postCVResponse!.id!, submitCvController.text);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      AppRouter.toastificationSnackBar(
          "Error", "Error PostingAi Review", ToastificationType.error);
    } finally {
      _isAnalyzing = false;
      notifyListeners();
    }
  }

  Future toggleFavorite() async {
    _isLoading = true;
    notifyListeners();
    if (singleFeedBack == null) {
      AppRouter.toastificationSnackBar(
          "Error", "Review Not Found", ToastificationType.error);
      return;
    }
    try {
      String? userToken = await localStorageService.getUserToken();
      await _reviewsService.toggleFavorite(userToken!, singleFeedBack!.id);
      toggleIsReviewFavorite();
      isReviewFavorite
          ? AppRouter.toastificationSnackBar(
              "Success",
              "This Review Added to your Favorites.",
              ToastificationType.success)
          : AppRouter.toastificationSnackBar(
              "Success",
              "This Review Removed From your Favorites.",
              ToastificationType.success);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
