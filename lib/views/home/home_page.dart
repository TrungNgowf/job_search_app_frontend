import 'package:job_search_app_frontend/common/export.dart';

import '../../common/custom_appbar.dart';
import '../../common/custom_navigator_appbar.dart';
import '../drawer/drawer_icon.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(7.h),
        child: const NavigatorAppbar(
          title: 'Trang chủ',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, children: [

          ]),
        ),
      ),
    );
  }
}
