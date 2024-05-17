import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hostel_management_project/auth/screens/register_screen.dart';
import 'package:hostel_management_project/widgets/reusable_text_field.dart';

import '../../widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 32),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/hostel.png',
                fit: BoxFit.cover,
                height: 180,
                width: 200,
              ),
              const SizedBox(
                height: 14,
              ),
              const Text(
                'Login to the hostel',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.green),
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
                height: 8,
              ),

              //for forget password
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'forget password',
                    style: TextStyle(color: Colors.green),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),

              //Login button
              CustomButton(
                bgColor: Colors.green.shade400,
                width: 180,
                height: 40,
                radiusValue: 8,
                content: const Center(
                  child: Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ),

              const SizedBox(
                height: 24,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account ? ",
                    style: TextStyle(fontSize: 16),
                  ),

                  //Navigate to register screen
                  GestureDetector(
                      onTap: () {
                        Get.offAll(
                          () => const RegisterScreen(),
                        );
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(color: Colors.green, fontSize: 16),
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
