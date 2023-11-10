import 'package:get/get.dart';
import 'package:job_search_app_frontend/views/auth/login.dart';
import 'package:provider/provider.dart';
import 'common/export.dart';
import 'controllers/auth_notifier.dart';
import 'controllers/zoom_notifier.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => AuthNotifier()),
    ChangeNotifierProvider(create: (context) => ZoomNotifier()),
  ], child: const MyApp()));
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
            fontFamily: GoogleFonts.getFont('Montserrat').fontFamily,
            useMaterial3: true,
          ),
          home: const LoginForm(),
        );
      },
    );
  }
}
