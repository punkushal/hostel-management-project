import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hostel_management_project/auth/controller/auth_controller.dart';
import 'package:hostel_management_project/auth/controller/user_controller.dart';
import 'package:hostel_management_project/screens/warden_details_screen.dart';
import 'package:hostel_management_project/widgets/categories_list.dart';
import 'package:hostel_management_project/widgets/custom_container.dart';

class WardenHomeScreen extends StatefulWidget {
  const WardenHomeScreen({super.key});

  @override
  State<WardenHomeScreen> createState() => _WardenHomeScreenState();
}

class _WardenHomeScreenState extends State<WardenHomeScreen> {
  AuthController authController = Get.put(AuthController());
  final userController = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
          actions: [
            Obx(
              () => userController.isLoading.value
                  ? const CircularProgressIndicator()
                  : IconButton(
                      onPressed: () {
                        Get.to(() => const WardenDetailsScreen());
                      },
                      icon: userController.currentWarden != null
                          ? CircleAvatar(
                              radius: 20,
                              foregroundImage: CachedNetworkImageProvider(
                                userController.currentWarden!.profileImage,
                              ),
                            )
                          : const CircleAvatar(
                              radius: 20,
                            ),
                    ),
            ),
            const SizedBox(
              width: 8,
            )
          ],
        ),
        body: Obx(() => userController.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              )
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: CustomContainer(
                      width: mq.width * 0.9,
                      height: mq.height * 0.2,
                      radiusValue: 12,
                      content: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                userController.currentWarden != null
                                    ? Text(
                                        "Name : ${userController.currentWarden!.name}",
                                        style: const TextStyle(fontSize: 18),
                                      )
                                    : const CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                const SizedBox(
                                  height: 16,
                                ),
                                userController.currentWarden != null
                                    ? Text(
                                        "Hostel Name : ${userController.currentWarden!.hostelName}",
                                        style: const TextStyle(fontSize: 18))
                                    : const CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                              ],
                            ),
                            const SizedBox(
                              width: 18,
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                CupertinoIcons.calendar_badge_plus,
                                size: 44,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Expanded(child: CategoriesList())
                ],
              )));
  }
}
