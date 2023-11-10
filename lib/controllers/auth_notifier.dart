import 'package:job_search_app_frontend/common/export.dart';

class AuthNotifier extends ChangeNotifier {
  //current index
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  set currentIndex(int newIndex) {
    _currentIndex = newIndex;
    notifyListeners();
  }
}
