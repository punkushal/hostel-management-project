import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hostel_management_project/auth/controller/auth_controller.dart';

class RoomController extends GetxController {
  AuthController authController = Get.put(AuthController());
  RxList<String> roomNumbers = <String>[].obs;
  Rx<String?> selectedRoom = Rx<String?>(null);

  Future<List<String>> fetchRoomNumbers(String wardenId) async {
    try {
      QuerySnapshot snapshot = await authController.database
          .collection('rooms')
          .doc(wardenId)
          .collection('added-rooms')
          .where('wardenId', isEqualTo: wardenId)
          .get();
      List<String> roomNumbers = [];
      for (var doc in snapshot.docs) {
        int currentCapcity = int.parse(doc.get('currentCapacity'));
        int capacity = int.parse(doc.get('capacity'));
        if (currentCapcity <= capacity && currentCapcity != 0) {
          roomNumbers.add(doc.get('roomNumber') as String);
        }
      }
      return roomNumbers;
    } catch (e) {
      log('Error fetching room numbers : $e');
      rethrow;
    }
  }

  void fetchRoomData(String wardenId) async {
    try {
      List<String> rooms = await fetchRoomNumbers(wardenId);
      roomNumbers.assignAll(rooms);
    } catch (e) {
      log('Error fetching room data : $e');
    }
  }
}
