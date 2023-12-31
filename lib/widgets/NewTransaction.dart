import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tool_chest/model/TransactionItem.dart';

import '../providers/Transaction.dart';

class NewTransaction extends StatefulWidget {
  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  TransactionType transactionType = TransactionType.luxury;

  @override
  Widget build(BuildContext context) {
    void _submitData() {
      final transactions = Provider.of<Transaction>(context, listen: false);
      if (_amountController.text.isEmpty) {
        return;
      }
      final enteredTitle = _titleController.text;
      final enteredAmount = double.parse(_amountController.text);

      // if (enteredTitle.isEmpty ||
      //     enteredAmount <= 0 ||
      //     _value == null) {
      //   return;
      // }

      // final List<String> values = _value.split(",");
      // TODO: Capture transaction type as input
      print("Transaction type" + transactionType.name);
      transactions.addTransaction(enteredTitle, enteredAmount, transactionType);
      Navigator.of(context).pop(); // Closes the add transaction modal
    }

    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 10, right: 10),
          // padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
                controller: _titleController,
              ),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Amount',
                ),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
              ),
              DropdownButton(
                value: transactionType,
                onChanged: (TransactionType? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    transactionType = value!;
                  });
                },
                items: TransactionType.values.map<DropdownMenuItem<TransactionType>>((TransactionType value) {
                  return DropdownMenuItem<TransactionType>(
                    value: value,
                    child: Text(value.name),
                  );
                }).toList(),
              ),
              RaisedButton(
                // padding: MediaQuery.of(context).viewInsets,
                onPressed: () => _submitData(),
                child: Text('Add transaction'),
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
