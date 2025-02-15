import 'package:flutter/material.dart';
import 'package:mis_gastos/model/income.dart';
import 'package:mis_gastos/repository/income_repository.dart';

class IncomesProvider extends ChangeNotifier {
  IncomesProvider() {
    getIncomes();
  }

  List<Income>? _incomes = [];

  List<Income>? get incomes => _incomes;

  void _getIncomes() async {
    final incomes = await IncomeRepository().getIncomes();
    if (incomes != null) {
      _incomes = incomes;
      notifyListeners();
    } else {
      _incomes = [];
      notifyListeners();
    }
  }

  void getIncomes() {
    _getIncomes();
  }
}
