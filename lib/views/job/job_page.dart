import 'dart:io';
import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:job_search_app_frontend/common/custom_button.dart';
import 'package:job_search_app_frontend/common/export.dart';
import 'package:job_search_app_frontend/controllers/bookmark_notifier.dart';
import 'package:job_search_app_frontend/controllers/cv_notifier.dart';
import 'package:job_search_app_frontend/models/response/job_res.dart';
import 'package:job_search_app_frontend/views/upload_cv/cv_info.dart';
import 'package:job_search_app_frontend/views/upload_cv/pdf_screen.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../common/custom_appbar.dart';

class JobPage extends StatefulWidget {
  final JobResponse job;

  const JobPage({super.key, required this.job});

  @override
  State<JobPage> createState() => _JobPageState();
}

class _JobPageState extends State<JobPage> {
  var uuid = const Uuid();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(7.h),
        child: CustomAppbar(
          title: widget.job.company ?? "Chi tiết công việc",
          trailing: [
            Padding(
              padding: EdgeInsets.only(right: 4.w),
              child: Consumer<BookmarkNotifier>(
                builder: (BuildContext context, BookmarkNotifier value,
                    Widget? child) {
                  return GestureDetector(
                    onTap: () {
                      value.addBookmark(widget.job.id!);
                    },
                    child: const Icon(
                      Icons.bookmark_border_rounded,
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            child: Container(
              height: 75.h,
              padding: EdgeInsets.all(3.w),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.network(
                      widget.job.imageUrl ?? defaultCompanyLogo,
                      width: 30.w,
                    ),
                    Gap(0.5.h),
                    ReusableText(
                      widget.job.title!,
                      style: appStyle(size: 5.5, fw: FontWeight.w700),
                    ),
                    Gap(0.5.h),
                    ReusableText(
                      widget.job.location!,
                      style: appStyle(size: 4.5),
                    ),
                    Gap(0.5.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(2.w),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.blueGrey.shade100),
                          child: ReusableText(widget.job.contract!),
                        ),
                        Gap(5.w),
                        ReusableText(
                            "${widget.job.salary}/${widget.job.period}")
                      ],
                    ),
                    Gap(5.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ReusableText(
                        "Giới thiệu",
                        style: appStyle(size: 5, fw: FontWeight.w600),
                      ),
                    ),
                    ReusableText(widget.job.description!),
                    Gap(3.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ReusableText(
                        "Yêu cầu",
                        style: appStyle(size: 5, fw: FontWeight.w600),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: widget.job.requirements!
                            .map((item) => ReusableText(item))
                            .toList(),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          CustomButton(
            width: 50.w,
            backGroundColor: iosLightIndigo,
            onTap: () => showDialog(
                context: context,
                builder: (context) {
                  return uploadCVDialog();
                }),
            child: ReusableText(
              "Ứng tuyển ngay",
              style:
                  appStyle(size: 4, color: Colors.white, fw: FontWeight.w500),
            ),
          )
        ],
      ),
    );
  }

  AlertDialog uploadCVDialog() {
    Provider.of<CVNotifier>(context, listen: false).init();
    return AlertDialog(
      title: ReusableText(
        "Thêm CV để ứng tuyển",
        style: appStyle(size: 5, fw: FontWeight.w600),
      ),
      content: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Consumer<CVNotifier>(
              builder:
                  (BuildContext context, CVNotifier cvNotifier, Widget? child) {
                if (cvNotifier.pdfName == null) {
                  return GestureDetector(
                    onTap: () {
                      cvNotifier.uploadCV();
                    },
                    child: DottedBorder(
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(5),
                        color: Colors.green,
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 2.h),
                        child:
                            const ReusableText("Nhấn vào đây\nđể tải lên CV")),
                  );
                } else {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          cvNotifier.uploadCV();
                        },
                        child: DottedBorder(
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(5),
                            color: Colors.green,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 2.h),
                            child: ReusableText(cvNotifier.pdfName!)),
                      ),
                      Gap(2.w),
                      CustomButton(
                        height: 5.h,
                        width: 10.w,
                        backGroundColor: Colors.green,
                        onTap: () {
                          Get.to(() => PDFScreen(
                              path: cvNotifier.pdfPath!,
                              name: cvNotifier.pdfName!));
                        },
                        child: ReusableText(
                          "Xem trước CV",
                          style: appStyle(color: Colors.white),
                        ),
                      )
                    ],
                  );
                }
              },
            ),
            Gap(1.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ReusableText("Chưa có CV? "),
                Consumer<CVNotifier>(
                  builder:
                      (BuildContext context, CVNotifier value, Widget? child) {
                    return TextButton(
                      style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          alignment: Alignment.center),
                      onPressed: () async {
                        var cvPath = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CVInfo()));
                        value.setPdfName(cvPath[0]);
                        value.setPdfPath(cvPath[1]);
                      },
                      child: ReusableText(
                        "Tạo CV ngay",
                        style: TextStyle(
                            color: iosDefaultIndigo,
                            fontSize: 4.5.sp,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                            decorationColor: iosDefaultIndigo),
                      ),
                    );
                  },
                )
              ],
            ),
          ],
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: [
        CustomButton(
          width: 50.w,
          backGroundColor: iosDefaultIndigo,
          onTap: () {
            Get.back();
          },
          child: ReusableText(
            "Đóng",
            style:
                appStyle(size: 4.5, color: Colors.white, fw: FontWeight.w500),
          ),
        ),
        Consumer<CVNotifier>(
            builder: (BuildContext context, CVNotifier value, Widget? child) {
          if (value.pdfPath == null) {
            return CustomButton(
              width: 50.w,
              backGroundColor: Colors.grey.shade300,
              onTap: null,
              child: ReusableText(
                "Xác nhận",
                style: appStyle(
                    size: 4.5, color: Colors.white, fw: FontWeight.w500),
              ),
            );
          } else {
            return CustomButton(
              width: 50.w,
              backGroundColor: Colors.white,
              onTap: () async {
                await value.applyJob(widget.job.id!, value.pdfPath!);
                Get.back();
              },
              child: ReusableText(
                "Xác nhận",
                style: appStyle(
                    size: 4.5, color: iosDefaultIndigo, fw: FontWeight.w500),
              ),
            );
          }
        })
      ],
    );
  }
}
