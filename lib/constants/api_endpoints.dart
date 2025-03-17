class ApiEndPoints {
  static const String baseUrl =
      "https://cvhat-awcmfwged7cvhzb6.francecentral-01.azurewebsites.net";

  static const String userSignup = "$baseUrl/user/auth/signup";
  static const String userLogin = "$baseUrl/user/auth/login";
  static const String userLogout = "$baseUrl/user/auth/logout";

  static const String getUserReviews = "$baseUrl/user/review";

  static const String getUserFavoriteReviews = "$getUserReviews/favorites";
  static const String getUserRecentReviews = "$getUserReviews?filter=recent";
  static const String getUserReviewsCount = "$getUserReviews/count";
  static const String postAiReview = "$getUserReviews/ai";
  static const String postUserCv = "$baseUrl/user/cv";
}
