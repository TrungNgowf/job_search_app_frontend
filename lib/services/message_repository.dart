import 'dart:convert';

import 'package:http/http.dart' as https;
import 'package:job_search_app_frontend/models/request/message_req.dart';
import 'package:job_search_app_frontend/models/response/all_chats_res.dart';
import 'package:job_search_app_frontend/models/response/all_messages_res.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api_routes.dart';

class MessageRepository {
  static var client = https.Client();

  static Future<List<dynamic>> sendMessage(
      MessageRequest messageRequest) async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'token': 'Bearer $token'
    };
    var url = Uri.https(ApiRoutes.baseUrl, ApiRoutes.messageUrl);
    var response = await client.post(url,
        headers: requestHeaders, body: jsonEncode(messageRequest.toJson()));
    if (response.statusCode == 200) {
      AllMessagesResponse message =
          allMessagesResponseFromJsonSingle(response.body);
      Map<String, dynamic> responseMap = jsonDecode(response.body);
      return [true, message, responseMap];
    } else {
      return [false, 'Gửi yêu cầu thất bại'];
    }
  }

  static Future<List<AllMessagesResponse>> getAllMessages(
      String chatId, int offset) async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'token': 'Bearer $token'
    };
    var url = Uri.https(ApiRoutes.baseUrl, "${ApiRoutes.messageUrl}/$chatId",
        {"page": offset.toString()});
    var response = await client.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      var messages = allMessagesResponseFromJson(response.body);
      return messages;
    } else {
      throw Exception('Tải danh sách tin nhắn thất bại');
    }
  }
}
