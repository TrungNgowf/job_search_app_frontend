import 'package:job_search_app_frontend/common/custom_button.dart';
import 'package:job_search_app_frontend/common/export.dart';
import 'package:job_search_app_frontend/controllers/bookmark_notifier.dart';
import 'package:job_search_app_frontend/models/response/job_res.dart';
import 'package:provider/provider.dart';

import '../../common/custom_appbar.dart';

class JobPage extends StatefulWidget {
  final JobResponse job;

  const JobPage({super.key, required this.job});

  @override
  State<JobPage> createState() => _JobPageState();
}

class _JobPageState extends State<JobPage> {
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
}
