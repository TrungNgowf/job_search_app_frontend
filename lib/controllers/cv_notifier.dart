import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:job_search_app_frontend/common/export.dart';
import 'package:uuid/uuid.dart';

class CVNotifier extends ChangeNotifier {
  var uuid = const Uuid();
  String? pdfName;
  String? cvURL;
  String? pdfPath;

  init() {
    pdfName = null;
    cvURL = null;
    pdfPath = null;
  }

  setPdfName(String? name) {
    pdfName = name;
    notifyListeners();
  }

  setPdfPath(String? path) {
    pdfPath = path;
    notifyListeners();
  }

  void uploadCV() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      File? fileBytes = File(result.files.first.path!);
      pdfName = result.files.first.name;
      pdfPath = result.files.first.path;
      // final ref = FirebaseStorage.instance
      //     .ref()
      //     .child('jobee')
      //     .child('upload_cv')
      //     .child("cv_${uuid.v1()}.pdf");
      // await ref.putFile(fileBytes);
      // cvURL = await ref.getDownloadURL();
      notifyListeners();
    }
  }
}
