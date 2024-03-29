import 'package:get/get.dart';
import 'package:job_search_app_frontend/common/export.dart';

class CustomAppbar extends StatelessWidget {
  final String title;
  final Widget? leading;
  final List<Widget>? trailing;

  const CustomAppbar(
      {super.key, required this.title, this.leading, this.trailing});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: ReusableText(
        title,
        style: appStyle(size: 4.8, color: Colors.black, fw: FontWeight.w500),
      ),
      centerTitle: true,
      leading: leading ??
          IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            ),
          ),
      actions: trailing ?? [],
    );
  }
}
