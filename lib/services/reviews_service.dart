import 'package:cvhat/constants/api_endpoints.dart';
import 'package:dio/dio.dart';
import '../models/review_model.dart';

class ReviewsService {
  ReviewsService._();

  static ReviewsService reviewsService = ReviewsService._();
  final Dio _dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  Future<List<Review>> _fetchReviews(String userToken, String endpoint) async {
    try {
      final response = await _dio.get(
        endpoint,
        options: Options(
          headers: {
            "Authorization":
                "Bearer $userToken", // Include userToken in headers
          },
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> reviews = response.data["review"];

        if (reviews.isNotEmpty) {
          return reviews.map((json) => Review.fromJson(json)).toList();
        }
      }
      throw Exception("Failed to load reviews");
    } catch (e) {
      throw Exception("Error fetching reviews: $e");
    }
  }

  Future<List<Review>> fetchReviewByID(
      String userToken, String reviewID) async {
    return await _fetchReviews(
        userToken, " ${ApiEndPoints.getUserReviews}/$reviewID");
  }

  Future<List<Review>> fetchAllReviews(String userToken) async {
    return await _fetchReviews(userToken, ApiEndPoints.getUserReviews);
  }

  Future<List<Review>> fetchRecentReviews(String userToken) async {
    return await _fetchReviews(userToken, ApiEndPoints.getUserRecentReviews);
  }

  Future<List<Review>> fetchFavoriteReviews(String userToken) async {
    return await _fetchReviews(userToken, ApiEndPoints.getUserFavoriteReviews);
  }
}
