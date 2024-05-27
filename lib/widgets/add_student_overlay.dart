import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hostel_management_project/auth/controller/password_controller.dart';
import 'package:hostel_management_project/auth/models/student.dart';
import 'package:hostel_management_project/controller/room_controller.dart';

import '../auth/controller/auth_controller.dart';
import 'custom_button.dart';
import 'reusable_text_field.dart';

class AddStudentOverlay extends StatefulWidget {
  const AddStudentOverlay({super.key});

  @override
  State<AddStudentOverlay> createState() => _AddStudentOverlayState();
}

class _AddStudentOverlayState extends State<AddStudentOverlay> {
  final formKey = GlobalKey<FormState>();
  final authController = Get.put(AuthController());
  final roomController = Get.put(RoomController());
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final fullNameController = TextEditingController();
  final parentNameController = TextEditingController();
  final phoneController = TextEditingController();
  final parentPhoneController = TextEditingController();
  PasswordController controller = Get.put(PasswordController());

  @override
  void dispose() {
    confirmPasswordController.dispose();
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    parentNameController.dispose();
    parentPhoneController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    roomController.fetchRoomData(authController.auth.currentUser!.uid);
    super.initState();
  }

  void onAddingStudent() async {
    if (formKey.currentState!.validate()) {
      if (roomController.selectedRoom.value != null) {
        Student student = Student(
            name: fullNameController.text.trim(),
            phoneNumber: phoneController.text.trim(),
            roomNumber: roomController.selectedRoom.value!,
            email: emailController.text.trim(),
            guardianName: parentNameController.text.trim(),
            guardianNumber: parentPhoneController.text.trim(),
            wardenId: "",
            studentId: "");
        DocumentSnapshot roomDoc = await authController.database
            .collection('rooms')
            .doc(authController.auth.currentUser!.uid)
            .collection('added-rooms')
            .doc(roomController.selectedRoom.value)
            .get();
        int currentCapacity = int.parse(roomDoc['currentCapacity']);

        currentCapacity--;
        await authController.database
            .collection('rooms')
            .doc(authController.auth.currentUser!.uid)
            .collection('added-rooms')
            .doc(roomController.selectedRoom.value)
            .update({'currentCapacity': currentCapacity.toString()});

        await authController.registerNewStudent(student);

        roomController.selectedRoom.value = null;

        Get.back(closeOverlays: true);
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
        // Get.back(closeOverlays: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Add Student',
        textAlign: TextAlign.center,
      ),
      content: Form(
        key: formKey,
        child: SingleChildScrollView(
          // clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            children: [
              //Input field for student's name
              ReusableTextField(
                prefixIcon: const Icon(CupertinoIcons.person),
                controller: fullNameController,
                labelText: 'Full Name',
                radiusValue: 12,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Provide student's full name";
                  } else if (value.length > 20) {
                    return 'Characters must be less than 20';
                  }
                  return null;
                },
                obsecureText: false,
              ),
              const SizedBox(
                height: 14,
              ),
              //Input field for student's email id

              ReusableTextField(
                prefixIcon: const Icon(CupertinoIcons.mail),
                controller: emailController,
                obsecureText: false,
                labelText: 'Email',
                keyboardType: TextInputType.emailAddress,
                radiusValue: 12,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Provide student's email id";
                  } else if (!RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+\.[a-zA-Z]+")
                      .hasMatch(value)) {
                    return 'Please enter a valid email address.';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 14,
              ),

              //Input field for student's password
              Obx(
                () => ReusableTextField(
                  prefixIcon: const Icon(CupertinoIcons.lock_fill),
                  controller: passwordController,
                  labelText: 'Password',
                  obsecureText: !controller.isPasswordVisible.value,
                  radiusValue: 12,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Provide student's passowrd";
                    } else if (value.length < 8) {
                      return 'Password must be at least 8 characters long';
                    }
                    return null;
                  },
                  suffixIcon: GestureDetector(
                    onTap: () {
                      controller.togglePasswordVisibility();
                    },
                    child: Icon(controller.isPasswordVisible.value
                        ? Icons.visibility
                        : Icons.visibility_off),
                  ),
                ),
              ),
              const SizedBox(
                height: 14,
              ),

              //Input field for student's confirm password

              Obx(() => ReusableTextField(
                    prefixIcon: const Icon(CupertinoIcons.lock_fill),
                    controller: confirmPasswordController,
                    labelText: 'Confirm Password',
                    obsecureText: !controller.isConfirmPasswordVisible.value,
                    radiusValue: 12,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Provide student's confirm passowrd";
                      } else if (value != passwordController.text.trim()) {
                        return 'Password do not match';
                      }
                      return null;
                    },
                    suffixIcon: GestureDetector(
                      onTap: () {
                        controller.toggleConfirmPasswordVisibility();
                      },
                      child: Icon(controller.isConfirmPasswordVisible.value
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                  )),
              const SizedBox(
                height: 14,
              ),

              //Input field for student's phone number
              ReusableTextField(
                keyboardType: TextInputType.phone,
                prefixIcon: const Icon(CupertinoIcons.phone),
                controller: phoneController,
                labelText: 'Phone number',
                radiusValue: 12,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Provide student's phonen number";
                  } else if (value.length > 10) {
                    return 'Phone number must be 10 digits';
                  }
                  return null;
                },
                obsecureText: false,
              ),

              const SizedBox(
                height: 14,
              ),

              //Input field for student's Guardian full name
              ReusableTextField(
                prefixIcon: const Icon(CupertinoIcons.person),
                controller: parentNameController,
                labelText: "Gaurdian's full name",
                radiusValue: 12,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Provide student's parent name";
                  } else if (value.length > 20) {
                    return 'Characters must be less than 20';
                  }
                  return null;
                },
                obsecureText: false,
              ),
              const SizedBox(
                height: 14,
              ),
              //Input field for student's Guardian's phone number
              ReusableTextField(
                keyboardType: TextInputType.phone,
                prefixIcon: const Icon(CupertinoIcons.phone),
                controller: parentPhoneController,
                labelText: 'Phone number',
                radiusValue: 12,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please provide your parent's phone number";
                  } else if (value.length > 10) {
                    return 'Phone number must be 10 digits';
                  }
                  return null;
                },
                obsecureText: false,
              ),

              const SizedBox(
                height: 14,
              ),
              //for room's dropdown button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text('Select Room Number'),
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
                ],
              ),

              const SizedBox(
                height: 8,
              ),

              //Student's Adding button

              Obx(
                () => CustomButton(
                  width: 150,
                  height: 34,
                  onTap: onAddingStudent,
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
          ),
        ),
      ),
    );
  }
}
