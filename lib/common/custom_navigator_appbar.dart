import 'package:get/get.dart';
import 'package:job_search_app_frontend/common/export.dart';

import '../views/drawer/drawer_icon.dart';

class NavigatorAppbar extends StatelessWidget {
  final String title;


  const NavigatorAppbar(
      {super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: ReusableText(
        title,
        style: appStyle(size: 5.5, color: Colors.black, fw: FontWeight.w500),
      ),
      centerTitle: true,
      leading: DrawerIcon(),
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 15),
          child: Icon(Icons.notifications_none_outlined,
              color: Colors.black, size: 30),
        ),
      ],
    );
  }
}
