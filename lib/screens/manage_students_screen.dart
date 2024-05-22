import 'package:flutter/material.dart';
import 'package:hostel_management_project/widgets/add_student_overlay.dart';

import '../widgets/custom_container.dart';

class ManageStudentsScreen extends StatelessWidget {
  const ManageStudentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Students'),
        automaticallyImplyLeading: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (ctx) => const AddStudentOverlay());
              },
              child: CustomContainer(
                width: 200,
                height: 200,
                radiusValue: 12,
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/add-group.png',
                      height: 60,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text('Add Student'),
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
                      'assets/images/group.png',
                      height: 60,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text('Students List'),
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
