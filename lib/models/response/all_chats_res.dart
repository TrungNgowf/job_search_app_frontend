// To parse this JSON data, do
//
//     final allChatsResponse = allChatsResponseFromJson(jsonString);

import 'dart:convert';

List<AllChatsResponse> allChatsResponseFromJson(String str) =>
    List<AllChatsResponse>.from(
        json.decode(str).map((x) => AllChatsResponse.fromJson(x)));

String allChatsResponseToJson(AllChatsResponse data) =>
    json.encode(data.toJson());

class AllChatsResponse {
  final String id;
  final String chatName;
  final bool isGroupChat;
  final List<Sender> users;
  final DateTime createdAt;
  final DateTime updatedAt;
  final LatestMessage latestMessage;

  AllChatsResponse({
    required this.id,
    required this.chatName,
    required this.isGroupChat,
    required this.users,
    required this.createdAt,
    required this.updatedAt,
    required this.latestMessage,
  });

  factory AllChatsResponse.fromJson(Map<String, dynamic> json) =>
      AllChatsResponse(
        id: json["_id"],
        chatName: json["chatName"],
        isGroupChat: json["isGroupChat"],
        users: List<Sender>.from(json["users"].map((x) => Sender.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        latestMessage: LatestMessage.fromJson(json["latestMessage"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "chatName": chatName,
        "isGroupChat": isGroupChat,
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "latestMessage": latestMessage.toJson(),
      };
}

class LatestMessage {
  final String id;
  final Sender sender;
  final String content;
  final String receiver;
  final String chat;
  final List<dynamic> readBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  LatestMessage({
    required this.id,
    required this.sender,
    required this.content,
    required this.receiver,
    required this.chat,
    required this.readBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LatestMessage.fromJson(Map<String, dynamic> json) => LatestMessage(
        id: json["_id"],
        sender: Sender.fromJson(json["sender"]),
        content: json["content"],
        receiver: json["receiver"],
        chat: json["chat"],
        readBy: List<dynamic>.from(json["readBy"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "sender": sender.toJson(),
        "content": content,
        "receiver": receiver,
        "chat": chat,
        "readBy": List<dynamic>.from(readBy.map((x) => x)),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class Sender {
  final String id;
  final String username;
  final String telephone;
  final String email;
  final String profilePic;

  Sender({
    required this.id,
    required this.username,
    required this.telephone,
    required this.email,
    required this.profilePic,
  });

  factory Sender.fromJson(Map<String, dynamic> json) => Sender(
        id: json["_id"],
        username: json["username"],
        telephone: json["telephone"],
        email: json["email"],
        profilePic: json["profilePic"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "telephone": telephone,
        "email": email,
        "profilePic": profilePic,
      };
}
