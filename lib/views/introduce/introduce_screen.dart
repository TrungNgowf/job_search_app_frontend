import 'package:get/get.dart';
import 'package:job_search_app_frontend/common/export.dart';
import 'package:job_search_app_frontend/views/auth/Login.dart';

class IntroduceScreen extends StatelessWidget {
  const IntroduceScreen({super.key});

  @override
  initState() {
    Future.delayed(const Duration(seconds: 2), () {
      Get.to(() => Login());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Jobey',
              style: TextStyle(
                  color: iosDefaultIndigo,
                  fontSize: 20.sp,
                  fontFamily: GoogleFonts.getFont('Baumans').fontFamily,
                  fontWeight: FontWeight.bold)),
          ReusableText(
            "A Job Search App",
            style: appStyle(4, iosDarkIndigo, FontWeight.normal),
          ),
          SizedBox(
            height: 5.h,
          ),
        ],
      )),
    );
  }
}
