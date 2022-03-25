import "dart:io";

import 'package:flutter/cupertino.dart';
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
  bool _showChart = false;

  List<Transaction> get _lastWeeksTransactions {
    return _transactions
        .where((tx) =>
            tx.date.isAfter(DateTime.now().subtract(const Duration(days: 7))))
        .toList();
  }

  void _addNewTransaction(String title, double amount, DateTime date) {
    final newTransaction = Transaction(
        id: const Uuid().v4(), title: title, amount: amount, date: date);

    setState(() {
      _transactions = [..._transactions, newTransaction];
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((element) => element.id == id);
    });
  }

  void _startTransactionInputProcess(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (_) {
          return Container(
              padding: MediaQuery.of(context).viewInsets,
              child: TransactionInput(onSubmit: _addNewTransaction));
        });
  }

  get landscapeBody {
    return SafeArea(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Show Chart",
                style: Theme.of(context).textTheme.headline6,
              ),
              Switch.adaptive(
                value: _showChart,
                onChanged: (bool) {
                  setState(() {
                    _showChart = bool;
                  });
                },
                thumbColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).colorScheme.secondary),
                trackColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).colorScheme.secondary),
                overlayColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).colorScheme.secondary),
              )
            ],
          ),
          _showChart
              ? SizedBox(
                  height: (MediaQuery.of(context).size.height -
                          (MediaQuery.of(context).padding.top +
                              kToolbarHeight)) *
                      0.7,
                  child: OverviewChart(
                    recentTransactions: _lastWeeksTransactions,
                  ),
                )
              : SizedBox(
                  height: (MediaQuery.of(context).size.height -
                          (MediaQuery.of(context).padding.top +
                              kToolbarHeight)) *
                      0.7,
                  child: TransactionList(_transactions, _deleteTransaction))
        ],
      ),
    );
  }

  get portraitBody {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: (MediaQuery.of(context).size.height -
                    (MediaQuery.of(context).padding.top + kToolbarHeight)) *
                0.3,
            child: OverviewChart(
              recentTransactions: _lastWeeksTransactions,
            ),
          ),
          SizedBox(
              height: (MediaQuery.of(context).size.height -
                      (MediaQuery.of(context).padding.top + kToolbarHeight)) *
                  0.7,
              child: TransactionList(_transactions, _deleteTransaction))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final dynamic appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: const Text("Personal Expenses"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () => _startTransactionInputProcess(context),
                  child: const Icon(CupertinoIcons.add),
                )
              ],
            ),
          )
        : AppBar(
            title: const Text("Personal Expenses"),
            actions: [
              IconButton(
                  onPressed: () => _startTransactionInputProcess(context),
                  icon: const Icon(Icons.add))
            ],
          );
    final body = isLandscape ? landscapeBody : portraitBody;

    return Platform.isIOS
        ? CupertinoPageScaffold(child: body)
        : Scaffold(
            appBar: appBar,
            body: body,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    onPressed: () => _startTransactionInputProcess(context),
                    child: const Icon(Icons.add),
                  ),
          );
  }
}
