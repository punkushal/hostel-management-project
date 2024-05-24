import 'package:flutter/material.dart';
import 'package:hostel_management_project/widgets/add_budget_overlay.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BudgetReportScreen extends StatefulWidget {
  const BudgetReportScreen({super.key});

  @override
  State<BudgetReportScreen> createState() => _BudgetReportScreenState();
}

class _BudgetReportScreenState extends State<BudgetReportScreen> {
  List chartData = [
    [100, 'Incomes', Colors.green],
    [50, 'Expenses', Colors.red],
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: Column(
        children: [
          SfCircularChart(
            series: [
              PieSeries(
                dataSource: chartData,
                yValueMapper: (data, index) =>
                    data[0], //This defines area located to particular data
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
          ),
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
