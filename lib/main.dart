import 'package:get/get.dart';
import 'package:job_search_app_frontend/views/auth/login.dart';
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
          title: 'Jobee - A Job Search App',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: iosDefaultIndigo),
            fontFamily: GoogleFonts.getFont('Fira Sans').fontFamily,
            useMaterial3: true,
          ),
          home: const LoginForm(),
        );
      },
    );
  }
}
