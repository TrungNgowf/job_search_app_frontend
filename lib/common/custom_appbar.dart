import 'package:get/get.dart';
import 'package:job_search_app_frontend/common/export.dart';

class CustomAppbar extends StatelessWidget {
  final String title;

  const CustomAppbar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: ReusableText(
        title,
        style: appStyle(size: 5.5, color: Colors.white, fw: FontWeight.w500),
      ),
      centerTitle: true,
      backgroundColor: iosDefaultIndigo,
      elevation: 5,
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.black,
        ),
      ),
      // actions: [
      //   IconButton(
      //     onPressed: () {},
      //     icon: const Icon(
      //       Icons.notifications,
      //       color: Colors.black,
      //     ),
      //   ),
      // ],
    );
  }
}
