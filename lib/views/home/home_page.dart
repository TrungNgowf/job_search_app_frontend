import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:job_search_app_frontend/common/export.dart';
import 'package:job_search_app_frontend/controllers/job_notifiier.dart';
import 'package:job_search_app_frontend/models/response/job_res.dart';
import 'package:job_search_app_frontend/views/job/job_card.dart';
import 'package:job_search_app_frontend/views/job/job_page.dart';
import 'package:job_search_app_frontend/views/job/jobs_list.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:intl/intl.dart';
import '../../common/custom_appbar.dart';
import '../../common/custom_navigator_appbar.dart';
import '../job/jobs_search.dart';
import '../video_player/video_player_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateFormat dateFormat = DateFormat("dd.MM.yyyy");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(7.h),
          child: const NavigatorAppbar(
            title: 'Trang chủ',
          ),
        ),
        body: Consumer<JobNotifier>(
          builder:
              (BuildContext context, JobNotifier jobNotifier, Widget? child) {
            jobNotifier.getJobs();
            jobNotifier.getRecent();
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _searchBar(),
                      Gap(2.h),
                      _someTipsBar(),
                      Gap(3.h),
                      _recommendationJobsBar(jobNotifier),
                      Gap(3.h),
                      _recentJobsBar(jobNotifier)
                    ]),
              ),
            );
          },
        ));
  }

  Widget _someTipsBar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ReusableText(
              "Một vài mẹo cho bạn",
              style: appStyle(fw: FontWeight.w600),
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => const VideoPlayersScreen());
              },
              child: ReusableText(
                "Xem thêm",
                style: appStyle(size: 3.5, color: iosLightIndigo),
              ),
            )
          ],
        ),
        Gap(0.5.h),
        GestureDetector(
          onTap: () {
            Get.to(() => const VideoPlayersScreen());
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              "assets/images/home_banner.jpg",
              filterQuality: FilterQuality.high,
            ),
          ),
        ),
      ],
    );
  }

  Widget _searchBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Card(
            elevation: 3,
            child: GestureDetector(
              onTap: () {
                Get.to(() => const JobSearch());
              },
              child: Container(
                height: 6.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Gap(3.w),
                    const Icon(
                      Icons.search_outlined,
                      color: Colors.black,
                    ),
                    Gap(3.w),
                    const ReusableText(
                      'Bạn muốn tìm việc?',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Gap(1.w),
        Card(
          elevation: 3,
          child: Container(
            height: 6.h,
            width: 6.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Icon(
                AntDesign.filter,
                color: Colors.black,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _recommendationJobsBar(JobNotifier jobNotifier) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ReusableText(
              "Việc làm gợi ý cho bạn",
              style: appStyle(fw: FontWeight.w600),
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => const JobsList());
              },
              child: ReusableText(
                "Xem thêm",
                style: appStyle(size: 3.5, color: iosLightIndigo),
              ),
            )
          ],
        ),
        Gap(0.5.h),
        FutureBuilder(
            future: jobNotifier.jobsList,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Shimmer.fromColors(
                  baseColor: Colors.blueGrey.shade100,
                  highlightColor: Colors.white,
                  period: const Duration(milliseconds: 2500),
                  child: Container(
                    height: 20.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                );
              } else {
                List<JobResponse> recommendationJobs = snapshot.data!;
                recommendationJobs
                    .sort((a, b) => a.expiredDate!.compareTo(b.expiredDate!));
                return Container(
                  height: 20.h,
                  child: ListView.builder(
                      itemCount: recommendationJobs.length < 10
                          ? recommendationJobs.length
                          : 10,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final job = recommendationJobs[index];
                        return JobCard(job: job);
                      }),
                );
              }
            })
      ],
    );
  }

  Widget _recentJobsBar(JobNotifier jobNotifier) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ReusableText(
              "Việc làm mới",
              style: appStyle(fw: FontWeight.w600),
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => const JobsList(isRecent: true));
              },
              child: ReusableText(
                "Xem thêm",
                style: appStyle(size: 3.5, color: iosLightIndigo),
              ),
            )
          ],
        ),
        Gap(0.5.h),
        FutureBuilder(
            future: jobNotifier.recentJobs,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Shimmer.fromColors(
                  baseColor: Colors.blueGrey.shade100,
                  highlightColor: Colors.white,
                  period: const Duration(milliseconds: 2500),
                  child: Container(
                    height: 20.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                );
              } else {
                List<JobResponse> recentJobs = snapshot.data!;
                recentJobs.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
                return Container(
                  height: 20.h,
                  child: ListView.builder(
                      itemCount:
                          recentJobs.length < 10 ? recentJobs.length : 10,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final job = recentJobs[index];
                        return JobCard(job: job);
                      }),
                );
              }
            })
      ],
    );
  }
}
