import 'package:get/get.dart';
import 'package:job_search_app_frontend/common/export.dart';

import '../views/drawer/drawer_icon.dart';

class NavigatorAppbar extends StatelessWidget {
  final String title;
  final Widget? trailing;

  const NavigatorAppbar({super.key, required this.title, this.trailing});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: ReusableText(
        title,
        style: appStyle(size: 5.5, color: Colors.black, fw: FontWeight.w500),
      ),
      centerTitle: true,
      leading: const DrawerIcon(),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: trailing ??
              const Icon(Icons.notifications_none_outlined,
                  color: Colors.black, size: 30),
        ),
      ],
    );
  }
}
