class Room {
  final String roomNumber;
  final String capacity;
  final String currentCapacity;
  final String floor;
  final String wardenId;
  Room(
    this.roomNumber,
    this.capacity,
    this.currentCapacity,
    this.floor,
    this.wardenId,
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'roomNumber': roomNumber,
      'capacity': capacity,
      'currentCapacity': currentCapacity,
      'floor': floor,
      'wardenId': wardenId,
    };
  }

  factory Room.fromMap(Map<String, dynamic> map) {
    return Room(
      map['roomNumber'] as String,
      map['capacity'] as String,
      map['currentCapacity'] as String,
      map['floor'] as String,
      map['wardenId'] as String,
    );
  }
}
