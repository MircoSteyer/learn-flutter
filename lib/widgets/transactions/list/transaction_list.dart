import 'package:flutter/material.dart';
import 'package:udemy_flutter_basics/models/transaction.dart';

import 'transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactionList;
  final void Function(String) removeTransaction;

  const TransactionList(this.transactionList, this.removeTransaction,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (layoutContext, constraints) {
      return transactionList.isEmpty
          ? Column(
              children: [
                Text("No Transactions added yet.",
                    style: Theme.of(context).textTheme.headline6),
                SizedBox(height: 20),
                Container(
                  child: Image.asset(
                    "assets/images/waiting.png",
                    fit: BoxFit.cover,
                  ),
                  height: constraints.maxHeight * 0.6,
                )
              ],
            )
          : Expanded(
              child: ListView.builder(
                itemBuilder: (ctx, index) => TransactionItem(
                    transactionList[index], removeTransaction,
                    key: Key(transactionList[index].id)),
                itemCount: transactionList.length,
              ),
            );
    });
  }
}
