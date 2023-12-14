import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:job_search_app_frontend/common/export.dart';
import 'package:uuid/uuid.dart';

class ImageUploader extends ChangeNotifier {
  var uuid = const Uuid();
  final ImagePicker _picker = ImagePicker();

  String? imageUrl;
  String? imagePath;
  List<String> imageList = [];

  void pickImage() async {
    XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    pickedFile = await cropImage(pickedFile!);
    if (pickedFile != null) {
      imagePath = pickedFile.path;
      imageList.add(imagePath!);
      imageUpload(pickedFile);
      notifyListeners();
    } else {
      print('No image selected.');
    }
  }

  Future<XFile?> cropImage(XFile imageFile) async {
    CroppedFile? croppedFile = await ImageCropper.platform.cropImage(
        sourcePath: imageFile.path,
        maxWidth: 1024,
        maxHeight: 1024,
        compressQuality: 70,
        cropStyle: CropStyle.rectangle,
        aspectRatioPresets: [
          CropAspectRatioPreset.ratio5x4
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Crop Image',
              toolbarColor: iosDefaultIndigo,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.ratio5x4,
              lockAspectRatio: true),
          IOSUiSettings(
              title: 'Crop Image',
              aspectRatioLockEnabled: true,
              aspectRatioPickerButtonHidden: true,
              resetAspectRatioEnabled: false,
              rotateButtonsHidden: true,
              rotateClockwiseButtonHidden: true)
        ]);
    if (croppedFile != null) {
      notifyListeners();
      return XFile(croppedFile.path);
    } else {
      print('No image selected.');
      return null;
    }
  }

  Future<String?> imageUpload(XFile imageFile) async {
    File file = File(imageFile.path);
    final ref =
        FirebaseStorage.instance.ref().child('jobee').child("${uuid.v1()}.jpg");
    await ref.putFile(file);
    imageUrl = await ref.getDownloadURL();
    return imageUrl;
  }
}
