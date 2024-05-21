import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hostel_management_project/auth/controller/auth_controller.dart';
import 'package:hostel_management_project/models/room.dart';
import 'package:hostel_management_project/widgets/card.dart';
import 'package:hostel_management_project/widgets/custom_container.dart';

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
          stream: authController.database
              .collection('rooms')
              .where('wardenId',
                  isEqualTo: authController.auth.currentUser!.uid)
              .snapshots(),
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
                bool isRoomAvailable = int.parse(room.currentCapacity) <=
                        int.parse(room.capacity) &&
                    int.parse(room.currentCapacity) != 0;
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  child: CardDesign(
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
                            CustomContainer(
                              height: 26,
                              width: 80,
                              bgColor:
                                  isRoomAvailable ? Colors.green : Colors.red,
                              radiusValue: 8,
                              content: Center(
                                child: Text(
                                  isRoomAvailable
                                      ? "Available"
                                      : "Not Available",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}
