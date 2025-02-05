import 'package:mis_gastos/data/sqlite_code.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._instance;

  static Database? _database;

  Future<Database> get database async {
    return _database ??= await _initDb('mis_gastos_db.db');
  }

  Future<Database> _initDb(String dbName) async {
    final path = await getDatabasesPath();

    final dbPath = '$path/$dbName';
    return await openDatabase(dbPath, version: 1, onCreate: _createDb);
  }

  Future<void> _createDb(Database db, int version) async {
    await db.execute(createUserTable);
    await db.execute(createTransactionTable);
    await db.execute(createIncomeTable);
    await db.execute(createDebtTable);
    await db.execute(createExpenseTable);
    await db.execute(createBudgetTable);
  }
}
