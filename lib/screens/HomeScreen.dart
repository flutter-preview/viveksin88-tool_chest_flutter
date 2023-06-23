import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tool_chest/widgets/MainDrawer.dart';

import '../providers/Transaction.dart';
import '../widgets/NewTransaction.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bCtx) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(),
            behavior: HitTestBehavior.opaque,
          );
        });
  }
  
  @override
  Widget build(BuildContext context) {
    final transactions = Provider.of<Transaction>(context);
    transactions.transactions;
    return Scaffold(
      // resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Tool Chest - Expense tracker"),
      ),
      drawer: const MainDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(7),
              child: Row(
                children: [
                  Text(
                      "Luxury",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25), textAlign: TextAlign.end),
                  IconButton(icon: Icon(Icons.refresh), onPressed: () {  },)
                ],
              ),
            ),
            Card(
              margin: EdgeInsets.all(15),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:  [
                    Text('Total amount spent: \$${transactions.luxuryAmountSpent}')
                  ],
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.all(15),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total amount remaining:\$${transactions.luxuryAmountRemaining}')
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(7),
              child: Row(
                children: [
                  Text(
                      "Eating out",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25), textAlign: TextAlign.end),
                  IconButton(icon: Icon(Icons.refresh), onPressed: () {  },)
                ],
              ),
            ),
            Card(
              margin: EdgeInsets.all(15),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:  [
                    Text('Total amount spent: \$${transactions.eatingOutAmountSpent}')
                  ],
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.all(15),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total amount remaining:\$${transactions.eatingAmountRemaining}')
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(7),
              child: Row(
                children: [
                  Text(
                      "Groceries",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25), textAlign: TextAlign.end),
                  IconButton(icon: Icon(Icons.refresh), onPressed: () {  },)
                ],
              ),
            ),
            Card(
              margin: EdgeInsets.all(15),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:  [
                    Text('Total amount spent: \$${transactions.groceriesAmountSpent}')
                  ],
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.all(15),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total amount remaining:\$${transactions.groceriesAmountRemaining}')
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(7),
              child: Row(
                children: [
                  Text(
                      "Gas",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25), textAlign: TextAlign.end),
                  IconButton(icon: Icon(Icons.refresh), onPressed: () {  },)
                ],
              ),
            ),
            Card(
              margin: EdgeInsets.all(15),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:  [
                    Text('Total amount spent: \$${transactions.gasAmountSpent}')
                  ],
                ),
              ),
            ),
          ]
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
