// To parse this JSON data, do
//
//     final profileRes = profileResFromJson(jsonString);

import 'dart:convert';

ProfileRes profileResFromJson(String str) =>
    ProfileRes.fromJson(json.decode(str));

String profileResToJson(ProfileRes data) => json.encode(data.toJson());

class ProfileRes {
  final List<String>? experiences;
  final String? telephone;
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

  ProfileRes({
    this.experiences,
    this.telephone,
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

  factory ProfileRes.fromJson(Map<String, dynamic> json) => ProfileRes(
        experiences: json["experiences"] == null
            ? []
            : List<String>.from(json["experiences"]!.map((x) => x)),
        telephone: json["telephone"],
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
        "telephone": telephone,
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
