import 'package:flutter/material.dart';

import 'reusable_text_field.dart';

class AddBudgetOverlay extends StatefulWidget {
  const AddBudgetOverlay({super.key});

  @override
  State<AddBudgetOverlay> createState() => _AddBudgetOverlayState();
}

class _AddBudgetOverlayState extends State<AddBudgetOverlay> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Expense/Income'),
      content: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              //Input field for room number
              ReusableTextField(
                controller: titleController,
                radiusValue: 12,
                labelText: 'Title',
                obsecureText: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Provide title";
                  } else if (value.length <= 10) {
                    return "Title should be 10 characters long";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
