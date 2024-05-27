import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hostel_management_project/auth/controller/user_controller.dart';
import 'package:hostel_management_project/auth/screens/login_screen.dart';
import 'package:hostel_management_project/widgets/custom_button.dart';

class WardenDetailsScreen extends StatefulWidget {
  const WardenDetailsScreen({super.key});

  @override
  State<WardenDetailsScreen> createState() => _WardenDetailsScreenState();
}

class _WardenDetailsScreenState extends State<WardenDetailsScreen> {
  final userController = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: Column(
        children: [
          Center(
              child: Obx(
            () => userController.isLoading.value
                ? const CupertinoActivityIndicator(
                    color: Colors.blue,
                    radius: 90,
                  )
                : CircleAvatar(
                    radius: 90,
                    backgroundColor: Colors.grey,
                    backgroundImage: NetworkImage(
                        userController.currentWarden!.profileImage),
                  ),
          )),
          const SizedBox(
            height: 8,
          ),
          Obx(
            () => userController.isLoading.value
                ? const CircularProgressIndicator()
                : Text(userController.currentWarden!.name),
          ),
          const SizedBox(
            height: 18,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 9),
                  child: Text(
                    'Email',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                  ),
                ),
                ListTile(
                    leading: const Icon(CupertinoIcons.mail),
                    title: Obx(
                      () => userController.isLoading.value
                          ? const CircularProgressIndicator()
                          : Text(userController.currentWarden!.email),
                    )),
                const Divider(),
                const SizedBox(
                  height: 14,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 9),
                  child: Text(
                    'Phone number',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                  ),
                ),
                ListTile(
                    leading: const Icon(CupertinoIcons.phone),
                    title: Obx(
                      () => userController.isLoading.value
                          ? const CircularProgressIndicator()
                          : Text(userController.currentWarden!.phoneNumber),
                    )),
                const Divider(),
                const SizedBox(
                  height: 12,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 9),
                  child: Text(
                    'Address ',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                  ),
                ),
                ListTile(
                    leading: const Icon(CupertinoIcons.location_solid),
                    title: Obx(
                      () => userController.isLoading.value
                          ? const CircularProgressIndicator(
                              backgroundColor: Colors.blue,
                            )
                          : Text(userController.currentWarden!.hostelLocation),
                    )),
                const Divider(),
                const SizedBox(
                  height: 28,
                ),
                Center(
                  child: CustomButton(
                    height: 28,
                    width: 66,
                    bgColor: Colors.green,
                    onTap: () async {
                      try {
                        userController.authController.checkInternetConnection();
                        await userController.authController.auth.signOut();
                        Get.offAll(() => const LoginScreen());
                      } catch (e) {
                        Get.showSnackbar(
                          const GetSnackBar(
                            message: 'No internet Connection',
                            backgroundColor: Colors.redAccent,
                            duration: Duration(seconds: 3),
                          ),
                        );
                      }
                    },
                    radiusValue: 8,
                    content: const Center(
                      child: Text(
                        'Log out',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
