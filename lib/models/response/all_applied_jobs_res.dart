// To parse this JSON data, do
//
//     final AllBookmarksResponse = AllBookmarksResponseFromJson(jsonString);

import 'dart:convert';

import 'package:job_search_app_frontend/models/response/job_res.dart';

List<AllAppliedJobResponse> allAppliedJobResponseFromJson(String str) =>
    List<AllAppliedJobResponse>.from(
        jsonDecode(str).map((x) => AllAppliedJobResponse.fromJson(x)));

String allAppliedJobResponseToJson(AllAppliedJobResponse data) =>
    json.encode(data.toJson());

class AllAppliedJobResponse {
  final JobResponse job;
  final String userId;
  final String cvUrl;
  final String id;
  final DateTime createdAt;

  AllAppliedJobResponse({
    required this.job,
    required this.userId,
    required this.cvUrl,
    required this.id,
    required this.createdAt,
  });

  factory AllAppliedJobResponse.fromJson(Map<String, dynamic> json) =>
      AllAppliedJobResponse(
        job: JobResponse.fromJson(json["job"]),
        userId: json["userId"],
        cvUrl: json["cvUrl"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "job": job.toJson(),
        "userId": userId,
        "cvUrl": cvUrl,
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
      };
}
