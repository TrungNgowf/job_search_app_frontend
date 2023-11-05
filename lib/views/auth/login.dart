import 'package:job_search_app_frontend/common/export.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black,
        child: const Center(
          child: Text(
            'Login',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
            ),
          ),
        ));
  }
}
