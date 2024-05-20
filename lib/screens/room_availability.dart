import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hostel_management_project/auth/controller/auth_controller.dart';
import 'package:hostel_management_project/models/room.dart';
import 'package:hostel_management_project/widgets/card.dart';

class RoomAvailability extends StatefulWidget {
  const RoomAvailability({
    super.key,
  });

  @override
  State<RoomAvailability> createState() => _RoomAvailabilityState();
}

class _RoomAvailabilityState extends State<RoomAvailability> {
  final authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: StreamBuilder(
          stream: authController.database.collection('rooms').snapshots(),
          builder: (ctx, snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }
            List<Room> rooms = snapshot.data!.docs
                .map((doc) => Room.fromFirestore(doc))
                .toList();
            return ListView.builder(
              itemCount: rooms.length,
              itemBuilder: (context, index) {
                Room room = rooms[index];
                return CardDesign(
                  color: Colors.white,
                  radiusValue: 12,
                  elevation: 1,
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      //This column for displaying bed image and room number
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Room Number : ${room.roomNumber}',
                          ),
                          Image.asset(
                            'assets/images/bed.png',
                            height: 120,
                            width: 100,
                          )
                        ],
                      ),

                      const SizedBox(
                        width: 18,
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Capacity : ${room.capacity}',
                            style: const TextStyle(fontSize: 18),
                          ),
                          Text(
                            'Current Capacity : ${room.currentCapacity}',
                            style: const TextStyle(fontSize: 18),
                          ),
                          Text(
                            'Floor : ${room.floor}',
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            );
          }),
    );
  }
}
