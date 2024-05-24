import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hostel_management_project/models/expense_income.dart';
import 'package:intl/intl.dart';
import 'package:hostel_management_project/controller/expense_income_controller.dart';

import 'reusable_text_field.dart';

final formatter = DateFormat().add_yMd();

class AddBudgetOverlay extends StatefulWidget {
  const AddBudgetOverlay({super.key});

  @override
  State<AddBudgetOverlay> createState() => _AddBudgetOverlayState();
}

class _AddBudgetOverlayState extends State<AddBudgetOverlay> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final controller = Get.put(ExpenseIncomeController());
  DateTime? _selectedDate;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void onAddingExpenseIncome(ExpenseIncome item) {
    if (formKey.currentState!.validate() || _selectedDate != null) {
      controller.addExpenseIncome(item);
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
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
              //Input field for title
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
              //Input field for amount
              ReusableTextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                radiusValue: 12,
                labelText: 'Amount',
                obsecureText: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Provide Amount";
                  } else if (value.length <= 10) {
                    return "amount numbers should be within 10 digits";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Obx(
                    () => DropdownButton(
                        value: controller.category.value,
                        items: ['Income', 'Expense']
                            .map(
                              (val) => DropdownMenuItem(
                                value: val,
                                child: Text(val),
                              ),
                            )
                            .toList(),
                        onChanged: (value) =>
                            controller.category.value = value!),
                  ),
                  Text(_selectedDate == null
                      ? 'No date selected'
                      : formatter.format(_selectedDate!)),
                  IconButton(
                    onPressed: _presentDatePicker,
                    icon: const Icon(Icons.calendar_month),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  ExpenseIncome expenseIncome = ExpenseIncome(
                      title: titleController.text.trim(),
                      amount: double.parse(amountController.text.trim()),
                      dateTime: _selectedDate!,
                      category: controller.category.value);
                  onAddingExpenseIncome(expenseIncome);
                  Navigator.pop(context);
                },
                child: const Text('Add'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
