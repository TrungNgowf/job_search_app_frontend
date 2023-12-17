import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:job_search_app_frontend/common/export.dart';
import 'package:job_search_app_frontend/controllers/applied_jobs_notifier.dart';
import 'package:job_search_app_frontend/controllers/bookmark_notifier.dart';
import 'package:job_search_app_frontend/models/response/all_applied_jobs_res.dart';
import 'package:job_search_app_frontend/models/response/all_bookmarks_res.dart';
import 'package:job_search_app_frontend/models/response/job_res.dart';
import 'package:provider/provider.dart';

import '../../common/custom_navigator_appbar.dart';
import '../job/job_card.dart';
import '../job/job_page.dart';
import '../upload_cv/pdf_screen.dart';
import 'cv_from_network.dart';

class AppliedJobsPage extends StatefulWidget {
  const AppliedJobsPage({super.key});

  @override
  State<AppliedJobsPage> createState() => _AppliedJobsPageState();
}

class _AppliedJobsPageState extends State<AppliedJobsPage> {
  DateFormat dateFormat = DateFormat("dd.MM.yyyy");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(7.h),
        child: const NavigatorAppbar(
          title: 'Ứng tuyển',
        ),
      ),
      body: Consumer<AppliedJobsNotifier>(
        builder: (BuildContext context, AppliedJobsNotifier appliedJobsNotifier,
            Widget? child) {
          appliedJobsNotifier.getAppliedJobs();
          return FutureBuilder<List<AllAppliedJobResponse>>(
            future: appliedJobsNotifier.listAppliedJobs,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              } else if (snapshot.data!.isEmpty) {
                return const Center(child: Text("Chưa ứng tuyển việc làm nào"));
              } else {
                final appliedJobs = snapshot.data!;
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                  child: ListView.builder(
                      itemCount: appliedJobs.length,
                      itemBuilder: (context, i) {
                        return appliedJobsCard(
                            appliedJobs[i], appliedJobsNotifier);
                      }),
                );
              }
            },
          );
        },
      ),
    );
  }

  Widget appliedJobsCard(AllAppliedJobResponse appliedJobsRes,
      AppliedJobsNotifier appliedJobsNotifier) {
    JobResponse job = appliedJobsRes.job;
    return GestureDetector(
      onTap: () {
        Get.to(() => JobPage(job: job));
      },
      child: Card(
        elevation: 3,
        child: Slidable(
          startActionPane: ActionPane(
            motion: const DrawerMotion(),
            extentRatio: 0.4,
            children: [
              SlidableAction(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                borderRadius: BorderRadius.circular(5),
                onPressed: (context) {
                  Get.to(() => CVFromNetwork(pdfURL: appliedJobsRes.cvUrl));
                },
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
                icon: Icons.picture_as_pdf_rounded,
                label: 'Xem CV',
              ),
            ],
          ),
          endActionPane: ActionPane(
            motion: const DrawerMotion(),
            extentRatio: 0.4,
            children: [
              SlidableAction(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                borderRadius: BorderRadius.circular(5),
                onPressed: (context) {
                  appliedJobsNotifier.removeAppliedJob(appliedJobsRes.id);
                  setState(() {
                    appliedJobsNotifier.getAppliedJobs();
                  });
                },
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Xóa',
              ),
            ],
          ),
          child: Container(
            padding: EdgeInsets.all(2.w),
            height: 20.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: job.imageUrl == "" || job.imageUrl == null
                              ? Image.asset(defaultCompanyLogo)
                              : Image.network(job.imageUrl!)),
                      Expanded(
                          flex: 2,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ReusableText(
                                  job.title ?? '',
                                  style:
                                      appStyle(size: 4.2, fw: FontWeight.w600),
                                  maxLines: 2,
                                ),
                                ReusableText(job.company ?? ''),
                                ReusableText(
                                  "${job.location} (${job.contract})",
                                  style: appStyle(size: 3.8),
                                ),
                                ReusableText(
                                  '${job.salary}/${job.period}',
                                  style: appStyle(
                                      size: 3.8, color: iosLightIndigo),
                                ),
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Divider(
                      thickness: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ReusableText(
                          job.expiredDate!.difference(DateTime.now()).inDays +
                                      1 >
                                  0
                              ? "Còn ${job.expiredDate!.difference(DateTime.now()).inDays + 1} ngày"
                              : "Hết hạn",
                          style: appStyle(size: 3.5),
                        ),
                        ReusableText(
                          "Ngày đăng: ${dateFormat.format(job.createdAt!)}",
                          style: appStyle(size: 3.5),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
