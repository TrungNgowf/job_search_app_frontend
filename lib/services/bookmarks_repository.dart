import 'dart:convert';

import 'package:job_search_app_frontend/common/export.dart';
import 'package:http/http.dart' as https;
import 'package:job_search_app_frontend/models/response/all_bookmarks_res.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api_routes.dart';

class BookmarksRepository {
  static var client = https.Client();

  static Future<List<dynamic>> addBookmark(String jobId) async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'token': 'Bearer $token'
    };
    var url = Uri.https(ApiRoutes.baseUrl, ApiRoutes.bookmarkUrl);
    var response = await client.post(url,
        headers: requestHeaders, body: jsonEncode({"job": jobId}));
    if (response.statusCode == 200) {
      String bookmarkId = jsonDecode(response.body);
      return [true, bookmarkId];
    } else if (response.statusCode == 400) {
      return [false, 'Bạn đã từng lưu công việc này'];
    } else {
      return [false, 'Lưu công việc thất bại'];
    }
  }

  static Future<List<AllBookmarksRes>> getBookmarks() async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'token': 'Bearer $token'
    };
    var url = Uri.https(ApiRoutes.baseUrl, ApiRoutes.bookmarkUrl);
    var response = await client.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      var bookmarksList = allBookmarksResFromJson(response.body);
      return bookmarksList;
    } else {
      throw Exception('Tải danh sách công việc đã lưu thất bại');
    }
  }

  static Future<bool> deleteBookmark(String jobId) async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'token': 'Bearer $token'
    };
    var url = Uri.https(ApiRoutes.baseUrl, "${ApiRoutes.bookmarkUrl}/$jobId");
    var response = await client.delete(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
