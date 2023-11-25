import 'dart:convert';
import 'dart:io';

import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:chat_bubbles/message_bars/message_bar.dart';
import 'package:job_search_app_frontend/common/export.dart';
import 'package:job_search_app_frontend/controllers/chat_notifier.dart';
import 'package:job_search_app_frontend/models/response/all_messages_res.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../models/request/message_req.dart';
import '../../models/response/all_chats_res.dart';
import '../../services/message_repository.dart';

class ChatDetail extends StatefulWidget {
  final String chatId;
  final Sender chatWith;
  final Sender me;

  const ChatDetail(
      {super.key,
      required this.chatId,
      required this.chatWith,
      required this.me});

  @override
  State<ChatDetail> createState() => _ChatDetailState();
}

class _ChatDetailState extends State<ChatDetail> {
  IO.Socket? socket;
  int offset = 1;
  late Future<List<AllMessagesResponse>> messages;
  late List<AllMessagesResponse> messageList = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    connect();
    joinChat();
    handleNext();
    getMessages();
    super.initState();
  }

  void getMessages() async {
    messages = MessageRepository.getAllMessages(widget.chatId, offset);
  }

  void handleNext() {
    _scrollController.addListener(() async {
      if (_scrollController.hasClients) {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          if (messageList.length >= 12) {
            setState(() {
              offset++;
              getMessages();
            });
          }
        }
      }
    });
  }

  void connect() {
    var chatNotifier = Provider.of<ChatNotifier>(context, listen: false);
    socket = IO.io('https://jobee.up.railway.app', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket!.emit("setup", widget.me.id);
    socket!.connect();
    socket!.onConnect((_) {
      print("Connected to client");
      socket!.on('online-user', (userId) {
        chatNotifier.online
            .replaceRange(0, chatNotifier.online.length, [userId]);
      });
      socket!.on('typing', (data) {
        chatNotifier.typing = false;
      });
      socket!.on('stopTyping', (data) {
        chatNotifier.typing = true;
      });
      socket!.on('messageReceived', (data) {
        print(data);
        sendStopTypingEvent(widget.chatId);
        AllMessagesResponse message =
            allMessagesResponseFromJsonSingle(json.encode(data));
        if (message.sender.id != widget.me.id) {
          setState(() {
            messageList.insert(0, message);
          });
        }
      });
    });
  }

  void sendMessage(String content) {
    MessageRequest messageRequest = MessageRequest(
        content: content, receiver: widget.chatWith.id, chatId: widget.chatId);
    MessageRepository.sendMessage(messageRequest).then((value) {
      if (value[0]) {
        var emitData = value[2];
        socket!.emit('newMessage', emitData);
        sendStopTypingEvent(widget.chatId);
        AllMessagesResponse message = value[1];
        setState(() {
          getMessages();
          messageList.insert(0, message);
        });
      } else {
        print(value[1]);
      }
    });
  }

  void sendTypingEvent(String status) {
    socket!.emit('typing', status);
  }

  void sendStopTypingEvent(String status) {
    socket!.emit('stopTyping', status);
  }

  void joinChat() {
    socket!.emit('joinRoom', widget.chatId);
  }

  @override
  Widget build(BuildContext context) {
    getMessages();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(7.h),
        child: CustomAppbar(title: widget.chatWith.username, trailing: [
          Padding(
            padding: EdgeInsets.only(right: 3.w),
            child: CircleAvatar(
              backgroundImage: NetworkImage(widget.chatWith.profilePic),
            ),
          )
        ]),
      ),
      body: Consumer<ChatNotifier>(
        builder: (context, chatNotifier, child) {
          return Column(
            children: [
              Expanded(
                child: FutureBuilder<List<AllMessagesResponse>>(
                  future: messages,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container();
                    } else if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    } else {
                      final messages = snapshot.data!;
                      messageList = messageList + messages;
                      return ListView.builder(
                          controller: _scrollController,
                          itemCount: messageList.length,
                          itemBuilder: (context, i) {
                            return messageCard(
                                messageList[i], chatNotifier, widget.me);
                          });
                    }
                  },
                ),
              ),
              MessageBar(
                onSend: (val) {
                  sendMessage(val);
                },
                messageBarHitText: "Nhập tin nhắn",
              ),
              Container(
                height: 2.h,
                color: const Color(0xffF4F4F5),
              )
            ],
          );
        },
      ),
    );
  }
}

Widget messageCard(
    AllMessagesResponse message, ChatNotifier chatNotifier, Sender me) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.h),
    child: Column(
      children: [
        AutoSizeText(
          chatNotifier.formatTime(message.updatedAt.toString()),
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 3.sp, color: Colors.grey, fontWeight: FontWeight.w300),
        ),
        Gap(1.h),
        BubbleSpecialThree(
          text: message.content,
          isSender: message.sender.id == me.id,
          color:
              message.sender.id == me.id ? Colors.blue : Colors.grey.shade200,
          tail: true,
        ),
      ],
    ),
  );
}
