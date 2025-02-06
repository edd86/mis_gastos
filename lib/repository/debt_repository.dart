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
}
