import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:job_search_app_frontend/common/export.dart';
import 'package:job_search_app_frontend/controllers/bookmark_notifier.dart';
import 'package:job_search_app_frontend/models/response/all_bookmarks_res.dart';
import 'package:job_search_app_frontend/models/response/job_res.dart';
import 'package:provider/provider.dart';

import '../../common/custom_navigator_appbar.dart';
import '../job/job_card.dart';
import '../job/job_page.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({super.key});

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  DateFormat dateFormat = DateFormat("dd.MM.yyyy");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(7.h),
        child: const NavigatorAppbar(
          title: 'Công việc đã lưu',
        ),
      ),
      body: Consumer<BookmarkNotifier>(
        builder: (BuildContext context, BookmarkNotifier bookmarkNotifier,
            Widget? child) {
          bookmarkNotifier.getBookmarks();
          return FutureBuilder<List<AllBookmarksRes>>(
            future: bookmarkNotifier.listBookmarks,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              } else if (snapshot.data!.isEmpty) {
                return const Center(child: Text("Chưa lưu việc làm nào"));
              } else {
                final bookmarks = snapshot.data!;
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: ListView.builder(
                      itemCount: bookmarks.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, i) {
                        return bookmarkCard(bookmarks[i], bookmarkNotifier);
                      }),
                );
              }
            },
          );
        },
      ),
    );
  }

  Widget bookmarkCard(
      AllBookmarksRes bookmarksRes, BookmarkNotifier bookmarkNotifier) {
    JobResponse job = bookmarksRes.job;
    return GestureDetector(
      onTap: () {
        Get.to(() => JobPage(job: job));
      },
      child: Card(
        elevation: 3,
        child: Slidable(
          endActionPane: ActionPane(
            motion: const DrawerMotion(),
            extentRatio: 0.4,
            children: [
              SlidableAction(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                borderRadius: BorderRadius.circular(5),
                onPressed: (context) {
                  bookmarkNotifier.removeBookmark(bookmarksRes.id);
                  setState(() {
                    bookmarkNotifier.getBookmarks();
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
