import 'package:get/get.dart';
import 'package:job_search_app_frontend/views/auth/login.dart';
import 'package:job_search_app_frontend/views/nav_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'common/export.dart';
import 'controllers/auth_notifier.dart';
import 'controllers/job_notifiier.dart';
import 'controllers/zoom_notifier.dart';

Widget defaultHome = const LoginForm();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final loggedIn = prefs.getBool('loggedIn') ?? false;
  if (loggedIn) {
    defaultHome = const NavigationScreen();
  }

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => AuthNotifier()),
    ChangeNotifierProvider(create: (context) => ZoomNotifier()),
    ChangeNotifierProvider(create: (context) => JobNotifier()),
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
          home: defaultHome,
        );
      },
    );
  }
}
