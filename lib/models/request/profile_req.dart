// To parse this JSON data, do
//
//     final profileReq = profileReqFromJson(jsonString);

import 'dart:convert';

ProfileReq profileReqFromJson(String str) =>
    ProfileReq.fromJson(json.decode(str));

String profileReqToJson(ProfileReq data) => json.encode(data.toJson());

class ProfileReq {
  final List<String>? experiences;
  final String? address;
  final String? portfolio;
  final String? education;
  final String? major;
  final String? degree;
  final String? careerGoals;
  final String? additionInfo;
  final String? username;
  final String? email;
  final List<String>? skills;
  final String? profilePic;
  final DateTime? dob;

  ProfileReq({
    this.experiences,
    this.address,
    this.portfolio,
    this.education,
    this.major,
    this.degree,
    this.careerGoals,
    this.additionInfo,
    this.username,
    this.email,
    this.skills,
    this.profilePic,
    this.dob,
  });

  factory ProfileReq.fromJson(Map<String, dynamic> json) => ProfileReq(
        experiences: json["experiences"] == null
            ? []
            : List<String>.from(json["experiences"]!.map((x) => x)),
        address: json["address"],
        portfolio: json["portfolio"],
        education: json["education"],
        major: json["major"],
        degree: json["degree"],
        careerGoals: json["careerGoals"],
        additionInfo: json["additionInfo"],
        username: json["username"],
        email: json["email"],
        skills: json["skills"] == null
            ? []
            : List<String>.from(json["skills"]!.map((x) => x)),
        profilePic: json["profilePic"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
      );

  Map<String, dynamic> toJson() => {
        "experiences": experiences == null
            ? []
            : List<dynamic>.from(experiences!.map((x) => x)),
        "address": address,
        "portfolio": portfolio,
        "education": education,
        "major": major,
        "degree": degree,
        "careerGoals": careerGoals,
        "additionInfo": additionInfo,
        "username": username,
        "email": email,
        "skills":
            skills == null ? [] : List<dynamic>.from(skills!.map((x) => x)),
        "profilePic": profilePic,
        "dob":
            "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
      };
}
