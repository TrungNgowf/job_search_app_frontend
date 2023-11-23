import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:job_search_app_frontend/common/export.dart';
import 'package:job_search_app_frontend/models/response/job_res.dart';
import 'package:job_search_app_frontend/services/job_repository.dart';
import 'package:job_search_app_frontend/views/job/job_card.dart';

class JobSearch extends StatefulWidget {
  const JobSearch({super.key});

  @override
  State<JobSearch> createState() => _JobSearchState();
}

class _JobSearchState extends State<JobSearch> {
  final JobRepository jobRepository = JobRepository();
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(7.h),
        child: const CustomAppbar(
          title: "Tìm kiếm công việc",
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(2.w),
        child: Column(
          children: [
            _searchBar(),
            Gap(2.h),
            _searchController.text.isNotEmpty
                ? FutureBuilder<List<JobResponse>>(
                    future: jobRepository.searchJobs(_searchController.text),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Text("Error: ${snapshot.error}");
                      } else if (snapshot.data!.isEmpty) {
                        return Container(
                            margin: EdgeInsets.only(top: 30.h),
                            child: Center(
                                child: ReusableText(
                              "Không có việc làm nào",
                              style: appStyle(size: 5),
                            )));
                      } else {
                        final jobs = snapshot.data!;
                        return Expanded(
                          child: ListView.builder(
                              itemCount: jobs.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, i) {
                                return JobCard(job: jobs[i]);
                              }),
                        );
                      }
                    },
                  )
                : Container(
                    margin: EdgeInsets.only(top: 30.h),
                    child: Center(
                        child: ReusableText(
                      "Không có việc làm nào",
                      style: appStyle(size: 5),
                    )))
          ],
        ),
      ),
    );
  }

  Widget _searchBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Card(
            elevation: 3,
            child: Container(
              height: 6.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Gap(3.w),
                  GestureDetector(
                    onTap: () {
                      setState(() {});
                    },
                    child: const Icon(
                      Icons.search_outlined,
                      color: Colors.black,
                    ),
                  ),
                  Gap(3.w),
                  Expanded(
                    child: FormBuilderTextField(
                      name: "search",
                      controller: _searchController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Nhập từ khóa",
                      ),
                      onChanged: (val) {
                        setState(() {});
                      },
                    ),
                  )
                ],
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
}
