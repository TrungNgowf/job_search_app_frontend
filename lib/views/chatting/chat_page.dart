import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:job_search_app_frontend/common/export.dart';
import 'package:job_search_app_frontend/controllers/chat_notifier.dart';
import 'package:job_search_app_frontend/models/response/all_chats_res.dart';
import 'package:provider/provider.dart';

import '../../common/custom_appbar.dart';
import '../../common/custom_navigator_appbar.dart';
import '../drawer/drawer_icon.dart';
import 'chat_detail.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(7.h),
        child: const NavigatorAppbar(
          title: 'Nhắn tin',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(3.w),
        child: Consumer<ChatNotifier>(builder: (context, chatNotifier, child) {
          chatNotifier.getChats();
          chatNotifier.getPrefs();
          return FutureBuilder<List<AllChatsResponse>>(
            future: chatNotifier.chats,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: ReusableText('Error ${snapshot.error}'),
                );
              } else if (snapshot.data!.isEmpty) {
                return Container(
                    margin: EdgeInsets.only(top: 30.h),
                    child: Center(
                        child: ReusableText(
                      "Không có tin nhắn nào",
                      style: appStyle(size: 5),
                    )));
              } else {
                final chats = snapshot.data!;
                return ListView.builder(
                    itemCount: chats.length,
                    itemBuilder: (context, i) {
                      return chatCard(chats[i], chatNotifier);
                    });
              }
            },
          );
        }),
      ),
    );
  }

  Widget chatCard(AllChatsResponse chat, ChatNotifier chatNotifier) {
    Sender thatUser =
        chat.users.where((e) => e.id != chatNotifier.usedId).first;
    Sender me = chat.users.where((e) => e.id != thatUser.id).first;
    return GestureDetector(
      onTap: () {
        Get.to(() => ChatDetail(chatId: chat.id, chatWith: thatUser, me: me));
      },
      child: Container(
          height: 10.h,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 3.w),
            minLeadingWidth: 0,
            minVerticalPadding: 0,
            leading: CircleAvatar(
              radius: 10.w,
              backgroundImage: NetworkImage(thatUser.profilePic),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ReusableText(
                  thatUser.username,
                  style: appStyle(fw: FontWeight.w600),
                ),
                Gap(0.5.h),
                ReusableText(
                  chat.chatName == thatUser.id
                      ? chat.latestMessage.content
                      : "Bạn: ${chat.latestMessage.content}",
                  style: appStyle(size: 3.5, color: Colors.grey),
                  maxLines: 1,
                ),
              ],
            ),
            trailing: Padding(
                padding: EdgeInsets.only(right: 3.w),
                child: ReusableText(
                  chatNotifier
                      .formatTime(chat.latestMessage.createdAt.toString()),
                  style: appStyle(size: 3.5, color: Colors.grey),
                )),
          )),
    );
  }
}
