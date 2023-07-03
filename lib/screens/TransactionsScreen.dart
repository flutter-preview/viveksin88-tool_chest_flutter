import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/Transaction.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({Key? key}) : super(key: key);

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {

  @override
  Scaffold build(BuildContext context) {
    final Transaction transactionsProvider = Provider.of<Transaction>(context);
    transactionsProvider.transactions;
    var transactionsList = transactionsProvider.transactionsList;
    print(transactionsList);

    return Scaffold(
      appBar: AppBar(title: Text("Transactions"),),
      body: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: transactionsList.length,
          itemBuilder: (BuildContext context, int item) {
            return ListTile(title: Text(transactionsList[item].name));
          }),
    );
  }
}