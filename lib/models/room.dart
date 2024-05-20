import 'package:cloud_firestore/cloud_firestore.dart';

class Room {
  final String roomNumber;
  final String capacity;
  final String currentCapacity;
  final String floor;
  final String wardenId;
  Room({
    required this.roomNumber,
    required this.capacity,
    required this.currentCapacity,
    required this.floor,
    required this.wardenId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'roomNumber': roomNumber,
      'capacity': capacity,
      'currentCapacity': currentCapacity,
      'floor': floor,
      'wardenId': wardenId,
    };
  }

  factory Room.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Room(
        roomNumber: data['roomNumber'],
        capacity: data['capacity'],
        currentCapacity: data['currentCapacity'],
        floor: data['floor'],
        wardenId: data['wardenId']);
  }

  factory Room.fromMap(Map<String, dynamic> map) {
    return Room(
      roomNumber: map['roomNumber'] as String,
      capacity: map['capacity'] as String,
      currentCapacity: map['currentCapacity'] as String,
      floor: map['floor'] as String,
      wardenId: map['wardenId'] as String,
    );
  }
}
