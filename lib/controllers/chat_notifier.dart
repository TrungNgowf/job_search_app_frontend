import 'package:intl/intl.dart';
import 'package:job_search_app_frontend/common/export.dart';
import 'package:job_search_app_frontend/models/response/all_chats_res.dart';
import 'package:job_search_app_frontend/services/chat_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatNotifier extends ChangeNotifier {
  late String usedId;
  late Future<List<AllChatsResponse>> chats;
  List<String> _online = [];
  bool _typing = false;

  bool get typing => _typing;

  set typing(bool typing) {
    _typing = typing;
    notifyListeners();
  }

  List<String> get online => _online;

  set online(List<String> online) {
    _online = online;
    notifyListeners();
  }

  getChats() {
    chats = ChatRepository.getAllChats();
  }

  getPrefs() async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString('userId');
    usedId = id!;
  }

  String formatTime(String time) {
    DateTime now = DateTime.now();
    DateTime dateTime = DateTime.parse(time);
    if (now.year == dateTime.year &&
        now.month == dateTime.month &&
        now.day == dateTime.day) {
      String formattedTime = DateFormat('HH:mm').format(dateTime);
      return formattedTime;
    } else if (now.year == dateTime.year &&
        now.month == dateTime.month &&
        now.day == dateTime.day + 1) {
      String formattedTime = DateFormat('HH:mm').format(dateTime);
      return 'Hôm qua\n$formattedTime';
    } else {
      String formattedTime = DateFormat('dd/MM/yyyy').format(dateTime);
      return formattedTime;
    }
  }
}
