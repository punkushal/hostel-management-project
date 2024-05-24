import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hostel_management_project/controller/room_controller.dart';

import '../auth/controller/auth_controller.dart';
import 'custom_button.dart';

class AddStudentOverlay extends StatefulWidget {
  const AddStudentOverlay({super.key});

  @override
  State<AddStudentOverlay> createState() => _AddStudentOverlayState();
}

class _AddStudentOverlayState extends State<AddStudentOverlay> {
  final formKey = GlobalKey<FormState>();
  final authController = Get.put(AuthController());
  final roomController = Get.put(RoomController());

  @override
  void initState() {
    roomController.fetchRoomData(authController.auth.currentUser!.uid);
    super.initState();
  }

  void onAddingRoom() async {
    if (roomController.selectedRoom.value != null) {
      DocumentSnapshot roomDoc = await authController.database
          .collection('rooms')
          .doc(authController.auth.currentUser!.uid)
          .collection('added-rooms')
          .doc(roomController.selectedRoom.value)
          .get();
      int currentCapacity = int.parse(roomDoc['currentCapacity']);

      if (currentCapacity > 0) {
        currentCapacity--;
        await authController.database
            .collection('rooms')
            .doc(authController.auth.currentUser!.uid)
            .collection('added-rooms')
            .doc(roomController.selectedRoom.value)
            .update({'currentCapacity': currentCapacity.toString()});

        roomController.selectedRoom.value = null;

        Timer(
          const Duration(seconds: 2),
          () {
            Get.showSnackbar(
              const GetSnackBar(
                message: 'Room capacity is updated successfully',
                // animationDuration: Duration(seconds: 2),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 2),
              ),
            );
          },
        );
        Get.back(closeOverlays: true);
      }
    } else {
      Timer(const Duration(seconds: 2), () {
        Get.showSnackbar(
          const GetSnackBar(
            message: 'select the room number',
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red,
          ),
        );
      });
      Get.back(closeOverlays: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Add Student',
        textAlign: TextAlign.center,
      ),
      content: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //Input field for room number
                const Text('Room Number'),

                const SizedBox(
                  height: 8,
                ),

                Obx(
                  () => DropdownButton<String>(
                    value: roomController.selectedRoom.value,
                    // isExpanded: true,
                    items: roomController.roomNumbers.map((String room) {
                      return DropdownMenuItem<String>(
                          value: room, child: Text(room));
                    }).toList(),
                    onChanged: (String? room) {
                      roomController.selectedRoom.value = room;
                    },
                  ),
                ),

                const SizedBox(
                  height: 8,
                ),

                const SizedBox(
                  height: 8,
                ),

                //Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    Obx(
                      () => CustomButton(
                        width: 50,
                        height: 34,
                        onTap: onAddingRoom,
                        radiusValue: 8,
                        bgColor: Colors.green,
                        content: Center(
                          child: authController.isLoading.value == true
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  'Add',
                                  style: TextStyle(color: Colors.white),
                                ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
