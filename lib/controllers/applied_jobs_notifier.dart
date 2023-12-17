import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:job_search_app_frontend/common/export.dart';
import 'package:job_search_app_frontend/models/response/all_applied_jobs_res.dart';
import 'package:job_search_app_frontend/services/apply_cv_repository.dart';
import 'package:uuid/uuid.dart';

class AppliedJobsNotifier extends ChangeNotifier {
  Future<List<AllAppliedJobResponse>>? listAppliedJobs;

  getAppliedJobs() {
    listAppliedJobs = ApplyCVRepository.getAppliedJobs();
  }

  removeAppliedJob(String appliedJobId) {
    ApplyCVRepository.deleteAppliedJobs(appliedJobId).then((value) {
      if (value) {
        Get.snackbar('Thành công', 'Công việc đã được xóa khỏi danh sách',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white,
            icon: const Icon(
              Icons.check_circle_outline_rounded,
              color: Colors.white,
            ));
      } else {
        Get.snackbar("Thất bại", 'Xóa công việc thất bại',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            icon: const Icon(
              Icons.error_outline_rounded,
              color: Colors.white,
            ));
      }
    });
  }
}
