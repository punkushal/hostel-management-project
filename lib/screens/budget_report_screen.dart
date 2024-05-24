import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hostel_management_project/widgets/add_budget_overlay.dart';
import 'package:hostel_management_project/widgets/expense_income_list.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../controller/expense_income_controller.dart';

class BudgetReportScreen extends StatefulWidget {
  const BudgetReportScreen({super.key});

  @override
  State<BudgetReportScreen> createState() => _BudgetReportScreenState();
}

class _BudgetReportScreenState extends State<BudgetReportScreen> {
  ExpenseIncomeController controller = Get.put(ExpenseIncomeController());
  String selectedMonthYear = '';

  List getChartData() {
    double incomeTotal = controller.getTotalAmount('Income', selectedMonthYear);
    double expenseTotal =
        controller.getTotalAmount('Expense', selectedMonthYear);

    return [
      [incomeTotal, 'Incomes', Colors.green],
      [expenseTotal, 'Expenses', Colors.red],
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: Column(
        children: [
          selectedMonthYear.isNotEmpty
              ? SfCircularChart(
                  series: [
                    PieSeries(
                      dataSource: getChartData(),
                      yValueMapper: (data, index) => data[
                          0], //This defines area located to particular data
                      xValueMapper: (data, index) => data[1],
                      radius: '70%',
                      explode: true,
                      pointColorMapper: (data, index) => data[2],
                      dataLabelMapper: (data, index) => '${data[0]}k',
                      dataLabelSettings: const DataLabelSettings(
                        labelPosition: ChartDataLabelPosition.outside,
                        isVisible: true,
                        textStyle: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                    ),
                  ],
                )
              : const Text('Not tapped'),
          const SizedBox(
            height: 14,
          ),
          Expanded(child: ExpenseIncomeList(
            onMonthYearTap: (monthYear) {
              setState(() {
                selectedMonthYear = monthYear;
              });
            },
          )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context, builder: (ctx) => const AddBudgetOverlay());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
