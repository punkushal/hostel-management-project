import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hostel_management_project/auth/controller/auth_controller.dart';
import 'package:hostel_management_project/models/room.dart';
import 'package:hostel_management_project/widgets/custom_button.dart';
import 'package:hostel_management_project/widgets/reusable_text_field.dart';

class AddRoomOverLay extends StatefulWidget {
  const AddRoomOverLay({super.key});

  @override
  State<AddRoomOverLay> createState() => _AddRoomOverLayState();
}

class _AddRoomOverLayState extends State<AddRoomOverLay> {
  final capacityController = TextEditingController();
  final floorController = TextEditingController();
  final roomNumberController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final authController = Get.put(AuthController());
  @override
  void dispose() {
    roomNumberController.dispose();
    floorController.dispose();
    capacityController.dispose();
    super.dispose();
  }

  Future<bool> checkRoomExists(String roomNumber) async {
    QuerySnapshot query = await authController.database
        .collection('rooms')
        .where('roomNumber', isEqualTo: roomNumber)
        .get();
    return query.docs.isNotEmpty;
  }

  void onAddingRooms(Room room) async {
    final isValid = formKey.currentState!.validate();

    if (isValid) {
      authController.isLoading.value = true;
      bool roomExists = await checkRoomExists(room.roomNumber);
      if (!roomExists) {
        await authController.database.collection('rooms').add(Room(
                room.roomNumber,
                room.capacity,
                room.currentCapacity,
                room.floor,
                room.wardenId)
            .toMap());

        authController.isLoading.value = false;

        Timer(const Duration(seconds: 3), () {
          Get.showSnackbar(
            const GetSnackBar(
              message: "Successfully room added",
              duration: Duration(seconds: 3),
              backgroundColor: Colors.green,
            ),
          );
        });
        // Get.closeAllSnackbars();

        Get.back(
          closeOverlays: true,
        );
      } else {
        authController.isLoading.value = false;
        // Display the message if the room already exists

        Timer(const Duration(seconds: 1), () {
          Get.showSnackbar(
            const GetSnackBar(
              message: "Room number is already existed",
              duration: Duration(seconds: 2),
              backgroundColor: Colors.red,
            ),
          );
        });

        Get.back(closeOverlays: true);
        // Get.closeAllSnackbars();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Add Room',
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
                ReusableTextField(
                  controller: roomNumberController,
                  keyboardType: TextInputType.number,
                  radiusValue: 12,
                  labelText: 'Room Number',
                  obsecureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Provide room number";
                    } else if (value.length > 4) {
                      return "Numbers should be within four digits";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),

                //Input field for capacity
                ReusableTextField(
                  controller: capacityController,
                  keyboardType: TextInputType.number,
                  radiusValue: 12,
                  labelText: 'Capacity',
                  obsecureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Provide room capacity";
                    } else if (value.length > 1) {
                      return "Number should be single digit";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),

                //Input field for floor
                ReusableTextField(
                  controller: floorController,
                  radiusValue: 12,
                  labelText: 'Floor',
                  obsecureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Provide floor to this room";
                    } else if (value.length > 20) {
                      return "Floor name length should be with 20 characters";
                    }
                    return null;
                  },
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
                    Obx(() => CustomButton(
                          width: 50,
                          height: 34,
                          onTap: () {
                            Room room = Room(
                              roomNumberController.text.trim(),
                              capacityController.text.trim(),
                              0.toString(),
                              floorController.text.trim(),
                              authController.auth.currentUser!.uid,
                            );
                            onAddingRooms(room);
                          },
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
                        )),
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
