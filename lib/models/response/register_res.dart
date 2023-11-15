// To parse this JSON data, do
//
//     final registerResponse = registerResponseFromJson(jsonString);

import 'dart:convert';

RegisterResponse registerResponseFromJson(String str) =>
    RegisterResponse.fromJson(json.decode(str));

String registerResponseToJson(RegisterResponse data) =>
    json.encode(data.toJson());

class RegisterResponse {
  final String username;
  final String telephone;
  final String email;
  final bool? isAdmin;
  final bool? isAgent;
  final List<dynamic>? skills;
  final String? profilePic;
  final String id;
  final DateTime createdAt;
  final DateTime? updatedAt;

  RegisterResponse({
    required this.username,
    required this.telephone,
    required this.email,
    this.isAdmin,
    this.isAgent,
    this.skills,
    this.profilePic,
    required this.id,
    required this.createdAt,
    this.updatedAt,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      RegisterResponse(
        username: json["username"],
        telephone: json["telephone"],
        email: json["email"],
        isAdmin: json["isAdmin"],
        isAgent: json["isAgent"],
        skills: json["skills"] == null
            ? []
            : List<dynamic>.from(json["skills"]!.map((x) => x)),
        profilePic: json["profilePic"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "telephone": telephone,
        "email": email,
        "isAdmin": isAdmin,
        "isAgent": isAgent,
        "skills":
            skills == null ? [] : List<dynamic>.from(skills!.map((x) => x)),
        "profilePic": profilePic,
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
