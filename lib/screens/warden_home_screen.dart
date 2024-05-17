import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hostel_management_project/widgets/categories_list.dart';
import 'package:hostel_management_project/widgets/custom_container.dart';

class WardenHomeScreen extends StatefulWidget {
  const WardenHomeScreen({super.key});

  @override
  State<WardenHomeScreen> createState() => _WardenHomeScreenState();
}

class _WardenHomeScreenState extends State<WardenHomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: Column(
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
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Name",
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text("Hostel Name", style: TextStyle(fontSize: 18)),
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
      ),
    );
  }
}