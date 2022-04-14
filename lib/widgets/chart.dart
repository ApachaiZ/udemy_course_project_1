import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:udemy_course_project_1/models/transaction.dart';
import 'package:udemy_course_project_1/widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  static const int numberOfDays = 7;

  const Chart({Key? key, required this.recentTransactions}) : super(key: key);

  final List<Transaction> recentTransactions;

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  List<Map<String, dynamic>> get groupedTransactionValues {
    return List.generate(
      numberOfDays,
      (index) {
        final weekDay = DateTime.now().subtract(
          Duration(days: index),
        );
        double totalSum = 0.0;
        for (var transaction in recentTransactions) {
          if (transaction.date.day == weekDay.day &&
              transaction.date.month == weekDay.month &&
              transaction.date.year == weekDay.year) {
            totalSum += transaction.amount;
          }
        }
        return {
          "day": DateFormat.E().format(weekDay).substring(0, 1),
          "amount": totalSum
        };
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.reversed.map(
            (data) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                  label: data['day'],
                  spendingAmount: data['amount'],
                  spendingPctOfTotal: totalSpending == 0.0
                      ? 0.0
                      : (data['amount'] as double) / totalSpending,
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
