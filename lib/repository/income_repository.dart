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

  Future<List<Income>?> getIncomes() async {
    List<Income>? incomesTemp = [];
    try {
      final db = await DatabaseHelper().database;
      final incomes = await db.query('incomes');
      if (incomes.isEmpty) {
        return [];
      }
      for (var income in incomes) {
        incomesTemp.add(Income.fromMap(income));
      }
      return incomesTemp;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
