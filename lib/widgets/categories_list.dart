import 'package:flutter/material.dart';
import 'package:hostel_management_project/data/dummy_data.dart';
import 'package:hostel_management_project/screens/manage_screen.dart';
import 'package:hostel_management_project/widgets/card.dart';

import '../screens/all_issue_screen.dart';
import '../screens/change_request_screen.dart';
import '../screens/room_availability.dart';
import '../screens/staff_members_screen.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.count(
          crossAxisCount: 2,
          children: [
            ...categories.map(
              (category) => GestureDetector(
                onTap: () {
                  switch (category.title) {
                    case 'Rooms Availability':
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => const RoomAvailability(),
                        ),
                      );
                      break;
                    case 'All Issues':
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => const AllIssueScreen(),
                        ),
                      );
                      break;
                    case 'Staff Members':
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => const StaffMembersScreen(),
                        ),
                      );
                      break;
                    case 'Change Request':
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => const ChangeRequestScreen(),
                        ),
                      );
                      break;
                    // case 'Hostel Fees':
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (ctx) => const HostelFeesScreen(),
                    //     ),
                    //   );
                    //   break;
                    case 'Manage':
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => const ManageScreen(),
                        ),
                      );
                      break;
                  }
                },
                child: CardDesign(
                  content: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          category.image,
                          height: 64,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          category.title,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  elevation: 1,
                  radiusValue: 12,
                  color: Colors.white70,
                ),
              ),
            ),
          ],
        ));
  }
}
