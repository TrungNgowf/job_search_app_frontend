import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:job_search_app_frontend/common/logo.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:job_search_app_frontend/controllers/auth_notifier.dart';
import 'package:job_search_app_frontend/models/request/login_req.dart';
import 'package:job_search_app_frontend/views/auth/register.dart';
import 'package:job_search_app_frontend/views/nav_screen.dart';
import 'package:provider/provider.dart';

import '../../common/export.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> with TickerProviderStateMixin {
  AuthNotifier authNotifier = AuthNotifier();
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  bool _isShowPassword = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthNotifier>(builder: (context, authNotifier, child) {
      authNotifier.getPrefs();
      return Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Animate(
                effects: [
                  MoveEffect(
                    curve: Curves.easeInOut,
                    delay: 0.ms,
                    duration: 600.ms,
                    begin: Offset(0, -50),
                    end: Offset(0, 0),
                  ),
                ],
                child: FormBuilder(
                  key: _fbKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Gap(10.h),
                      LogoText(
                        'Jobee',
                        size: 15.sp,
                      ),
                      ReusableText("Tìm kiếm công việc mơ ước"),
                      Gap(5.h),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: ReusableText(
                            "Đăng nhập!",
                            style: appStyle(size: 6, fw: FontWeight.w600),
                          )),
                      Gap(2.h),
                      FormBuilderTextField(
                        name: 'telephone',
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.numeric(),
                          FormBuilderValidators.maxLength(11),
                          FormBuilderValidators.minLength(9),
                        ]),
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                            labelText: 'Số điện thoại đăng nhập',
                            border: OutlineInputBorder()),
                      ),
                      Gap(2.h),
                      FormBuilderTextField(
                        name: 'password',
                        decoration: InputDecoration(
                            labelText: 'Mật khẩu',
                            border: const OutlineInputBorder(),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isShowPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isShowPassword = !_isShowPassword;
                                });
                              },
                            )),
                        obscureText: !_isShowPassword,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.minLength(6)
                        ]),
                      ),
                      Gap(1.h),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: ReusableText('Quên mật khẩu?',
                              style: appStyle(
                                  color: iosLightIndigo, fw: FontWeight.w600)),
                        ),
                      ),
                      Row(
                        children: [
                          ReusableText("Bạn chưa có tài khoản?"),
                          TextButton(
                            onPressed: () {
                              Get.to(() => const RegisterForm());
                            },
                            child: ReusableText('Đăng ký',
                                style: appStyle(
                                    color: iosLightIndigo,
                                    fw: FontWeight.w600)),
                          ),
                        ],
                      ),
                      Gap(5.h),
                      Container(
                        width: 60.w,
                        child: ElevatedButton(
                            onPressed: _handleLogin,
                            style: ElevatedButton.styleFrom(
                              elevation: 5,
                              backgroundColor: iosDefaultIndigo,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            child: ReusableText('Đăng nhập',
                                style: appStyle(size: 5, color: Colors.white))),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  void _handleLogin() {
    if (_fbKey.currentState!.saveAndValidate()) {
      String telephone = _fbKey.currentState!.fields['telephone']!.value;
      String password = _fbKey.currentState!.fields['password']!.value;
      LoginRequest loginRequest =
          LoginRequest(telephone: telephone, password: password);
      authNotifier.login(loginRequest);
    }
  }
}
