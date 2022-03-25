import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:udemy_flutter_basics/models/transaction.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;
  final void Function(String) removeTransaction;

  const TransactionItem(this.transaction, this.removeTransaction, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(5),
      leading: CircleAvatar(
        radius: 30,
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: FittedBox(
            child: Padding(
                padding: EdgeInsets.all(5),
                child: Text("\$${transaction.amount}"))),
      ),
      title: Text(
        transaction.title,
        style: Theme.of(context).textTheme.headline6,
      ),
      subtitle: Text(DateFormat.yMMMd().format(transaction.date),
          style: const TextStyle(color: Colors.grey)),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () => removeTransaction(transaction.id),
        color: Theme.of(context).errorColor,
      ),
    );
/*    return Card(
      child: IntrinsicHeight(
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context).colorScheme.primary, width: 2)),
              child: Text(
                "\$${transaction.amount.toStringAsFixed(2)}",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.primary),
              ),
              padding: const EdgeInsets.all(10),
            ),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    transaction.title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(DateFormat.yMMMd().format(transaction.date),
                      style: const TextStyle(color: Colors.grey))
                ],
              ),
            )
          ],
        ),
      ),
    );*/
  }
}
