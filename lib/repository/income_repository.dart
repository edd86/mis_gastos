import 'package:mis_gastos/data/database_helper.dart';
import 'package:mis_gastos/model/income.dart';

class IncomeRepository {
  Future<Income?> addIncome(Income income) async {
    try {
      final db = await DatabaseHelper().database;
      final id = await db.insert('incomes', income.toMap());
      return income.copyWith(id: id);
    } catch (e) {
      return null;
    }
  }
}
