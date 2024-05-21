import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hostel_management_project/auth/controller/image_controller.dart';
import 'package:hostel_management_project/auth/models/warden.dart';
import 'package:hostel_management_project/screens/warden_home_screen.dart';

import '../screens/login_screen.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;
  //auth related functionality instantiated to auth variable
  final auth = FirebaseAuth.instance;

  //database related functionality instantiate to database variable
  final database = FirebaseFirestore.instance;

  ImageController imageController = Get.put(ImageController());

  //To register new warden
  registerNewWarden(Warden warden, String password) async {
    try {
      checkInternetConnection();

      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: warden.email, password: password);

      //url for profile image
      String urlOfProfileImage = await uploadImageFileToStorage(
          imageController.pickedImageFile.value!);

      //url for hostelDoc image
      String urlOfHostelDocImage = await uploadHostleDocFileToStorage(
          imageController.pickedHostelDocFile.value!);

      //Getting currently created user unique id
      String userId = userCredential.user!.uid;

      database.collection('hostel-wardens').doc(userId).set(Warden(
            name: warden.name,
            phoneNumber: warden.phoneNumber,
            role: warden.role,
            hostelName: warden.hostelName,
            email: warden.email,
            hostelLocation: warden.hostelLocation,
            profileImage: urlOfProfileImage,
            hostelDocumentImage: urlOfHostelDocImage,
            wardenId: userId,
          ).toMap());
      isLoading.value = false;
      imageController.pickedImageFile.value = null;
      imageController.pickedHostelDocFile.value = null;
      Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      if (e.code == 'weak-password') {
        Get.showSnackbar(
          const GetSnackBar(
            message: 'Weak Password',
            backgroundColor: Colors.redAccent,
            duration: Durations.short4,
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        Get.showSnackbar(
          GetSnackBar(
            message: e.code,
            backgroundColor: Colors.redAccent,
            duration: const Duration(seconds: 5),
          ),
        );
      }
    }
  }

  //for login
  signInUser(String email, String password) async {
    try {
      checkInternetConnection();

      await auth.signInWithEmailAndPassword(email: email, password: password);
      isLoading.value = false;
      Get.offAll(() => const WardenHomeScreen());
    } on FirebaseAuthException catch (e) {
      String message = 'An error occurred. Please try again.';
      isLoading.value = false;
      log(e.code);
      if (e.code == 'weak-password') {
        message = 'Weak Password.';
      } else if (e.code == 'user-not-found') {
        message = 'User not found.';
      } else if (e.code == 'email-already-in-use') {
        message = 'Account is already in use.';
      } else if (e.code == 'wrong-password') {
        message = 'You have entered wrong password.';
      } else if (e.code == 'invalid-email') {
        message = 'Please enter a valid email address.';
      } else if (e.code == 'user-disabled') {
        message = 'This user account has been disabled.';
      } else if (e.code == 'too-many-requests') {
        message = 'Too many login attempts. Please try again later.';
      } else if (e.code == 'operation-not-allowed') {
        message = 'This login method is not enabled.';
      } else if (e.code == 'invalid-credential') {
        message = 'You provided invalid credentials';
      }
      Get.showSnackbar(
        GetSnackBar(
          message: message,
          backgroundColor: Colors.redAccent,
          duration: const Duration(seconds: 3),
        ),
      );
    } catch (e) {
      log('An error');
    } //
  }

  checkInternetConnection() async {
    try {
      await InternetAddress.lookup('google.com');
    } catch (e) {
      isLoading.value = false;
      Get.showSnackbar(
        const GetSnackBar(
          message: 'No Internet Connection is detected!!',
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 4),
        ),
      );
    }
  }

//Uploading warden profile image file to the firebase storage
  Future<String> uploadImageFileToStorage(File imageFile) async {
    Reference reference = FirebaseStorage.instance
        .ref()
        .child('Profile Images')
        .child(auth.currentUser!.uid);
    UploadTask uploadTask = reference.putFile(imageFile);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrlOfImage = await snapshot.ref.getDownloadURL();
    return downloadUrlOfImage;
  }

  Future<String> uploadHostleDocFileToStorage(File imageFile) async {
    Reference reference = FirebaseStorage.instance
        .ref()
        .child('Hostel Ownership Certificate')
        .child(auth.currentUser!.uid);
    UploadTask uploadTask = reference.putFile(imageFile);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrlOfImage = await snapshot.ref.getDownloadURL();
    return downloadUrlOfImage;
  }
}
