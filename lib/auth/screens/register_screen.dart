import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: CustomContainer(
                  bgColor: Color.fromARGB(189, 211, 201, 201),
                  radiusValue: 80,
                  content: Icon(
                    CupertinoIcons.person,
                    size: 160,
                  ),
                ),
              ),

              //Picking image from gallery or taking image from camera
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      CupertinoIcons.camera,
                      size: 28,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
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
                    ReusableTextField(
                      prefixIcon: const Icon(CupertinoIcons.lock_fill),
                      controller: passwordController,
                      labelText: 'Password',
                      obsecureText: true,
                      radiusValue: 12,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please provide your password';
                        } else if (value.length < 8) {
                          return 'Password must be at least 8 characters long';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 14,
                    ),

                    //Input field for confirm password
                    ReusableTextField(
                      prefixIcon: const Icon(CupertinoIcons.lock_fill),
                      controller: passwordController,
                      labelText: 'Confirm Password',
                      obsecureText: true,
                      radiusValue: 12,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please provide your password';
                        } else if (value != passwordController.text.trim()) {
                          return 'Password do not match';
                        }
                        return null;
                      },
                    ),
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
                    CustomContainer(
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
                                onPressed: () {},
                                icon: const Icon(
                                  CupertinoIcons.camera,
                                  size: 28,
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  CupertinoIcons.photo,
                                  size: 28,
                                ),
                              ),
                            ],
                          ),
                        ],
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
                      bgColor: Colors.green.shade400,
                      width: 180,
                      height: 40,
                      radiusValue: 8,
                      content: const Center(
                        child: Text(
                          'Register',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ),
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
