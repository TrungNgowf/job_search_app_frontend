import 'dart:convert';

import 'package:http/http.dart' as https;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/request/profile_req.dart';
import '../models/response/profile_res.dart';
import 'api_routes.dart';

class ProfileRepository {
  static var client = https.Client();

  static Future<bool> updateProfile(ProfileReq request) async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'token': 'Bearer $token'
    };
    var url = Uri.https(ApiRoutes.baseUrl, ApiRoutes.profileUrl);
    var response = await client.put(url,
        headers: requestHeaders, body: jsonEncode(request.toJson()));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<ProfileRes> getProfile() async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'token': 'Bearer $token'
    };
    var url = Uri.https(ApiRoutes.baseUrl, ApiRoutes.profileUrl);
    var response = await client.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      var profile = profileResFromJson(response.body);
      return profile;
    } else {
      throw Exception('Tải thông tin cá nhân thất bại');
    }
  }
}
