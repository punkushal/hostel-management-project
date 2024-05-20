import 'package:flutter/material.dart';
import 'package:hostel_management_project/widgets/add_room_overlay.dart';
import 'package:hostel_management_project/widgets/custom_container.dart';
import 'package:get/get.dart';

class ManageScreen extends StatelessWidget {
  const ManageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: GestureDetector(
              onTap: () {
                showDialog(
                    context: context, builder: (ctx) => const AddRoomOverLay());
              },
              child: CustomContainer(
                width: 200,
                height: 200,
                radiusValue: 12,
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/door.png',
                      height: 60,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text('Add Rooms'),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Center(
            child: GestureDetector(
              onTap: () {},
              child: CustomContainer(
                width: 200,
                height: 200,
                radiusValue: 12,
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/student.png',
                      height: 60,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text('Manage Students'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
