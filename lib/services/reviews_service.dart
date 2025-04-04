import 'package:cvhat/constants/api_endpoints.dart';
import 'package:cvhat/models/cv_model.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import '../models/review_model.dart';

class ReviewsService {
  ReviewsService._();

  static ReviewsService reviewsService = ReviewsService._();
  final Dio _dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 20),
    receiveTimeout: const Duration(seconds: 20),
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
        final List<dynamic> reviews = response.data["data"]["reviews"];

        if (reviews.isNotEmpty) {
          return reviews.map((json) => Review.fromJson(json)).toList();
        }
      }
      throw Exception("Failed to load reviews");
    } catch (e) {
      throw Exception("Error fetching reviews: $e");
    }
  }

  Future<Review> fetchReviewByID(String userToken, int reviewID) async {
    try {
      final response = await _dio.get(
        "${ApiEndPoints.getUserReviews}/$reviewID",
        options: Options(
          headers: {
            "Authorization": "Bearer $userToken",
            // Include userToken in headers
          },
        ),
      );

      if (response.statusCode == 200 && response.data["status"] == "success") {
        final reviewJson =
            response.data["data"]["review"]; // Extract first review
        return Review.fromJson(reviewJson);
      } else {
        throw Exception("Failed to fetch review");
      }
    } catch (error) {
      throw Exception("Error fetching review: $error");
    }
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

  Future<Map<String, int>> fetchReviewsCounts(String userToken) async {
    try {
      final response = await _dio.get(
        ApiEndPoints.getUserReviewsCount,
        options: Options(
          headers: {
            "Authorization":
                "Bearer $userToken", // Include userToken in headers
          },
        ),
      );

      if (response.statusCode == 200) {
        return {
          "aiReviewCount": response.data["data"]["aiReviewCount"],
          "recruiterReviewCount": response.data["data"]["recruiterReviewCount"]
        };
      }
      throw Exception("Failed to load Reviews Counts");
    } catch (e) {
      throw Exception("Error fetching reviews: $e");
    }
  }

  Future<CV> postCV(String userToken, PlatformFile pdfFile) async {
    try {
      print("Uploading cv in service Cv in Service");

      MultipartFile multiPartFile = await MultipartFile.fromFile(
        pdfFile.path!,
        filename: pdfFile.name,
        contentType: DioMediaType("application", "pdf"),
      );

      FormData data = FormData.fromMap({'cv': multiPartFile});
      Response response = await _dio.post(
        ApiEndPoints.postUserCv,
        options: Options(
          headers: {
            "Authorization": "Bearer $userToken",
          },
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        return CV.fromJson(response.data["data"]["cv"]);
      } else {
        throw Exception("Error Posting CV");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Review> postAiReview(String userToken, int cvID, String title) async {
    try {
      print("getting review in Service");
      Response response = await _dio.post(
        ApiEndPoints.postAiReview,
        options: Options(
          headers: {
            "Authorization": "Bearer $userToken",
          },
        ),
        data: {"cv": cvID, "title": title},
      );

      if (response.statusCode == 200) {
        return Review.fromJson(response.data["data"]["review"]);
      } else {
        throw Exception("Error Posting AI Review");
      }
    } on DioException catch (e) {
      throw Exception(e.toString());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<bool> toggleFavorite(String userToken, int reviewID) async {
    print("in toggle favorite in service");
    try {
      Response response = await _dio.post(
        "${ApiEndPoints.toggleFavorite}/$reviewID",
        options: Options(
          headers: {
            "Authorization": "Bearer $userToken",
          },
        ),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
