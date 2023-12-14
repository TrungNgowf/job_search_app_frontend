import 'package:get/get.dart';
import 'package:job_search_app_frontend/common/export.dart';
import 'package:job_search_app_frontend/models/request/profile_req.dart';

import '../models/response/profile_res.dart';
import '../services/profile_repository.dart';

class ProfileNotifier extends ChangeNotifier {
  Future<ProfileRes>? profile;

  updateProfile(Map<String, dynamic> formData, String? imageUrl) {
    Map<String, dynamic> data = Map.from(formData);
    data["experiences"] = [
      data["exp1"],
      data["exp2"] ?? "",
      data["exp3"] ?? ""
    ];
    data["skills"] = [
      data["skill1"],
      data["skill2"] ?? "",
      data["skill3"] ?? ""
    ];
    data["profilePic"] = imageUrl;
    data["dob"] = data["dob"].toString();
    ProfileReq profileReq = ProfileReq.fromJson(data);
    print(profileReq.toJson());
    ProfileRepository.updateProfile(profileReq).then((value) {
      if (value) {
        Get.snackbar("Cập nhật thông tin thành công",
            "Thông tin của ban đã được cập nhật",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white,
            icon: const Icon(
              Icons.check_circle_outline_rounded,
              color: Colors.white,
            ));
      } else {
        Get.snackbar("Cập nhật thông tin thất bại", "Có lỗi xảy ra!",
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

  getProfile() {
    profile = ProfileRepository.getProfile();
  }
}
