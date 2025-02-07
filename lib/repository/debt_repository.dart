import 'package:mis_gastos/data/database_helper.dart';
import 'package:mis_gastos/model/debt.dart';

class DebtRepository {
  Future<Debt?> addDebt(Debt debt) async {
    try {
      final db = await DatabaseHelper().database;
      final id = await db.insert('debts', debt.toMap());
      return debt.copyWith(id: id);
    } catch (e) {
      return null;
    }
  }

  Future<List<Debt>?> getDebts() async {
    try {
      final db = await DatabaseHelper().database;
      final debts = await db.query('debts');
      if (debts.isEmpty) return null;
      return debts.map((debt) => Debt.fromMap(debt)).toList();
    } catch (e) {
      return null;
    }
  }

  Future<int?> updateExpenseDebt(double amount, int id) async {
    try {
      final db = await DatabaseHelper().database;
      final debtTemp =
          await db.query('debts', where: 'id = ?', whereArgs: [id]);
      final debt = Debt.fromMap(debtTemp.first);
      debt.amount = debt.amount + amount;
      int cont = await db.update('debts', debt.toMap(), where: 'id = ?', whereArgs: [id]);
      return cont;
    } catch (e) {
      return null;
    }
  }
}
