import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageController extends GetxController {
  final Rx<File?> pickedImageFile = Rx<File?>(null);
  final Rx<File?> pickedHostelDocFile = Rx<File?>(null);
  XFile? imageFile;
  XFile? hostelDocImageFile;
  File? get pickedImage => pickedImageFile.value;
  File? get pickedHostelDocImage => pickedHostelDocFile.value;

  pickImageFromGallery() async {
    imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (imageFile != null) {
      final int imageSizeInBytes = await imageFile!.length();
      final double imageSizeInMB = imageSizeInBytes / (1024 * 1024);
      const double maxSizeInMB = 10;
      if (imageSizeInMB > maxSizeInMB) {
        Get.showSnackbar(const GetSnackBar(
          title: 'Image Size',
          message: "you're picked image file size greater than 10mb",
        ));
      }
      Get.snackbar("Profile Image", "you have successfully picked your image");
      pickedImageFile.value = File(imageFile!.path);
    }
  }

  pickImageFromCamera() async {
    imageFile = await ImagePicker().pickImage(source: ImageSource.camera);

    if (imageFile != null) {
      final int imageSizeInBytes = await imageFile!.length();
      final double imageSizeInMB = imageSizeInBytes / (1024 * 1024);
      const double maxSizeInMB = 10;
      if (imageSizeInMB > maxSizeInMB) {
        Get.showSnackbar(const GetSnackBar(
          title: 'Image Size',
          message: "you're picked image file size greater than 10mb",
        ));
      }
      Get.snackbar("Profile Image",
          "you have successfully picked your image using camera");
      pickedImageFile.value = File(imageFile!.path);
    }
  }

  //Hostel doc image picked from camera
  hostelDocImagePickedFromCamera() async {
    hostelDocImageFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (hostelDocImageFile != null) {
      final int imageSizeInBytes = await hostelDocImageFile!.length();
      final double imageSizeInMB = imageSizeInBytes / (1024 * 1024);
      const double maxSizeInMB = 10;
      if (imageSizeInMB > maxSizeInMB) {
        Get.showSnackbar(
          const GetSnackBar(
            title: 'Image Size',
            message: "you're document image file size greater than 10mb",
            backgroundColor: Colors.red,
            animationDuration: Duration(seconds: 3),
          ),
        );
      }
      Get.snackbar(
        "Profile Image",
        "Successfully picked hostel document image using camera",
        backgroundColor: Colors.green,
        animationDuration: const Duration(seconds: 3),
      );
      pickedHostelDocFile.value = File(hostelDocImageFile!.path);
    }
  }

  //hostel doc file image picked from gallery
  hostelDocImagePickedFromGallery() async {
    hostelDocImageFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (hostelDocImageFile != null) {
      final int imageSizeInBytes = await hostelDocImageFile!.length();
      final double imageSizeInMB = imageSizeInBytes / (1024 * 1024);
      const double maxSizeInMB = 10;
      if (imageSizeInMB > maxSizeInMB) {
        Get.showSnackbar(
          const GetSnackBar(
            title: 'Image Size',
            message: "you're document image file size greater than 10mb",
            backgroundColor: Colors.red,
            animationDuration: Duration(seconds: 3),
          ),
        );
      }
      Get.snackbar(
        "Profile Image",
        "Successfully picked hostel document image file using gallery",
        backgroundColor: Colors.green,
        animationDuration: const Duration(seconds: 3),
      );
      pickedHostelDocFile.value = File(hostelDocImageFile!.path);
    }
  }
}
