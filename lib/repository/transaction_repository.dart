import 'package:mis_gastos/data/database_helper.dart';
import 'package:mis_gastos/model/transaction.dart';

class TransactionRepository {
  Future<List<Transaction>?> getTransactions() async {
    try {
      final db = await DatabaseHelper().database;
      final transactions = await db.query('transactions');
      if (transactions.isEmpty) {
        return [];
      }
      return transactions
          .map((transaction) => Transaction.fromMap(transaction))
          .toList();
    } catch (e) {
      return null;
    }
  }

  Future<Transaction?> addTransaction(Transaction transaction) async {
    try {
      final db = await DatabaseHelper().database;
      final id = await db.insert('transactions', transaction.toMap());
      return transaction.copyWith(id: id);
    } catch (e) {
      return null;
    }
  }
}
