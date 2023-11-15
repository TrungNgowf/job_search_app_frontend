import 'package:job_search_app_frontend/common/export.dart';
import 'package:http/http.dart' as https;
import 'package:job_search_app_frontend/models/response/job_res.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api_routes.dart';

class JobRepository {
  static var client = https.Client();

  Future<List<JobResponse>> getJobs() async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'token': 'Bearer $token'
    };
    var url = Uri.https(ApiRoutes.baseUrl, ApiRoutes.jobUrl);
    var response = await client.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      List<JobResponse> jobsList = jobsResponseFromJson(response.body);
      return jobsList;
    } else {
      throw Exception('Failed to load jobs');
    }
  }
}
