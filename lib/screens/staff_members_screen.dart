import 'package:flutter/material.dart';

class StaffMembersScreen extends StatelessWidget {
  const StaffMembersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: const Center(
        child: Text('Staff Members '),
      ),
    );
  }
}
