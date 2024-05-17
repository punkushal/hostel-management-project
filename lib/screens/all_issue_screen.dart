import 'package:flutter/material.dart';

class AllIssueScreen extends StatelessWidget {
  const AllIssueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: const Center(
        child: Text('All Issues'),
      ),
    );
  }
}
