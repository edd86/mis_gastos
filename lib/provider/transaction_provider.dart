import 'package:flutter/material.dart';
import 'package:mis_gastos/model/transaction.dart';
import 'package:mis_gastos/repository/transaction_repository.dart';

class TransactionProvider extends ChangeNotifier {
  final transactionRepo = TransactionRepository();

  List<Transaction>? _transactions = [];
  double _balance = 0;

  TransactionProvider() {
    _getTransactions();
    _getBalance();
  }

  List<Transaction>? get transactions => _transactions;
  double get balance => _balance;

  void _getBalance() async {
    final transactionsTemp = await transactionRepo.getTransactions();
    if (transactionsTemp != null && transactionsTemp.isNotEmpty) {
      double balanceTemp = 0;
      for (var transactionTemp in transactionsTemp) {
        balanceTemp += transactionTemp
            .amount;
      }
      _balance = balanceTemp;
      notifyListeners();
    } else {
      _balance = 0;
      notifyListeners();
    }
  }

  void _getTransactions() async {
    _transactions = await transactionRepo.getTransactions();
    notifyListeners();
  }

  void updateTransactions() {
    _getTransactions();
    _getBalance();
  }
}
