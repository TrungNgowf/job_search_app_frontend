// To parse this JSON data, do
//
//     final AllBookmarksResponse = AllBookmarksResponseFromJson(jsonString);

import 'dart:convert';

import 'package:job_search_app_frontend/models/response/job_res.dart';

List<AllBookmarksResponse> allBookmarksResponseFromJson(String str) =>
    List<AllBookmarksResponse>.from(
        jsonDecode(str).map((x) => AllBookmarksResponse.fromJson(x)));

String allBookmarksResponseToJson(AllBookmarksResponse data) =>
    json.encode(data.toJson());

class AllBookmarksResponse {
  final JobResponse job;
  final String userId;
  final String id;
  final DateTime createdAt;

  AllBookmarksResponse({
    required this.job,
    required this.userId,
    required this.id,
    required this.createdAt,
  });

  factory AllBookmarksResponse.fromJson(Map<String, dynamic> json) =>
      AllBookmarksResponse(
        job: JobResponse.fromJson(json["job"]),
        userId: json["userId"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "job": job.toJson(),
        "userId": userId,
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
      };
}
