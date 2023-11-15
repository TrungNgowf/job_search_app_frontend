import 'package:job_search_app_frontend/common/export.dart';

import '../models/response/job_res.dart';
import '../services/job_repository.dart';

class JobNotifier extends ChangeNotifier {
  late Future<List<JobResponse>> jobsList;
  late Future<List<JobResponse>> recentJobs;

  getJobs() {
    jobsList = JobRepository().getJobs();
  }

  getRecent() {
    recentJobs = JobRepository().getJobs();
  }
}
