import 'package:get/get.dart';
import 'package:job_search_app_frontend/views/introduce/introduce_screen.dart';
import 'common/export.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: const Size(100, 100),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Jobey - A Job Search App',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: iosDefaultIndigo),
            useMaterial3: true,
          ),
          home: const IntroduceScreen(),
        );
      },
    );
  }
}
