import 'package:cvhat/constants/api_endpoints.dart';
import 'package:dio/dio.dart';

class AuthService {
  AuthService._();

  static AuthService authService = AuthService._();
  final Dio _dio = Dio();

  Future<dynamic> login(String email, String password) async {
    try {
      Response response = await _dio.post(
        ApiEndPoints.userLogin,
        data: {"email": email, "password": password},
        options: Options(headers: {"Content-Type": "application/json"}),
      );

      if (response.statusCode == 200 && response.data != null) {
        return response.data;
      } else {
        throw Exception(response.data?["message"]?[0] ?? "Unknown error");
      }
    } on DioException catch (e) {
      if (e.response != null && e.response!.data is Map<String, dynamic>) {
        throw Exception(
            e.response!.data["message"]?[0] ?? "Something went wrong");
      }
      throw Exception("Network error. Please try again.");
    } catch (e) {
      throw Exception("An unexpected error occurred.");
    }
  }

  Future<dynamic> signUp(
      String firstName, String lastName, String email, String password) async {
    try {
      Response response = await _dio.post(ApiEndPoints.userSignup,
          data: {
            "firstName": firstName,
            "lastName": lastName,
            "email": email,
            "password": password
          },
          options: Options(headers: {"Content-Type": "application/json"}));
      if (response.statusCode == 200) {
        return response.data["message"];
      } else {
        throw Exception(response.data["message"]);
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return Future.error(e.response!.data["message"][0]);
      } else {
        throw Exception("Network error. Please try again.");
      }
    } catch (e) {
      throw Exception("Something Went Wrong");
    }
  }
}
