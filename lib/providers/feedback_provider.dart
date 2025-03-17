import 'package:cvhat/app_router.dart';
import 'package:cvhat/models/cv_model.dart';
import 'package:cvhat/models/review_model.dart';
import 'package:cvhat/services/local_storage_service.dart';
import 'package:cvhat/services/reviews_service.dart';
import 'package:cvhat/views/feedback_screen/feedback_page.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart' show ToastificationType;

class FeedBackProvider extends ChangeNotifier {
  final LocalStorageService localStorageService =
      LocalStorageService.localStorageService;
  final ReviewsService _reviewsService = ReviewsService.reviewsService;
  TextEditingController submitCvController = TextEditingController();
  CV? postCVResponse;
  Review? singleFeedBack;
  bool? isReviewFavorite;
  bool _isLoading = false;
  bool _isUploading = false;
  bool _isAnalyzing = false;
  PlatformFile? selectedCV;

  bool get isUploading => _isUploading;

  bool get isAnalyzing => _isAnalyzing;

  bool get isLoading => _isLoading;

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
      print("Uploading cv in provider Cv in Service");

      String? userToken = await localStorageService.getUserToken();
      postCVResponse = await _reviewsService.postCV(
          userToken!, selectedFile, submitCvController.text);
      notifyListeners();
      if (postCVResponse != null) {
        AppRouter.toastificationSnackBar(
            "Success", "CV uploaded successfully", ToastificationType.success);
        await postAIReview();
      }
    } catch (e) {
      AppRouter.toastificationSnackBar(
          "Error", "Somthing Went Wrong!", ToastificationType.error);
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
      print("getting review in provider Cv in Service");
      print("CV id is:" + postCVResponse!.id!.toString());
      String? userToken = await localStorageService.getUserToken();
      singleFeedBack =
          await _reviewsService.postAiReview(userToken!, postCVResponse!.id!);
      isReviewFavorite = singleFeedBack!.isFavorite;
    } catch (e) {
      print(e.toString());
      AppRouter.toastificationSnackBar(
          "Error", "Error PostingAi Review", ToastificationType.error);
    } finally {
      _isAnalyzing = false;
      notifyListeners();
    }
  }

  Future toggleFavorite() async {
    try {
      String? userToken = await localStorageService.getUserToken();
      bool isFavorite =
          await _reviewsService.toggleFavorite(userToken!, singleFeedBack!.id);
      if (isFavorite) {
        isReviewFavorite = singleFeedBack!.isFavorite;
        notifyListeners();
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
