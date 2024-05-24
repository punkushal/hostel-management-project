import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hostel_management_project/controller/expense_income_controller.dart';

class ExpenseIncomeList extends StatelessWidget {
  const ExpenseIncomeList({super.key, required this.onMonthYearTap});
  final void Function(String monthYear) onMonthYearTap;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ExpenseIncomeController());
    return Obx(
      () => ListView(
        children: controller.getGroupedExpenseIncome().entries.map((entry) {
          final monthYear = entry.key;
          final incomeTotal = controller.getTotalAmount('Income', monthYear);
          final expenseTotal = controller.getTotalAmount('Expense', monthYear);
          return GestureDetector(
            onTap: () {
              onMonthYearTap(monthYear);
            },
            child: ExpansionTile(
              title: Text(monthYear),
              children: [
                ListTile(
                  title: const Text('Income Total'),
                  trailing: Text(incomeTotal.toString()),
                ),
                ListTile(
                  title: const Text('Expense Total'),
                  trailing: Text(expenseTotal.toString()),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: entry.value.length,
                    itemBuilder: (ctx, index) {
                      final item = entry.value[index];
                      return ListTile(
                        title: Text(item.title),
                        trailing: Text(item.amount.toString()),
                      );
                    })
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
