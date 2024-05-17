import 'package:flutter/material.dart';

class ChangeRequestScreen extends StatelessWidget {
  const ChangeRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: const Center(
        child: Text('Change Request'),
      ),
    );
  }
}
