import 'dart:convert';

import 'package:http/http.dart' as https;
import 'package:job_search_app_frontend/models/response/all_chats_res.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api_routes.dart';

class ChatRepository {
  static var client = https.Client();

  static Future<List<dynamic>> apply(String userId) async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'token': 'Bearer $token'
    };
    var url = Uri.https(ApiRoutes.baseUrl, ApiRoutes.chatUrl);
    var response = await client.post(url,
        headers: requestHeaders, body: jsonEncode({"userId": userId}));
    if (response.statusCode == 200) {
      String chatId = jsonDecode(response.body)['_id'];
      return [true, chatId];
    } else {
      return [false, 'Gửi yêu cầu thất bại'];
    }
  }

  static Future<List<AllChatsResponse>> getAllChats() async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'token': 'Bearer $token'
    };
    var url = Uri.https(ApiRoutes.baseUrl, ApiRoutes.chatUrl);
    var response = await client.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      var chats = allChatsResponseFromJson(response.body);
      return chats;
    } else {
      throw Exception('Tải danh sách chat thất bại');
    }
  }
}
