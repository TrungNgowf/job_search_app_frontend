// To parse this JSON data, do
//
//     final jobResponse = jobResponseFromJson(jsonString);

import 'dart:convert';

List<JobResponse> jobsResponseFromJson(String str) => List<JobResponse>.from(
    json.decode(str).map((x) => JobResponse.fromJson(x)));

String jobResponseToJson(JobResponse data) => json.encode(data.toJson());

class JobResponse {
  final String? title;
  final String? company;
  final String? location;
  final String? description;
  final String? salary;
  final String? period;
  final String? contract;
  final List<String>? requirements;
  final String? imageUrl;
  final String? agentId;
  final String? id;
  final DateTime? expiredDate;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  JobResponse({
    this.title,
    this.company,
    this.location,
    this.description,
    this.salary,
    this.period,
    this.contract,
    this.requirements,
    this.imageUrl,
    this.agentId,
    this.id,
    this.expiredDate,
    this.createdAt,
    this.updatedAt,
  });

  factory JobResponse.fromJson(Map<String, dynamic> json) => JobResponse(
        title: json["title"],
        company: json["company"],
        location: json["location"],
        description: json["description"],
        salary: json["salary"],
        period: json["period"],
        contract: json["contract"],
        requirements: json["requirements"] == null
            ? []
            : List<String>.from(json["requirements"]!.map((x) => x)),
        imageUrl: json["imageUrl"],
        agentId: json["agentId"],
        id: json["_id"],
        expiredDate: json["expiredDate"] == null
            ? null
            : DateTime.parse(json["expiredDate"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "company": company,
        "location": location,
        "description": description,
        "salary": salary,
        "period": period,
        "contract": contract,
        "requirements": requirements == null
            ? []
            : List<dynamic>.from(requirements!.map((x) => x)),
        "imageUrl": imageUrl,
        "agentId": agentId,
        "_id": id,
        "expiredDate": expiredDate?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
