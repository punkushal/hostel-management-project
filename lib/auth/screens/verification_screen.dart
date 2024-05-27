import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hostel_management_project/auth/controller/auth_controller.dart';
import 'package:hostel_management_project/main.dart';
import 'package:hostel_management_project/widgets/custom_button.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  AuthController authController = Get.put(AuthController());
  @override
  void initState() {
    super.initState();
    sendVerifyLink();
  }

  sendVerifyLink() async {
    final user = authController.auth.currentUser;
    await user!.sendEmailVerification().then(
          (value) => Get.snackbar(
              'Link Sent', 'A Link has been send to your email',
              margin: const EdgeInsets.all(30),
              snackPosition: SnackPosition.BOTTOM),
        );
  }

  reloadThisPage() async {
    await authController.auth.currentUser!.reload().then(
          (value) => Get.offAll(
            () => const MyApp(),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Your Email'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(48.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Open your mail and click on the verification link and reload this page',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 14,
            ),
            CustomButton(
              width: 120,
              height: 40,
              bgColor: Colors.green,
              onTap: reloadThisPage,
              radiusValue: 8,
              content: const Center(
                child: Text(
                  'Reload',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
