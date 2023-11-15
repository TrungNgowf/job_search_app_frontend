import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:job_search_app_frontend/common/custom_button.dart';
import 'package:job_search_app_frontend/common/export.dart';
import 'package:job_search_app_frontend/controllers/auth_notifier.dart';
import 'package:provider/provider.dart';

import '../../controllers/zoom_notifier.dart';
import '../auth/login.dart';

class DrawerScreen extends StatefulWidget {
  final ValueSetter indexSetter;

  const DrawerScreen({super.key, required this.indexSetter});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  AuthNotifier _authNotifier = AuthNotifier();

  @override
  Widget build(BuildContext context) {
    return Consumer<ZoomNotifier>(
      builder: (context, zoomNotifier, child) {
        return GestureDetector(
          onDoubleTap: () {
            ZoomDrawer.of(context)!.toggle();
          },
          child: Scaffold(
            backgroundColor: iosDefaultIndigo,
            body: Container(
              margin: EdgeInsets.only(left: 5.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  OutlinedButton(onPressed: null, child: ReusableText("Jobee")),
                  Gap(10.h),
                  drawerItems(
                      AntDesign.home,
                      "Trang chủ",
                      0,
                      zoomNotifier.currentIndex == 0
                          ? Colors.white
                          : Colors.white.withOpacity(0.5)),
                  drawerItems(
                      Ionicons.chatbubble_ellipses_outline,
                      "Nhắn tin",
                      1,
                      zoomNotifier.currentIndex == 1
                          ? Colors.white
                          : Colors.white.withOpacity(0.5)),
                  drawerItems(
                      Fontisto.bookmark,
                      "Lưu trữ",
                      2,
                      zoomNotifier.currentIndex == 2
                          ? Colors.white
                          : Colors.white.withOpacity(0.5)),
                  drawerItems(
                      Icons.developer_mode,
                      "Cài đặt thiết bị",
                      3,
                      zoomNotifier.currentIndex == 3
                          ? Colors.white
                          : Colors.white.withOpacity(0.5)),
                  drawerItems(
                      Icons.account_circle_outlined,
                      "Tài khoản",
                      4,
                      zoomNotifier.currentIndex == 4
                          ? Colors.white
                          : Colors.white.withOpacity(0.5)),
                  Gap(15.h),
                  GestureDetector(
                    onTap: () {
                      _authNotifier.logout();
                      Get.offAll(() => const LoginForm());
                    },
                    child: CustomButton(
                      backGroundColor: Colors.red,
                      child: ReusableText(
                        "Đăng xuất",
                        style: appStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget drawerItems(IconData icon, String text, int index, Color color) {
    return GestureDetector(
      onTap: () {
        widget.indexSetter(index);
        ZoomDrawer.of(context)?.close();
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 5.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Icon(
              icon,
              color: color,
            ),
            Gap(3.w),
            ReusableText(
              text,
              style: appStyle(color: color, size: 4.2, fw: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
