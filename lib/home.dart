import 'package:flutter/material.dart';
import 'package:udemy_flutter_basics/widgets/transactions/list/transaction_list.dart';
import 'package:udemy_flutter_basics/widgets/transactions/transaction_input.dart';
import 'package:uuid/uuid.dart';

import 'models/transaction.dart';
import 'widgets/transactions/chart/overview_chart.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Transaction> _transactions = [];

  List<Transaction> get _lastWeeksTransactions {
    return _transactions
        .where((tx) =>
            tx.date.isAfter(DateTime.now().subtract(const Duration(days: 7))))
        .toList();
  }

  void _addNewTransaction(String title, double amount) {
    final newTransaction = Transaction(
        id: const Uuid().v4(),
        title: title,
        amount: amount,
        date: DateTime.now());

    setState(() {
      _transactions = [..._transactions, newTransaction];
    });
  }

  void _startTransactionInputProcess(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionInput(onSubmit: _addNewTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Personal Expenses"),
        actions: [
          IconButton(
              onPressed: () => _startTransactionInputProcess(context),
              icon: const Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          OverviewChart(
            recentTransactions: _lastWeeksTransactions,
          ),
          Expanded(child: TransactionList(_transactions))
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startTransactionInputProcess(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
