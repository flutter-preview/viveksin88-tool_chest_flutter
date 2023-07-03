// import 'package:expense_tracker_app/models/transaction_source.dart';

import 'dart:convert';
// import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tool_chest/model/TransactionItem.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class TransactionProviderItem {
  final String id;
  final String name;
  final double amount;
  final TransactionType transactionType;

  TransactionProviderItem({required this.id, required this.name, required this.amount, required this.transactionType});
}

class Transaction with ChangeNotifier {
  var serverUrl = "https://toolchest-viveksin.us2.pitunnel.com";
  List<String> supportedBanks = ["RBC", "TD", "CIBC", "Wealthsimple", "Chase"];
  List<TransactionProviderItem> _transactions = [];
  var _luxuryAmountSpent = 0.0;
  var _luxuryAmountRemaining = 450.0;

  var _eatingOutAmountSpent = 0.0;
  var _eatingOutAmountRemaining = 150.0;

  var _groceriesAmountSpent = 0.0;
  var _groceriesAmountRemaining = 700.0;

  var _gasAmountSpent = 0.0;

  get transactionsList {
    return [..._transactions];
  }

  // List<TransactionProviderItem> get transactions {
  //   return [..._transactions];
  // }

  Future<void> get transactions async {
    try {
      // _totalAmount = 0;
      var url = Uri.parse("$serverUrl/transactions");
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as List<dynamic>;
      final List<TransactionProviderItem> transactions = [];
      extractedData.forEach((data) {
        Map<String, dynamic> transactionsList = Map<String, dynamic>.from(data);
        transactions.add(TransactionProviderItem(id: transactionsList["id"].toString(),
            name: transactionsList["name"],
            amount: transactionsList["amount"],
            transactionType: TransactionType.values.byName(transactionsList["transaction_type"])));
      });
      _transactions = transactions;
      notifyListeners();
    } catch (error) {
      print(error);
      throw (error);
    }
  }

  Future<void> addTransaction(final String name, final double amount, final TransactionType transactionType) async {
    try {
      var url = Uri.parse("$serverUrl/transactions");
      final uuid = Uuid().v4();
      final newTransaction = TransactionProviderItem(
          id: uuid,
          name: name,
          amount: amount,
          transactionType: transactionType);

      await http.post(url, headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      }, body: json.encode({
        "uuid": newTransaction.id,
        "name": newTransaction.name,
        "amount": newTransaction.amount,
        "transactionType": newTransaction.transactionType.name
      }));
      notifyListeners();
    } catch (error) {
      print(error);
      throw (error);
    }
  }

  Future<void> resetTransactions(final TransactionType transactionType) async {
    try {
      var type = transactionType.name;
      var url = Uri.parse("$serverUrl/reset/$type");
      await http.post(url, headers: {
        'Content-type': 'application/json',
      }, body: json.encode({}));
      notifyListeners();
    } catch (error) {
      print(error);
      throw (error);
    }
  }

  double get luxuryAmountRemaining {
    var amountRemaining = 0.0;
    if (_transactions.isNotEmpty) {
      amountRemaining = _luxuryAmountRemaining - _transactions.where((transaction) => transaction.transactionType ==
          TransactionType.luxury).map((e) =>
      e.amount).fold<double>(0, (previous, current) => previous + current);
    }
    return amountRemaining;
  }

  double get luxuryAmountSpent {
    var amountSpent = 0.0;
    if (_transactions.isNotEmpty) {
      amountSpent = _transactions.where((transaction) => transaction.transactionType ==
          TransactionType.luxury).map((e) =>
      e.amount).fold<double>(0, (previous, current) => previous + current);
    }
    return amountSpent;
  }

  double get groceriesAmountSpent {
    var amountSpent = 0.0;
    if (_transactions.isNotEmpty) {
      amountSpent = _transactions.where((transaction) => transaction.transactionType ==
          TransactionType.groceries).map((e) =>
      e.amount).fold<double>(0, (previous, current) => previous + current);
    }
    return amountSpent;
  }

  double get groceriesAmountRemaining {
    var amountRemaining = 0.0;
    if (_transactions.isNotEmpty) {
      amountRemaining = _groceriesAmountRemaining - _transactions.where((transaction) => transaction.transactionType ==
          TransactionType.groceries).map((e) =>
      e.amount).fold<double>(0, (previous, current) => previous + current);
    }
    return amountRemaining;
  }

  double get eatingOutAmountSpent {
    var amountSpent = 0.0;
    if (_transactions.isNotEmpty) {
      amountSpent = _transactions.where((transaction) => transaction.transactionType ==
          TransactionType.eating_out).map((e) =>
      e.amount).fold<double>(0, (previous, current) => previous + current);
    }
    return amountSpent;
  }

  double get eatingAmountRemaining {
    var amountRemaining = 0.0;
    if (_transactions.isNotEmpty) {
      amountRemaining = _eatingOutAmountRemaining - _transactions.where((transaction) => transaction.transactionType ==
          TransactionType.groceries).map((e) =>
      e.amount).fold<double>(0, (previous, current) => previous + current);
    }
    return amountRemaining;
  }

  double get gasAmountSpent {
    var amountSpent = 0.0;
    if (_transactions.isNotEmpty) {
      amountSpent = _transactions.where((transaction) => transaction.transactionType ==
          TransactionType.gas).map((e) =>
      e.amount).fold<double>(0, (previous, current) => previous + current);
    }
    return amountSpent;
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
