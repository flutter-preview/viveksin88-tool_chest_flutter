// import 'package:expense_tracker_app/models/transaction_source.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tool_chest/model/TransactionItem.dart';
import 'package:uuid/uuid.dart';
// import 'package:http/http.dart' as http;

class TransactionProviderItem {
  final String id;
  final String name;
  final double amount;
  final TransactionType transactionType;

  TransactionProviderItem({required this.id, required this.name, required this.amount, required this.transactionType});
}

class Transaction with ChangeNotifier {
  List<String> supportedBanks = ["RBC", "TD", "CIBC", "Wealthsimple", "Chase"];
  List<TransactionProviderItem> _transactions = [];
  var _luxuryAmountSpent = 0.0;
  var _luxuryAmountRemaining = 450.0;

  var _eatingOutAmountSpent = 0.0;
  var _eatingOutAmountRemaining = 150.0;

  var _groceriesAmountSpent = 0.0;
  var _groceriesAmountRemaining = 700.0;

  var _gasAmountSpent = 0.0;

  List<TransactionProviderItem> get transactions {
    return [..._transactions];
  }

  // Future<void> getTransactions() async {
  //   try {
  //     _totalAmount = 0;
  //     const url = "http://192.168.86.48:5000/transactions";
  //     final response = await http.get(url);
  //     final extractedData = json.decode(response.body) as Map<String, dynamic>;
  //     final List<TransactionProviderItem> transactions = [];
  //     extractedData.forEach((key, data) {
  //       List<dynamic> transactionsList = List<dynamic>.from(data);
  //       transactionsList.forEach((element) {
  //         transactions.add(TransactionProviderItem(
  //             id: element[0],
  //             title: element[1],
  //             amount: element[3],
  //             transactionSource: TransactionSource(element[2], element[5],
  //                 FinancialSourceType.values
  //                     .firstWhere((e) => e.toString() == "FinancialSourceType" + "." + element[7])),
  //             date: DateTime.parse(element[4])
  //         ));
  //         _totalAmount = _totalAmount + element[3];
  //       });
  //       notifyListeners();
  //     });
  //     _transactions = transactions;
  //   } catch (error) {
  //     print(error);
  //     throw (error);
  //   }
  // }

  Future<void> addTransaction(final String name, final double amount, final TransactionType transactionType) async {
    // try {
      const url = "http://192.168.86.48:5000/transaction";
      final uuid = Uuid().v4();
      final newTransaction = TransactionProviderItem(
          id: uuid,
          name: name,
          amount: amount,
          transactionType: transactionType);

      switch(transactionType) {
        case TransactionType.luxury:
          _luxuryAmountSpent += amount;
          _luxuryAmountRemaining -= amount;
          break;
        case TransactionType.eatingOut:
          _eatingOutAmountSpent += amount;
          _eatingOutAmountRemaining -= amount;
          break;
        case TransactionType.groceries:
          _groceriesAmountSpent += amount;
          _groceriesAmountRemaining += amount;
          break;
        case TransactionType.gas:
          _gasAmountSpent += amount;
          break;
      }
      // await http.post(url, headers: {
      //   'Content-type': 'application/json',
      //   'Accept': 'application/json',
      // }, body: json.encode({
      //   "uuid": newTransaction.id,
      //   "title": newTransaction.title,
      //   "amount": newTransaction.amount,
      //   "source_uuid": newTransaction.transactionSource.id
      // }));
      _transactions.add(newTransaction);
      notifyListeners();
    // } catch (error) {
    //   print(error);
    //   throw (error);
    // }
  }

  double get luxuryAmountRemaining {
    return _luxuryAmountRemaining;
  }

  double get luxuryAmountSpent {
    return _luxuryAmountSpent;
  }

  double get groceriesAmountSpent {
    return _groceriesAmountSpent;
  }

  double get groceriesAmountRemaining {
    return _groceriesAmountRemaining;
  }

  double get eatingOutAmountSpent {
    return _eatingOutAmountSpent;
  }

  double get eatingAmountRemaining {
    return _eatingOutAmountRemaining;
  }

  double get gasAmountSpent {
    return _gasAmountSpent;
  }

  // Future<void> deleteTransaction(transactionId) async {
  //   try {
  //     const url = "http://192.168.86.48:5000/transaction/remove";
  //     http.post(url, headers: {
  //       "Content-type": "application/json"
  //     },body: json.encode({
  //       "uuid" : transactionId
  //     }));
  //     notifyListeners();
  //   } catch (error) {
  //     print(error);
  //     throw(error);
  //   }
  // }
}
