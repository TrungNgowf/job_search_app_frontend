// To parse this JSON data, do
//
//     final allMessagesResponse = allMessagesResponseFromJson(jsonString);

import 'dart:convert';

import 'all_chats_res.dart';

List<AllMessagesResponse> allMessagesResponseFromJson(String str) =>
    List<AllMessagesResponse>.from(
        json.decode(str).map((x) => AllMessagesResponse.fromJson(x)));

AllMessagesResponse allMessagesResponseFromJsonSingle(String str) =>
    AllMessagesResponse.fromJson(jsonDecode(str));

String allMessagesResponseToJson(List<AllMessagesResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllMessagesResponse {
  final String id;
  final Sender sender;
  final String content;
  final String receiver;
  final Chat chat;
  final List<dynamic> readBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  AllMessagesResponse({
    required this.id,
    required this.sender,
    required this.content,
    required this.receiver,
    required this.chat,
    required this.readBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AllMessagesResponse.fromJson(Map<String, dynamic> json) =>
      AllMessagesResponse(
        id: json["_id"],
        sender: Sender.fromJson(json["sender"]),
        content: json["content"],
        receiver: json["receiver"],
        chat: Chat.fromJson(json["chat"]),
        readBy: List<dynamic>.from(json["readBy"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "sender": sender.toJson(),
        "content": content,
        "receiver": receiver,
        "chat": chat.toJson(),
        "readBy": List<dynamic>.from(readBy.map((x) => x)),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class Chat {
  final String id;
  final String chatName;
  final bool isGroupChat;
  final List<Sender> users;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String latestMessage;

  Chat({
    required this.id,
    required this.chatName,
    required this.isGroupChat,
    required this.users,
    required this.createdAt,
    required this.updatedAt,
    required this.latestMessage,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        id: json["_id"],
        chatName: json["chatName"],
        isGroupChat: json["isGroupChat"],
        users: List<Sender>.from(json["users"].map((x) => Sender.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        latestMessage: json["latestMessage"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "chatName": chatName,
        "isGroupChat": isGroupChat,
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "latestMessage": latestMessage,
      };
}
