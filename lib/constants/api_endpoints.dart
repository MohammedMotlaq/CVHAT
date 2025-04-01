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
  static const String toggleFavorite = "$getUserReviews/toggle-favorites/";
  static const String getProfile = "$baseUrl/user/profile";
  static const String postAvatar = "$baseUrl/user/profile/avatar";
  static const String postUserName = "$baseUrl/user/profile";
  static const String postNewPassword = "$baseUrl/user/profile/password";

  static const String sendOtp = "$baseUrl/user/auth/send-otp";
  static const String verifyOtp = "$baseUrl/user/auth/verify-otp";
  static const String resetPassword = "$baseUrl/user/auth/reset-password";
}
