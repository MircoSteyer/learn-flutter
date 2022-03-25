import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionInput extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  const TransactionInput({required this.onSubmit, Key? key}) : super(key: key);

  @override
  State<TransactionInput> createState() => _TransactionInputState();
}

class _TransactionInputState extends State<TransactionInput> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? pickedDate;

  void submitData() {
    String enteredTitle = _titleController.text;
    double enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || pickedDate == null) {
      return;
    }

    widget.onSubmit(enteredTitle, enteredAmount, pickedDate!);

    // close modal sheet
    Navigator.of(context).pop();
  }

  void _presentDatePicker() async {
    DateTime? newDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now().subtract(const Duration(days: 365)),
        lastDate: DateTime.now());

    setState(() {
      pickedDate = newDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: SizedBox(
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextField(
                    decoration: const InputDecoration(labelText: "Title"),
                    controller: _titleController,
                    onSubmitted: (_) => submitData(),
                  ),
                  // we would need to validate that only numbers can be entered here to avoid an error at double.parse
                  TextField(
                    decoration: const InputDecoration(labelText: "Amount"),
                    controller: _amountController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    onSubmitted: (_) => submitData(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(pickedDate is DateTime
                          ? DateFormat.yMMMd().format(pickedDate!)
                          : "No Date Chosen."),
                      TextButton(
                          onPressed: _presentDatePicker,
                          child: const Text(
                            "Choose Date",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ))
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: submitData,
                      child: const Text("Add Transaction"),
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
