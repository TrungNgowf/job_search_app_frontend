import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:job_search_app_frontend/common/export.dart';

import '../../models/response/job_res.dart';
import 'job_page.dart';

class JobCard extends StatelessWidget {
  final JobResponse job;

  const JobCard({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat("dd.MM.yyyy");

    return GestureDetector(
      onTap: () {
        Get.to(() => JobPage(job: job));
      },
      child: Card(
        elevation: 3,
        child: Container(
          padding: EdgeInsets.all(2.w),
          width: 80.w,
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
                                style: appStyle(size: 4.2, fw: FontWeight.w600),
                                maxLines: 2,
                              ),
                              ReusableText(job.company ?? ''),
                              ReusableText(
                                "${job.location} (${job.contract})",
                                style: appStyle(size: 3.8),
                              ),
                              ReusableText(
                                '${job.salary}/${job.period}',
                                style:
                                    appStyle(size: 3.8, color: iosLightIndigo),
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
                        job.expiredDate!.difference(DateTime.now()).inDays + 1 >
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
    );
  }
}
