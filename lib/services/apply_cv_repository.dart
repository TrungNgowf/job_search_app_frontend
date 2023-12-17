import 'dart:convert';

import 'package:job_search_app_frontend/common/export.dart';
import 'package:http/http.dart' as https;
import 'package:job_search_app_frontend/models/response/all_bookmarks_res.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/response/all_applied_jobs_res.dart';
import 'api_routes.dart';

class ApplyCVRepository {
  static var client = https.Client();

  static Future<List<dynamic>> applyJob(String jobId, String cvPath) async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'token': 'Bearer $token'
    };
    var url = Uri.https(ApiRoutes.baseUrl, ApiRoutes.cvUrl);
    var response = await client.post(url,
        headers: requestHeaders,
        body: jsonEncode({"job": jobId, "cvUrl": cvPath}));
    if (response.statusCode == 200) {
      String cvId = jsonDecode(response.body);
      return [true, cvId];
    } else if (response.statusCode == 400) {
      return [false, 'Bạn đã ứng tuyển công việc này'];
    } else {
      return [false, 'Ứng tuyển công việc thất bại'];
    }
  }

  static Future<List<AllAppliedJobResponse>> getAppliedJobs() async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'token': 'Bearer $token'
    };
    var url = Uri.https(ApiRoutes.baseUrl, ApiRoutes.cvUrl);
    var response = await client.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      var appliedJobs = allAppliedJobResponseFromJson(response.body);
      return appliedJobs;
    } else {
      throw Exception('Tải danh sách công việc đã ứng tuyển thất bại');
    }
  }

  static Future<bool> deleteAppliedJobs(String jobId) async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'token': 'Bearer $token'
    };
    var url = Uri.https(ApiRoutes.baseUrl, "${ApiRoutes.cvUrl}/$jobId");
    var response = await client.delete(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
