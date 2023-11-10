import 'package:job_search_app_frontend/common/export.dart';

import '../../common/custom_appbar.dart';
import '../drawer/drawer_icon.dart';

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
        child: const CustomAppbar(
          title: "Chatting Page",
          leading: DrawerIcon(),
        ),
      ),
    );
  }
}