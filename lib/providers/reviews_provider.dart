import 'package:cvhat/app_router.dart';
import 'package:cvhat/services/local_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import '../models/review_model.dart';
import '../services/reviews_service.dart';

class ReviewsProvider extends ChangeNotifier {
  final ReviewsService _reviewsService = ReviewsService.reviewsService;

  List<Review> _reviews = [];
  List<Review> _recentReviews = [];
  List<Review> _favoriteReviews = [];
  String _aiReviewsCount = "0";
  String _recruiterReviewsCount = "0";
  final LocalStorageService localStorageService =
      LocalStorageService.localStorageService;

  bool _isLoading = false;
  String? _errorMessage;

  List<Review> get reviews => _reviews;

  List<Review> get favoriteReviews => _favoriteReviews;

  List<Review> get recentReviews => _recentReviews;

  String get aiReviewsCount => _aiReviewsCount;

  String get recruiterReviewsCount => _recruiterReviewsCount;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  Future<void> fetchAllReviews() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      String? userToken = await localStorageService.getUserToken();
      _reviews = await _reviewsService.fetchAllReviews(userToken!);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchRecentReviews() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    print("test in fetch provider");
    try {
      String? userToken = await localStorageService.getUserToken();
      _recentReviews = await _reviewsService.fetchRecentReviews(userToken!);
    } catch (e) {
      _errorMessage = e.toString();
      print(e.toString());
      AppRouter.toastificationSnackBar(
          "Error", _errorMessage!, ToastificationType.error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchFavoriteReviews() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      String? userToken = await localStorageService.getUserToken();
      _favoriteReviews = await _reviewsService.fetchFavoriteReviews(userToken!);
      AppRouter.toastificationSnackBar("Success",
          "All Favorite Reviews Retrieved!", ToastificationType.error);
    } catch (e) {
      _errorMessage = e.toString();
      AppRouter.toastificationSnackBar(
          "Error", "Error Fetching Favorite Reviews", ToastificationType.error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchReviewsCounts() async {
    try {
      String? userToken = await localStorageService.getUserToken();
      final res = await _reviewsService.fetchReviewsCounts(userToken!);
      _aiReviewsCount = res["aiReviewCount"].toString();
      _recruiterReviewsCount = res["recruiterReviewCount"].toString();
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      AppRouter.toastificationSnackBar(
          "Error", _errorMessage!, ToastificationType.error);
    }
  }
}
