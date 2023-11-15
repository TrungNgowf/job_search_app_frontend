// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  final String id;
  final String username;
  final String telephone;
  final String email;
  final bool isAdmin;
  final bool isAgent;
  final List<String>? skills;
  final String? profilePic;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String accessToken;

  LoginResponse({
    required this.id,
    required this.username,
    required this.telephone,
    required this.email,
    required this.isAdmin,
    required this.isAgent,
    this.skills,
    this.profilePic,
    required this.createdAt,
    required this.updatedAt,
    required this.accessToken,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        id: json["_id"],
        username: json["username"],
        telephone: json["telephone"],
        email: json["email"],
        isAdmin: json["isAdmin"],
        isAgent: json["isAgent"],
        skills: json["skills"] == null
            ? []
            : List<String>.from(json["skills"]!.map((x) => x)),
        profilePic: json["profilePic"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        accessToken: json["accessToken"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "telephone": telephone,
        "email": email,
        "isAdmin": isAdmin,
        "isAgent": isAgent,
        "skills":
            skills == null ? [] : List<dynamic>.from(skills!.map((x) => x)),
        "profilePic": profilePic,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "accessToken": accessToken,
      };
}
