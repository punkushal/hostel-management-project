import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hostel_management_project/auth/controller/auth_controller.dart';
import 'package:hostel_management_project/auth/controller/image_controller.dart';
import 'package:hostel_management_project/auth/controller/password_controller.dart';
import 'package:hostel_management_project/auth/models/warden.dart';
import 'package:hostel_management_project/auth/screens/login_screen.dart';
import 'package:hostel_management_project/widgets/custom_button.dart';
import 'package:hostel_management_project/widgets/custom_container.dart';
import 'package:hostel_management_project/widgets/reusable_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirlmPasswordController = TextEditingController();
  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final hostelNameController = TextEditingController();
  final hostelLocationController = TextEditingController();
  AuthController authController = Get.put(AuthController());
  ImageController imageController = Get.put(ImageController());
  PasswordController controller = Get.put(PasswordController());

  void onRegisteringWarden() async {
    final isValid = formKey.currentState!.validate();
    if (imageController.pickedImage == null ||
        imageController.pickedHostelDocImage == null) {
      if (imageController.pickedImage == null) {
        Get.showSnackbar(GetSnackBar(
          message: 'Please select your image profile',
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.red.shade300,
        ));
      } else if (imageController.pickedHostelDocImage == null) {
        Get.showSnackbar(GetSnackBar(
          message: 'Please upload your hostel document',
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.red.shade300,
        ));
      }
    } else if (isValid) {
      authController.isLoading.value = true;
      Warden warden = Warden(
        name: fullNameController.text.trim(),
        phoneNumber: phoneController.text.trim(),
        role: 'warden',
        hostelName: hostelNameController.text.trim(),
        email: emailController.text.trim(),
        hostelLocation: hostelLocationController.text.trim(),
        profileImage: '',
        hostelDocumentImage: '',
        wardenId: '',
      );

      await authController.registerNewWarden(
          warden, passwordController.text.trim());
    }
  }

  @override
  void dispose() {
    confirlmPasswordController.dispose();
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    hostelLocationController.dispose();
    hostelNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              //Input field for image uploading
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Obx(
                  () => imageController.pickedImageFile.value == null
                      ? const CustomContainer(
                          bgColor: Color.fromARGB(189, 211, 201, 201),
                          radiusValue: 80,
                          content: Icon(
                            CupertinoIcons.person,
                            size: 160,
                          ),
                        )
                      : CircleAvatar(
                          radius: 80,
                          backgroundImage:
                              FileImage(imageController.pickedImage!),
                        ),
                ),
              ),

              //Picking image from gallery or taking image from camera
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () async {
                      await imageController.pickImageFromCamera();
                    },
                    icon: const Icon(
                      CupertinoIcons.camera,
                      size: 28,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      await imageController.pickImageFromGallery();
                    },
                    icon: const Icon(
                      CupertinoIcons.photo,
                      size: 28,
                    ),
                  ),
                ],
              ),

              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                child: Column(
                  children: [
                    //Input field for full name
                    ReusableTextField(
                      prefixIcon: const Icon(CupertinoIcons.person),
                      controller: fullNameController,
                      labelText: 'Full Name',
                      radiusValue: 12,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please provide your name';
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
                    //Input field for email address
                    ReusableTextField(
                      prefixIcon: const Icon(CupertinoIcons.mail),
                      controller: emailController,
                      obsecureText: false,
                      labelText: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      radiusValue: 12,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please provide your email';
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

                    //Input field for password
                    Obx(
                      () => ReusableTextField(
                        prefixIcon: const Icon(CupertinoIcons.lock_fill),
                        controller: passwordController,
                        labelText: 'Password',
                        obsecureText: !controller.isPasswordVisible.value,
                        radiusValue: 12,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please provide your password';
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

                    //Input field for confirm password
                    Obx(() => ReusableTextField(
                          prefixIcon: const Icon(CupertinoIcons.lock_fill),
                          controller: confirlmPasswordController,
                          labelText: 'Confirm Password',
                          obsecureText: !controller.isPasswordVisible.value,
                          radiusValue: 12,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please provide your password';
                            } else if (value !=
                                passwordController.text.trim()) {
                              return 'Password do not match';
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
                        )),
                    const SizedBox(
                      height: 14,
                    ),
                    //Input field for hostel name
                    ReusableTextField(
                      prefixIcon: const Icon(CupertinoIcons.house),
                      controller: hostelNameController,
                      labelText: 'Hostel Name',
                      radiusValue: 12,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please provide your hostel name';
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
                    //Input field for hostel location
                    ReusableTextField(
                      prefixIcon: const Icon(CupertinoIcons.location_solid),
                      controller: hostelLocationController,
                      labelText: 'Hostel Location',
                      radiusValue: 12,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please provide your hostel location';
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

                    //Input field for hostel owner varification by image uploading
                    Obx(
                      () => imageController.pickedHostelDocImage == null
                          ? CustomContainer(
                              height: 160,
                              radiusValue: 12,
                              content: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('Hostel Ownership Certificate'),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        onPressed: () async {
                                          await imageController
                                              .hostelDocImagePickedFromCamera();
                                        },
                                        icon: const Icon(
                                          CupertinoIcons.camera,
                                          size: 28,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () async {
                                          await imageController
                                              .hostelDocImagePickedFromGallery();
                                        },
                                        icon: const Icon(
                                          CupertinoIcons.photo,
                                          size: 28,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          : Container(
                              width: 180,
                              height: 180,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: FileImage(File(imageController
                                          .hostelDocImageFile!.path)))),
                            ),
                    ),

                    const SizedBox(
                      height: 14,
                    ),
                    //Input field for phone number

                    ReusableTextField(
                      keyboardType: TextInputType.phone,
                      prefixIcon: const Icon(CupertinoIcons.phone),
                      controller: phoneController,
                      labelText: 'Phone number',
                      radiusValue: 12,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please provide your phone number';
                        } else if (value.length > 10) {
                          return 'Phone number must be 10 digits';
                        }
                        return null;
                      },
                      obsecureText: false,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //Register button
                    CustomButton(
                        onTap: onRegisteringWarden,
                        bgColor: Colors.green.shade400,
                        width: 180,
                        height: 40,
                        radiusValue: 8,
                        content: Obx(
                          () => Center(
                            child: authController.isLoading.value == true
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text(
                                    'Register',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                          ),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account ? ",
                          style: TextStyle(fontSize: 16),
                        ),

                        //Navigate to login screen
                        GestureDetector(
                          onTap: () {
                            Get.offAll(
                              () => const LoginScreen(),
                            );
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(color: Colors.green, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
