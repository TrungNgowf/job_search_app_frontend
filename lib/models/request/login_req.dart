// To parse this JSON data, do
//
//     final loginRequest = loginRequestFromJson(jsonString);

import 'dart:convert';

LoginRequest loginRequestFromJson(String str) => LoginRequest.fromJson(json.decode(str));

String loginRequestToJson(LoginRequest data) => json.encode(data.toJson());

class LoginRequest {
  final String telephone;
  final String password;

  LoginRequest({
    required this.telephone,
    required this.password,
  });

  factory LoginRequest.fromJson(Map<String, dynamic> json) => LoginRequest(
    telephone: json["telephone"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "telephone": telephone,
    "password": password,
  };
}
