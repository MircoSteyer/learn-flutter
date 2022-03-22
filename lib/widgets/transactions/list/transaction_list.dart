import 'package:flutter/material.dart';
import 'package:udemy_flutter_basics/models/transaction.dart';

import 'transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactionList;

  const TransactionList(this.transactionList, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                height: MediaQuery.of(context).size.height * 0.5,
              )
            ],
          )
        : ListView.builder(
            itemBuilder: (ctx, index) => TransactionItem(transactionList[index],
                key: Key(transactionList[index].id)),
            itemCount: transactionList.length,
          );
  }
}
