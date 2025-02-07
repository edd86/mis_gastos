import 'package:flutter/material.dart';
import 'package:mis_gastos/model/debt.dart';
import 'package:mis_gastos/repository/debt_repository.dart';

class DebtProvider extends ChangeNotifier {
  List<Debt> _debts = [];

  List<Debt> get debts => _debts;

  getDebts() async {
    final debtTemps = await DebtRepository().getDebts();
    if (debtTemps != null) {
      _debts = debtTemps;
    }
    notifyListeners();
  }
}
