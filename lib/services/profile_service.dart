import 'package:cvhat/constants/api_endpoints.dart';
import 'package:cvhat/models/profile_model.dart';
import 'package:dio/dio.dart';

class ProfileService {
  ProfileService._();

  static ProfileService profileService = ProfileService._();
  final Dio _dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 20),
    receiveTimeout: const Duration(seconds: 20),
  ));

  Future<Profile> getUserProfile(String userToken) async {
    try {
      final response = await _dio.get(ApiEndPoints.getProfile,
          options: Options(
            headers: {
              "Authorization": "Bearer $userToken",
            },
          ));
      print(response.toString());
      if (response.statusCode == 200) {
        final Map<String, dynamic> profile = response.data["data"]["profile"];

        if (profile.isNotEmpty) {
          return Profile.fromJson(profile);
        }
      }
      throw Exception("Failed to load profile");
    } catch (e) {
      throw Exception("Error fetching Profile: $e");
    }
  }
}
