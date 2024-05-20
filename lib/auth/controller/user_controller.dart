import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hostel_management_project/auth/controller/auth_controller.dart';
import 'package:hostel_management_project/auth/models/warden.dart';

class UserController extends GetxController {
  AuthController authController = Get.put(AuthController());
  RxBool isLoading = true.obs;
  Warden? currentWarden;

  @override
  void onInit() {
    fetchCurrentWardenData();
    super.onInit();
  }

  void setUser(Warden warden) {
    currentWarden = warden;
    log(currentWarden!.name);
    update();
  }

  fetchCurrentWardenData() async {
    String wardenId = authController.auth.currentUser!.uid;
    DocumentSnapshot wardenDoc = await authController.database
        .collection('hostel-wardens')
        .doc(wardenId)
        .get();

    Map<String, dynamic> wardenData = wardenDoc.data() as Map<String, dynamic>;
    Warden warden = Warden.fromMap(wardenData);

    setUser(warden);
    isLoading.value = false;
  }
}
