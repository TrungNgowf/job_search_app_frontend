import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:job_search_app_frontend/common/export.dart';
import 'package:job_search_app_frontend/models/response/job_res.dart';
import 'package:job_search_app_frontend/views/job/job_card.dart';
import 'package:provider/provider.dart';

import '../../controllers/job_notifiier.dart';
import 'job_page.dart';

class JobsList extends StatefulWidget {
  final bool? isRecent;

  const JobsList({super.key, this.isRecent});

  @override
  State<JobsList> createState() => _JobsListState();
}

class _JobsListState extends State<JobsList> {
  DateFormat dateFormat = DateFormat("dd.MM.yyyy");

  @override
  Widget build(BuildContext context) {
    var jobProvider = Provider.of<JobNotifier>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(7.h),
        child: CustomAppbar(
          title:
              widget.isRecent == true ? "Việc làm mới đăng" : "Việc làm gợi ý",
        ),
      ),
      body: FutureBuilder<List<JobResponse>>(
        future: widget.isRecent == true
            ? jobProvider.recentJobs
            : jobProvider.jobsList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else if (snapshot.data!.isEmpty) {
            return const Center(child: Text("Không có việc làm nào"));
          } else {
            final jobs = snapshot.data!;
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: ListView.builder(
                  itemCount: jobs.length,
                  itemBuilder: (context, i) {
                    return JobCard(job: jobs[i]);
                  }),
            );
          }
        },
      ),
    );
  }
}
