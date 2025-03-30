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

  Future<Profile> updateUserName(
      String userToken, String firstName, String lastName) async {
    try {
      print("Updating user name in Profile service...");

      Map<String, dynamic> data = {
        "firstName": firstName,
        "lastName": lastName,
      };

      Response response = await _dio.post(
        ApiEndPoints.postUserName,
        options: Options(
          headers: {
            "Authorization": "Bearer $userToken",
            "Content-Type": "application/json",
          },
        ),
        data: data,
      );

      print(response.toString());

      if (response.statusCode == 200) {
        return Profile.fromJson(response.data["data"]["profile"]);
      } else {
        throw Exception("Error updating profile!");
      }
    } catch (error) {
      throw Exception("Profile update failed: ${error.toString()}");
    }
  }

  Future<void> changePassword(
      String userToken, String oldPassword, String newPassword) async {
    try {
      print("Changing password at: ${ApiEndPoints.postNewPassword}");

      Map<String, dynamic> data = {
        "oldPassword": oldPassword,
        "newPassword": newPassword,
      };

      print("Request Data: $data");

      Response response = await _dio.post(
        ApiEndPoints.postNewPassword,
        options: Options(
          headers: {
            "Authorization": "Bearer $userToken",
            "Content-Type": "application/json",
          },
        ),
        data: data, // Send JSON payload
      );

      print("Response: ${response.data}");

      if (response.statusCode == 200) {
        print("Password changed successfully");
      } else {
        throw Exception("Error changing password!");
      }
    } catch (error) {
      if (error is DioException) {
        print(
            "Error Response: ${error.response?.data}"); // Print server error details
      }
      throw Exception("Password change failed: ${error.toString()}");
    }
  }
}
