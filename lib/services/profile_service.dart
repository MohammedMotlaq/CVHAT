import 'package:cvhat/constants/api_endpoints.dart';
import 'package:cvhat/models/profile_model.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';

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

  Future<Profile> postAvatar(String userToken, PlatformFile avatarFile) async {
    try {
      print("Uploading Avatar in Profile service");

      MultipartFile multiPartFile = await MultipartFile.fromFile(
        avatarFile.path!,
        filename: avatarFile.name,
        contentType: DioMediaType("image", "jpg"),
      );
      FormData data = FormData.fromMap({'avatar': multiPartFile});
      Response response = await _dio.post(
        ApiEndPoints.postAvatar,
        options: Options(
          headers: {
            "Authorization": "Bearer $userToken",
          },
        ),
        data: data,
      );
      print(response.toString());
      if (response.statusCode == 200) {
        return Profile.fromJson(response.data["data"]["profile"]);
      } else {
        throw Exception("Error Posting Avatar Profile!");
      }
    } catch (error) {
      throw Exception(error.toString());
    }
  }
}
