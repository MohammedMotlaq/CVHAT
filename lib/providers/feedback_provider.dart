import 'package:cvhat/app_router.dart';
import 'package:cvhat/models/review_model.dart';
import 'package:cvhat/services/local_storage_service.dart';
import 'package:cvhat/services/reviews_service.dart';
import 'package:cvhat/views/feedback_screen/feedback_page.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart' show ToastificationType;

class FeedBackProvider extends ChangeNotifier {
  final LocalStorageService localStorageService =
      LocalStorageService.localStorageService;
  final ReviewsService _reviewsService = ReviewsService.reviewsService;

  Review? singleFeedBack;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> fetchReviewByID(int reviewId) async {
    _isLoading = true;
    notifyListeners();
    AppRouter.pushWidget(const FeedbackPage());

    try {
      String? userToken = await localStorageService.getUserToken();
      Review review =
          await _reviewsService.fetchReviewByID(userToken!, reviewId);
      singleFeedBack = review;
      notifyListeners();
    } catch (e) {
      AppRouter.toastificationSnackBar(
          "Error", e.toString(), ToastificationType.error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
