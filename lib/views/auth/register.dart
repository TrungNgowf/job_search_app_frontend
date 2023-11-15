import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:job_search_app_frontend/common/logo.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../common/export.dart';
import '../../controllers/auth_notifier.dart';
import '../../models/request/register_req.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm>
    with TickerProviderStateMixin {
  AuthNotifier authNotifier = AuthNotifier();
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  bool _isShowPassword = false;
  bool _isShowRePassword = false;

  @override
  Widget build(BuildContext context) {
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
                    const ReusableText("Tìm kiếm công việc mơ ước"),
                    Gap(5.h),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: ReusableText(
                          "Đăng ký!",
                          style: appStyle(size: 6, fw: FontWeight.w600),
                        )),
                    Gap(2.h),
                    FormBuilderTextField(
                      name: 'username',
                      decoration: const InputDecoration(
                          labelText: 'Tên người dùng',
                          border: OutlineInputBorder()),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.minLength(6),
                      ]),
                    ),
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
                          labelText: 'Số điện thoại',
                          border: OutlineInputBorder()),
                    ),
                    Gap(2.h),
                    FormBuilderTextField(
                      name: 'email',
                      decoration: const InputDecoration(
                          labelText: 'Email', border: OutlineInputBorder()),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.email()
                      ]),
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
                    Gap(2.h),
                    FormBuilderTextField(
                      name: 're_password',
                      decoration: InputDecoration(
                          labelText: 'Nhập lại mật khẩu',
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isShowRePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _isShowRePassword = !_isShowRePassword;
                              });
                            },
                          )),
                      obscureText: !_isShowRePassword,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.equal(
                            _fbKey.currentState?.fields['password']?.value ??
                                "",
                            errorText: 'Mật khẩu không khớp')
                      ]),
                    ),
                    Gap(1.h),
                    Row(
                      children: [
                        const ReusableText("Bạn đã có tài khoản?"),
                        TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: ReusableText('Đăng nhập',
                              style: appStyle(
                                  color: iosLightIndigo, fw: FontWeight.w600)),
                        ),
                      ],
                    ),
                    Gap(3.h),
                    SizedBox(
                      width: 60.w,
                      child: ElevatedButton(
                          onPressed: _handleLogin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: const BorderSide(
                                  color: iosDefaultIndigo,
                                  width: 1,
                                  style: BorderStyle.solid),
                            ),
                          ),
                          child: ReusableText('Đăng ký',
                              style: appStyle(
                                  size: 5,
                                  color: iosDefaultIndigo,
                                  fw: FontWeight.w500))),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleLogin() {
    if (_fbKey.currentState!.saveAndValidate()) {
      String username = _fbKey.currentState!.fields['username']!.value;
      String telephone = _fbKey.currentState!.fields['telephone']!.value;
      String email = _fbKey.currentState!.fields['email']!.value;
      String password = _fbKey.currentState!.fields['password']!.value;
      RegisterRequest registerRequest = RegisterRequest(
          username: username,
          telephone: telephone,
          email: email,
          password: password);
      authNotifier.register(registerRequest);
    }
  }
}
