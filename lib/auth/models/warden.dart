class Warden {
  final String email;
  final String hostelName;
  final String hostelLocation;
  final String name;
  final String phoneNumber;
  final String role;

  Warden(
      {required this.name,
      required this.phoneNumber,
      required this.role,
      required this.hostelName,
      required this.email,
      required this.hostelLocation});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'phoneNumber': phoneNumber,
      'role': role,
      'hostelName': hostelName,
      'email': email,
    };
  }

  factory Warden.fromMap(Map<String, dynamic> map) {
    return Warden(
      name: map['name'] as String,
      phoneNumber: map['phoneNumber'] as String,
      role: map['role'] as String,
      hostelName: map['hostelName'] as String,
      email: map['email'] as String,
      hostelLocation: map['hostelLocation'] as String,
    );
  }
}
