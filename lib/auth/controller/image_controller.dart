import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageController extends GetxController {
  final Rx<File?> pickedImageFile = Rx<File?>(null);
  XFile? imageFile;
  File? get pickedImage => pickedImageFile.value;

  pickImageFromGallery() async {
    imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (imageFile != null) {
      Get.snackbar("Profile Image", "you have successfully picked your image");
      pickedImageFile.value = File(imageFile!.path);
    }
  }

  pickImageFromCamera() async {
    imageFile = await ImagePicker().pickImage(source: ImageSource.camera);

    if (imageFile != null) {
      Get.snackbar("Profile Image",
          "you have successfully picked your image using camera");
      pickedImageFile.value = File(imageFile!.path);
    }
  }
}
