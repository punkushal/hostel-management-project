import 'package:flutter/material.dart';

class ManageStudentsScreen extends StatelessWidget {
  const ManageStudentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Manage Students'),
          automaticallyImplyLeading: true,
        ),
        body: const Center(
          child: Text('Manage students'),
        ));
  }
}
