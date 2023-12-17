import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:job_search_app_frontend/common/export.dart';
import 'package:job_search_app_frontend/controllers/zoom_notifier.dart';
import 'package:job_search_app_frontend/views/drawer/drawer_screen.dart';
import 'package:job_search_app_frontend/views/profile/profile.dart';
import 'package:provider/provider.dart';

import 'applied_job/applied_jobs.dart';
import 'bookmark/bookmark.dart';
import 'chatting/chat_page.dart';
import 'home/home_page.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ZoomNotifier>(builder: (context, zoomNotifier, child) {
      return ZoomDrawer(
        menuScreen: DrawerScreen(
          indexSetter: (index) {
            zoomNotifier.currentIndex = index;
          },
        ),
        mainScreen: currentScreen(),
        borderRadius: 10,
        showShadow: true,
        angle: 0.0,
        slideWidth: 250,
        menuBackgroundColor: iosDefaultIndigo,
      );
    });
  }

  Widget currentScreen() {
    var zoomNotifier = Provider.of<ZoomNotifier>(context);
    switch (zoomNotifier.currentIndex) {
      case 0:
        return const HomePage();
      case 1:
        return const ChatPage();
      case 2:
        return const BookmarkPage();
      case 3:
        return const AppliedJobsPage();
      default:
        return const ProfilePage();
    }
  }
}
