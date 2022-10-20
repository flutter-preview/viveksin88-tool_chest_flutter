// import 'package:expense_tracker_app/models/transaction_source.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
// import 'package:http/http.dart' as http;

class TransactionProviderItem {
  final String id;
  final String name;
  final double amount;

  TransactionProviderItem({required this.id, required this.name, required this.amount});
}

class Transaction with ChangeNotifier {
  List<String> supportedBanks = ["RBC", "TD", "CIBC", "Wealthsimple", "Chase"];
  List<TransactionProviderItem> _transactions = [];
  var _totalAmount = 0.0;
  var _luxuryAmountRemaining = 450.0;

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

  Future<void> addTransaction(final String name, final double amount) async {
    // try {
      const url = "http://192.168.86.48:5000/transaction";
      final uuid = Uuid().v4();
      final newTransaction = TransactionProviderItem(
          id: uuid,
          name: name,
          amount: amount);
      _totalAmount += amount;
      _luxuryAmountRemaining -= amount;
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

  double get totalAmount {
    return _totalAmount;
  }

  double get luxuryAmountRemaining {
    return _luxuryAmountRemaining;
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
