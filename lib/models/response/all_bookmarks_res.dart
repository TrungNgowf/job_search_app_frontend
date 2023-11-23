// To parse this JSON data, do
//
//     final allBookmarksRes = allBookmarksResFromJson(jsonString);

import 'dart:convert';

import 'package:job_search_app_frontend/models/response/job_res.dart';

List<AllBookmarksRes> allBookmarksResFromJson(String str) =>
    List<AllBookmarksRes>.from(
        jsonDecode(str).map((x) => AllBookmarksRes.fromJson(x)));

String allBookmarksResToJson(AllBookmarksRes data) =>
    json.encode(data.toJson());

class AllBookmarksRes {
  final JobResponse job;
  final String userId;
  final String id;
  final DateTime createdAt;

  AllBookmarksRes({
    required this.job,
    required this.userId,
    required this.id,
    required this.createdAt,
  });

  factory AllBookmarksRes.fromJson(Map<String, dynamic> json) =>
      AllBookmarksRes(
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
