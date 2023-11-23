import 'package:get/get.dart';
import 'package:job_search_app_frontend/common/export.dart';
import 'package:job_search_app_frontend/models/response/all_bookmarks_res.dart';
import 'package:job_search_app_frontend/services/bookmarks_repository.dart';

class BookmarkNotifier extends ChangeNotifier {
  Future<List<AllBookmarksRes>>? listBookmarks;

  // Future<void> addJobs() async {
  //   listJobs = await BookmarksRepository.getBookmarks();
  //   notifyListeners();
  // }

  addBookmark(String jobId) {
    BookmarksRepository.addBookmark(jobId).then((response) {
      if (response[0]) {
        Get.snackbar('Thành công', 'Công việc đã được lưu thành công',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white,
            icon: const Icon(
              Icons.check_circle_outline_rounded,
              color: Colors.white,
            ));
      } else {
        Get.snackbar("Thất bại", response[1],
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

  getBookmarks() {
    listBookmarks = BookmarksRepository.getBookmarks();
  }

  removeBookmark(String bookmarkId) {
    BookmarksRepository.deleteBookmark(bookmarkId).then((value) {
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
