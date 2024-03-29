import 'dart:io';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:job_search_app_frontend/common/custom_navigator_appbar.dart';
import 'package:job_search_app_frontend/common/export.dart';
import 'package:job_search_app_frontend/controllers/image_uploader.dart';
import 'package:job_search_app_frontend/controllers/profile_notifier.dart';
import 'package:job_search_app_frontend/models/request/profile_req.dart';
import 'package:provider/provider.dart';

import '../../models/response/profile_res.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfileState();
}

class _ProfileState extends State<ProfilePage> {
  final ProfileNotifier _profileNotifier = ProfileNotifier();
  final GlobalKey<FormBuilderState> _pro5Key = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(7.h),
        child: NavigatorAppbar(
          title: "Thông tin cá nhân",
          trailing: Consumer<ImageUploader>(
            builder: (BuildContext context, ImageUploader imageUploader,
                Widget? child) {
              return GestureDetector(
                onTap: () {
                  if (_pro5Key.currentState!.saveAndValidate()) {
                    _profileNotifier.updateProfile(
                        _pro5Key.currentState!.value, imageUploader.imageUrl);
                  } else {
                    print('validation failed');
                  }
                },
                child: const Icon(Icons.save),
              );
            },
          ),
        ),
      ),
      body: Consumer<ProfileNotifier>(
        builder: (BuildContext context, ProfileNotifier profileNotifier,
            Widget? child) {
          profileNotifier.getProfile();
          Provider.of<ImageUploader>(context, listen: false).imageList.clear();
          return FutureBuilder<ProfileRes>(
              future: profileNotifier.profile,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text("Có lỗi xảy ra"),
                  );
                } else {
                  final profile = snapshot.data;
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    child: SingleChildScrollView(
                      child: FormBuilder(
                        key: _pro5Key,
                        initialValue: {
                          'username': profile!.username,
                          'telephone': profile.telephone,
                          'email': profile.email,
                          'dob': profile.dob,
                          'address': profile.address ?? "",
                          'portfolio': profile.portfolio ?? "",
                          'education': profile.education ?? "",
                          'major': profile.major ?? "",
                          'degree': profile.degree ?? "",
                          'careerGoals': profile.careerGoals ?? "",
                          'exp1': (profile.experiences == null ||
                                  profile.experiences!.isEmpty)
                              ? ""
                              : profile.experiences![0] ?? "",
                          'exp2': (profile.experiences == null ||
                                  profile.experiences!.isEmpty)
                              ? ""
                              : profile.experiences![1] ?? "",
                          'exp3': (profile.experiences == null ||
                                  profile.experiences!.isEmpty)
                              ? ""
                              : profile.experiences![2] ?? "",
                          'skill1': (profile.skills == null ||
                                  profile.skills!.isEmpty)
                              ? ""
                              : profile.skills![0] ?? "",
                          'skill2': (profile.skills == null ||
                                  profile.skills!.isEmpty)
                              ? ""
                              : profile.skills![1] ?? "",
                          'skill3': (profile.skills == null ||
                                  profile.skills!.isEmpty)
                              ? ""
                              : profile.skills![2] ?? "",
                          'additionInfo': profile.additionInfo ?? "",
                        },
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Gap(3.h),
                              Consumer<ImageUploader>(
                                builder: (BuildContext context,
                                    ImageUploader imageUploader,
                                    Widget? child) {
                                  if (imageUploader.imageList.isNotEmpty) {
                                    return GestureDetector(
                                      onTap: () {
                                        imageUploader.imageList.clear();
                                        imageUploader.pickImage();
                                      },
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: CircleAvatar(
                                          radius: 15.w,
                                          backgroundColor: iosDefaultIndigo,
                                          backgroundImage: FileImage(File(
                                              imageUploader.imageList.first)),
                                        ),
                                      ),
                                    );
                                  } else if (profile.profilePic != null &&
                                      profile.profilePic!.isNotEmpty) {
                                    return GestureDetector(
                                      onTap: () {
                                        imageUploader.imageList.clear();
                                        imageUploader.pickImage();
                                      },
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: CircleAvatar(
                                          radius: 15.w,
                                          backgroundColor: iosDefaultIndigo,
                                          backgroundImage:
                                              NetworkImage(profile.profilePic!),
                                        ),
                                      ),
                                    );
                                  } else {
                                    return GestureDetector(
                                      onTap: () {
                                        imageUploader.imageList.clear();
                                        imageUploader.pickImage();
                                      },
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: CircleAvatar(
                                          radius: 15.w,
                                          backgroundColor: iosDefaultIndigo,
                                          child: Center(
                                              child: Icon(
                                            Icons.photo_filter_rounded,
                                            size: 18.w,
                                            color: Colors.white,
                                          )),
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                              Gap(2.h),
                              ReusableText(
                                "Thông tin cơ bản",
                                style: appStyle(size: 5, fw: FontWeight.w600),
                              ),
                              Gap(1.h),
                              FormBuilderTextField(
                                name: 'username',
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(),
                                ]),
                                decoration: const InputDecoration(
                                    labelText: 'Họ và tên',
                                    contentPadding: EdgeInsets.all(10),
                                    border: OutlineInputBorder()),
                              ),
                              Gap(1.h),
                              FormBuilderTextField(
                                name: 'telephone',
                                readOnly: true,
                                decoration: const InputDecoration(
                                    labelText: 'Số điện thoại',
                                    contentPadding: EdgeInsets.all(10),
                                    border: OutlineInputBorder()),
                              ),
                              Gap(1.h),
                              FormBuilderTextField(
                                name: 'email',
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(),
                                ]),
                                decoration: const InputDecoration(
                                    labelText: 'Email',
                                    contentPadding: EdgeInsets.all(10),
                                    border: OutlineInputBorder()),
                              ),
                              Gap(1.h),
                              FormBuilderDateTimePicker(
                                name: 'dob',
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(),
                                ]),
                                inputType: InputType.date,
                                format: DateFormat('dd-MM-yyyy'),
                                decoration: const InputDecoration(
                                    labelText: 'Sinh nhật',
                                    contentPadding: EdgeInsets.all(10),
                                    border: OutlineInputBorder()),
                              ),
                              Gap(1.h),
                              FormBuilderTextField(
                                name: 'address',
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(),
                                ]),
                                decoration: const InputDecoration(
                                    labelText: 'Địa chỉ',
                                    contentPadding: EdgeInsets.all(10),
                                    border: OutlineInputBorder()),
                              ),
                              Gap(1.h),
                              FormBuilderTextField(
                                name: 'portfolio',
                                decoration: const InputDecoration(
                                    labelText: 'Link Portfolio',
                                    contentPadding: EdgeInsets.all(10),
                                    border: OutlineInputBorder()),
                              ),
                              Gap(2.h),
                              ReusableText(
                                "Học vấn",
                                style: appStyle(size: 5, fw: FontWeight.w600),
                              ),
                              Gap(1.h),
                              FormBuilderTextField(
                                name: 'education',
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(),
                                ]),
                                decoration: const InputDecoration(
                                    labelText: 'Trình độ',
                                    contentPadding: EdgeInsets.all(10),
                                    border: OutlineInputBorder()),
                              ),
                              Gap(1.h),
                              FormBuilderTextField(
                                name: 'major',
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(),
                                ]),
                                decoration: const InputDecoration(
                                    labelText: 'Chuyên ngành',
                                    contentPadding: EdgeInsets.all(10),
                                    border: OutlineInputBorder()),
                              ),
                              Gap(1.h),
                              FormBuilderTextField(
                                name: 'degree',
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(),
                                ]),
                                decoration: const InputDecoration(
                                    labelText: 'Bằng cấp',
                                    contentPadding: EdgeInsets.all(10),
                                    border: OutlineInputBorder()),
                              ),
                              Gap(2.h),
                              ReusableText(
                                "Mục tiêu nghề nghiệp",
                                style: appStyle(size: 5, fw: FontWeight.w600),
                              ),
                              Gap(1.h),
                              FormBuilderTextField(
                                name: 'careerGoals',
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(),
                                ]),
                                decoration: const InputDecoration(
                                    labelText: 'Mục tiêu',
                                    contentPadding: EdgeInsets.all(10),
                                    border: OutlineInputBorder()),
                              ),
                              Gap(2.h),
                              ReusableText(
                                "Kinh nghiệm làm việc",
                                style: appStyle(size: 5, fw: FontWeight.w600),
                              ),
                              Gap(1.h),
                              FormBuilderTextField(
                                name: 'exp1',
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(),
                                ]),
                                decoration: const InputDecoration(
                                    labelText: 'Kinh nghiệm 1',
                                    contentPadding: EdgeInsets.all(10),
                                    border: OutlineInputBorder()),
                              ),
                              Gap(1.h),
                              FormBuilderTextField(
                                name: 'exp2',
                                decoration: const InputDecoration(
                                    labelText: 'Kinh nghiệm 2 (Nếu có))',
                                    contentPadding: EdgeInsets.all(10),
                                    border: OutlineInputBorder()),
                              ),
                              Gap(1.h),
                              FormBuilderTextField(
                                name: 'exp3',
                                decoration: const InputDecoration(
                                    labelText: 'Kinh nghiệm 3 (Nếu có)',
                                    contentPadding: EdgeInsets.all(10),
                                    border: OutlineInputBorder()),
                              ),
                              Gap(2.h),
                              ReusableText(
                                "Kỹ năng",
                                style: appStyle(size: 5, fw: FontWeight.w600),
                              ),
                              Gap(1.h),
                              FormBuilderTextField(
                                name: 'skill1',
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(),
                                ]),
                                decoration: const InputDecoration(
                                    labelText: 'Kỹ năng 1',
                                    contentPadding: EdgeInsets.all(10),
                                    border: OutlineInputBorder()),
                              ),
                              Gap(1.h),
                              FormBuilderTextField(
                                name: 'skill2',
                                decoration: const InputDecoration(
                                    labelText: 'Kỹ năng 2 (Nếu có))',
                                    contentPadding: EdgeInsets.all(10),
                                    border: OutlineInputBorder()),
                              ),
                              Gap(1.h),
                              FormBuilderTextField(
                                name: 'skill3',
                                decoration: const InputDecoration(
                                    labelText: 'Kỹ năng 3 (Nếu có)',
                                    contentPadding: EdgeInsets.all(10),
                                    border: OutlineInputBorder()),
                              ),
                              Gap(2.h),
                              ReusableText(
                                "Thông tin thêm",
                                style: appStyle(size: 5, fw: FontWeight.w600),
                              ),
                              Gap(1.h),
                              FormBuilderTextField(
                                name: 'additionInfo',
                                decoration: const InputDecoration(
                                    labelText: 'Thông tin thêm',
                                    contentPadding: EdgeInsets.all(10),
                                    border: OutlineInputBorder()),
                              ),
                              Gap(2.h)
                            ]),
                      ),
                    ),
                  );
                }
              });
        },
      ),
    );
  }
}
