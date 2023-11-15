import 'package:get/get.dart';
import 'package:job_search_app_frontend/common/export.dart';
import 'package:job_search_app_frontend/models/request/login_req.dart';
import 'package:job_search_app_frontend/services/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/request/register_req.dart';
import '../views/auth/login.dart';
import '../views/nav_screen.dart';

class AuthNotifier extends ChangeNotifier {
  //logged in
  bool? _loggedIn;

  bool get loggedIn => _loggedIn ?? false;

  set loggedIn(bool newState) {
    _loggedIn = newState;
    notifyListeners();
  }

  getPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    loggedIn = prefs.getBool("loggedIn") ?? false;
  }

  login(LoginRequest loginRequest) {
    AuthRepository.login(loginRequest).then((value) {
      if (value) {
        Get.off(() => const NavigationScreen());
      } else if (!value) {
        Get.snackbar("Đăng nhập thất bại", "Kiểm tra lại thông tin đăng nhập",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            icon: const Icon(
              Icons.error_outline_rounded,
              color: Colors.white,
            ));
      }
    });
  }

  register(RegisterRequest registerRequest) {
    AuthRepository.register(registerRequest).then((value) {
      if (value == 1) {
        Get.snackbar("Đăng ký tài khoản thành công", "Xin mời đăng nhập",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white,
            icon: const Icon(
              Icons.check_circle_outline_rounded,
              color: Colors.white,
            ));
        Get.off(() => const LoginForm());
      } else if (value == 400) {
        Get.snackbar(
            "Tài khoản đã tồn tại", "Kiểm tra lại số điện thoại hoặc email",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            icon: const Icon(
              Icons.error_outline_rounded,
              color: Colors.white,
            ));
      } else {
        Get.snackbar("Đăng ký thất bại", "Có lỗi xảy ra!",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            icon: const Icon(
              Icons.error_outline_rounded,
              color: Colors.white,
            ));
      }
    });
  }

  logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("loggedIn", false);
    await prefs.remove("token");
    loggedIn = false;
    Get.offAll(() => const LoginForm());
  }
}
