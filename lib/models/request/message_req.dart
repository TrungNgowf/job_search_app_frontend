// To parse this JSON data, do
//
//     final messageRequest = messageRequestFromJson(jsonString);

import 'dart:convert';

MessageRequest messageRequestFromJson(String str) =>
    MessageRequest.fromJson(json.decode(str));

String messageRequestToJson(MessageRequest data) => json.encode(data.toJson());

class MessageRequest {
  final String content;
  final String chatId;
  final String receiver;

  MessageRequest({
    required this.content,
    required this.chatId,
    required this.receiver,
  });

  factory MessageRequest.fromJson(Map<String, dynamic> json) => MessageRequest(
        content: json["content"],
        chatId: json["chatId"],
        receiver: json["receiver"],
      );

  Map<String, dynamic> toJson() => {
        "content": content,
        "chatId": chatId,
        "receiver": receiver,
      };
}
