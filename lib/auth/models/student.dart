class Student {
  final String name;
  final String phoneNumber;
  final String roomNumber;
  final String email;
  final String guardianName;
  final String guardianNumber;
  final String wardenId;

  final String studentId;

  Student(
      {required this.name,
      required this.phoneNumber,
      required this.roomNumber,
      required this.email,
      required this.guardianName,
      required this.guardianNumber,
      required this.wardenId,
      required this.studentId});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'phoneNumber': phoneNumber,
      'roomNumber': roomNumber,
      'email': email,
      'guardianName': guardianName,
      'guardianNumber': guardianNumber,
      'wardenId': wardenId,
      'studentId': studentId
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      name: map['name'] as String,
      phoneNumber: map['phoneNumber'] as String,
      roomNumber: map['roomNumber'] as String,
      email: map['email'] as String,
      guardianName: map['guardianName'] as String,
      guardianNumber: map['guardianNumber'] as String,
      wardenId: map['wardenId'] as String,
      studentId: map['studentId'] as String,
    );
  }
}
