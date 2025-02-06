import 'package:flutter/material.dart';
import 'package:mis_gastos/model/budget.dart';
import 'package:mis_gastos/repository/budget_repository.dart';

class BudgetProvider extends ChangeNotifier {
  List<Budget>? _budgets = [];

  BudgetProvider() {
    _getBudgets();
  }

  List<Budget>? get budgets => _budgets;

  void _getBudgets() async {
    _budgets = await BudgetRepository().getBudgets();
    notifyListeners();
  }

  void updateBudgets() {
    _getBudgets();
  }
}
