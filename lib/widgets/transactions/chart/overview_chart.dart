import 'package:flutter/material.dart';
import "package:intl/intl.dart";
import 'package:udemy_flutter_basics/models/transaction.dart';

import 'chartbar.dart';

class OverviewChart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  const OverviewChart({required this.recentTransactions, Key? key})
      : super(key: key);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final DateTime weekDay = DateTime.now().subtract(Duration(days: index));
      double totalDailySum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalDailySum += recentTransactions[i].amount;
        }
      }

      return {
        "day": DateFormat.E().format(weekDay).substring(0, 1),
        "amount": totalDailySum
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(
        0.0, (sum, tx) => sum += tx["amount"] as double);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
          margin: EdgeInsets.all(15),
          child: Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: groupedTransactionValues.map((data) {
                return Flexible(
                  fit: FlexFit.tight,
                  child: Chartbar(
                    label: data["day"] as String,
                    spendingAmount: data["amount"] as double,
                    spendingPercentageOfTotal: totalSpending == 0.0
                        ? 0.0
                        : (data["amount"] as double) / totalSpending,
                  ),
                );
              }).toList(),
            ),
          )),
    );
  }
}
