import 'package:flutter/material.dart';

class WardenDetailsScreen extends StatefulWidget {
  const WardenDetailsScreen({super.key});

  @override
  State<WardenDetailsScreen> createState() => _WardenDetailsScreenState();
}

class _WardenDetailsScreenState extends State<WardenDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
    );
  }
}
