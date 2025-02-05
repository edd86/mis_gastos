import 'package:mis_gastos/data/database_helper.dart';
import 'package:mis_gastos/model/budget.dart';

class BudgetRepository {
  Future<Budget?> addBudget(Budget budget) async {
    try {
      final db = await DatabaseHelper().database;
      final id = await db.insert('budgets', budget.toMap());
      return budget.copyWith(id: id);
    } catch (e) {
      return null;
    }
  }

  Future<List<Budget>?> getBudgets() async {
    List<Budget> budgets = [];
    try {
      final db = await DatabaseHelper().database;
      final budgetsResponse = await db.query('budgets');
      if (budgetsResponse.isNotEmpty) {
        for (var budget in budgetsResponse) {
          budgets.add(Budget.fromMap(budget));
        }
      }
      return budgets;
    } catch (e) {
      return null;
    }
  }
}
