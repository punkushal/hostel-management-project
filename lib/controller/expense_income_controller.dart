import 'package:get/get.dart';
import 'package:hostel_management_project/models/expense_income.dart';

class ExpenseIncomeController extends GetxController {
  final category = 'Income'.obs;
  final expenseIncomeList = <ExpenseIncome>[].obs;
  Rx<String?> selectedMonth = Rx<String?>(null);
//to add newly expense income item
  void addExpenseIncome(ExpenseIncome item) {
    expenseIncomeList.add(item);
  }

  double getTotalAmount(String category, String monthYear) {
    return expenseIncomeList
        .where((item) =>
            item.category == category &&
            getMonthYear(item.dateTime) == monthYear)
        .fold(0.0, (sum, item) => sum + item.amount);
  }

  Map<String, List<ExpenseIncome>> getGroupedExpenseIncome() {
    Map<String, List<ExpenseIncome>> groupedData = {};
    for (var item in expenseIncomeList) {
      String key = getMonthYear(item.dateTime);
      if (groupedData.containsKey(key)) {
        groupedData[key]!.add(item);
      } else {
        groupedData[key] = [item];
      }
    }
    return groupedData;
  }

  String getMonthYear(DateTime date) {
    return '${getMonthName(date.month)}, ${date.year}';
  }

  String getMonthName(int month) {
    final months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month - 1];
  }
}
