import 'package:flutter/material.dart';

class TransactionInput extends StatefulWidget {
  final void Function(String, double) onSubmit;

  TransactionInput({required this.onSubmit, Key? key}) : super(key: key);

  @override
  State<TransactionInput> createState() => _TransactionInputState();
}

class _TransactionInputState extends State<TransactionInput> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

  void submitData() {
    String enteredTitle = _titleController.text;
    double enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) return;

    widget.onSubmit(
        // double.parse will throw an error if no parsable string was entered
        enteredTitle,
        enteredAmount);

    // close modal sheet
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(children: [
          TextField(
            decoration: const InputDecoration(labelText: "Title"),
            controller: _titleController,
            onSubmitted: (_) => submitData(),
          ),
          // we would need to validate that only numbers can be entered here to avoid an error at double.parse
          TextField(
            decoration: const InputDecoration(labelText: "Amount"),
            controller: _amountController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onSubmitted: (_) => submitData(),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: submitData,
              child: const Text("Add Transaction"),
            ),
          ),
        ]),
      ),
    );
  }
}
