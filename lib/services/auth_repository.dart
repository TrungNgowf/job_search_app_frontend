import 'package:job_search_app_frontend/common/export.dart';
import 'package:http/http.dart' as https;
import 'package:job_search_app_frontend/models/request/login_req.dart';
import 'package:job_search_app_frontend/models/response/login_res.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/request/register_req.dart';
import '../models/response/register_res.dart';
import 'api_routes.dart';

class AuthRepository {
  static var client = https.Client();

  static Future<bool> login(LoginRequest loginRequest) async {
    Map<String, String> requestHeaders = {'Content-type': 'application/json'};
    var url = Uri.https(ApiRoutes.baseUrl, ApiRoutes.loginUrl);
    var response = await client.post(url,
        headers: requestHeaders, body: loginRequestToJson(loginRequest));
    if (response.statusCode == 200) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      LoginResponse loginResponse = loginResponseFromJson(response.body);
      String token = loginResponse.accessToken;
      String userId = loginResponse.id;
      String? profilePic = loginResponse.profilePic;
      await prefs.setString('token', token);
      await prefs.setString('userId', userId);
      await prefs.setString('profilePic', profilePic!);
      await prefs.setBool('loggedIn', true);
      return true;
    } else {
      return false;
    }
  }

  static Future<int> register(RegisterRequest registerRequest) async {
    Map<String, String> requestHeaders = {'Content-type': 'application/json'};
    var url = Uri.https(ApiRoutes.baseUrl, ApiRoutes.registerUrl);
    var response = await client.post(url,
        headers: requestHeaders, body: registerRequestToJson(registerRequest));
    if (response.statusCode == 200) {
      RegisterResponse registerResponse =
          registerResponseFromJson(response.body);
      return 1;
    } else {
      return response.statusCode;
    }
  }
}
