import 'package:mis_gastos/data/database_helper.dart';
import 'package:mis_gastos/model/expense.dart';

class ExpenseRepository {
  Future<Expense?> addExpense(Expense expense) async {
    try {
      final db = await DatabaseHelper().database;
      final id = await db.insert('expenses', expense.toMap());
      return expense.copyWith(id: id);   
    } catch (e) {
      return null;
    }
  }
}
