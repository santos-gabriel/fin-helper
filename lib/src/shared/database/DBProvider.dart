import 'dart:io';

import 'package:finhelper/src/shared/models/expense_model.dart';
import 'package:finhelper/src/shared/models/movement_model.dart';
import 'package:finhelper/src/shared/models/revenue_model.dart';
import 'package:finhelper/src/shared/models/user_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "application.db");
    return await openDatabase(path,
        version: 1, onOpen: (db) {}, onCreate: (Database db, int version) {});
  }

  newUser(UserModel userModel) async {
    final db = await database;
    var res = await db!.insert("USER", userModel.toMap());
    return res;
  }

  newRevenue(RevenueModel revenueModel) async {
    final db = await database;
    var res = await db!.insert("REVENUE", revenueModel.toMap());
    return res;
  }

  newExpense(ExpenseModel expenseModel) async {
    final db = await database;
    var res = await db!.insert("EXPENSE", expenseModel.toMap());
    return res;
  }

  deleteRevenueById(int id) async {
    final db = await database;
    var res = await db!.rawDelete('DELETE FROM REVENUE WHERE ID = ?', [id]);
    return res;
  }

  deleteExpenseById(int id) async {
    final db = await database;
    var res = await db!.rawDelete('DELETE FROM EXPENSE WHERE ID = ?', [id]);
    return res;
  }

  getById(int id) async {
    final db = await database;
    // db!.rawUpdate('UPDATE REVENUE SET DATE = ?', ['2021-08-27']);
    // return;
    var res = await db!.rawQuery('SELECT * FROM REVENUE WHERE ID = ?', [id]);
    if (res.isNotEmpty) {
      RevenueModel model = RevenueModel.fromMap(res.elementAt(0));
      return model;
    }
    return;
  }

  getAll() async {
    final db = await database;
    var res = await db!.query('REVENUE');
    List<RevenueModel> modelList = List.empty(growable: true);
    if (res.isNotEmpty) {
      res.forEach((element) {
        modelList.add(RevenueModel.fromMap(element));
      });
      return modelList;
    }
    return modelList;
  }

  getAllExpenses() async {
    final db = await database;
    var res = await db!.query('EXPENSE');
    List<ExpenseModel> modelList = List.empty(growable: true);
    if (res.isNotEmpty) {
      res.forEach((element) {
        modelList.add(ExpenseModel.fromMap(element));
      });
      return modelList;
    }
    return modelList;
  }

  getAllMovement() async {
    final db = await database;
    final sql = 'SELECT E.ID, E.DESCRIPTION, E.TYPE, E.VALUE, E.DATE '
        'FROM   EXPENSE E '
        'UNION ALL '
        'SELECT R.ID, R.DESCRIPTION, R.TYPE, R.VALUE, R.DATE '
        'FROM   REVENUE R '
        'ORDER BY DATE DESC';
    var res = await db!.rawQuery(sql);
    List<MovementModel> modelList = List.empty(growable: true);
    if (res.isNotEmpty) {
      res.forEach((element) {
        modelList.add(MovementModel.fromMap(element));
      });
      return modelList;
    }
    return modelList;
  }

  getBalanceRevenues() async {
    final db = await database;
    final sql = "SELECT COALESCE(SUM(R.VALUE), 0) AS BALANCE FROM REVENUE R";
    var res = await db!.rawQuery(sql);
    double result = 0;
    if (res.isNotEmpty) {
      res.forEach((element) {
        result = double.parse(element['BALANCE'].toString());
      });
    }
    return result;
  }

  getBalanceExpenses() async {
    final db = await database;
    final sql = "SELECT COALESCE(SUM(E.VALUE), 0) AS BALANCE FROM EXPENSE E";
    var res = await db!.rawQuery(sql);
    double result = 0;
    if (res.isNotEmpty) {
      res.forEach((element) {
        result = double.parse(element['BALANCE'].toString());
      });
    }
    return result;
  }

  getBalance() async {
    double resultExpenses = await getBalanceExpenses();
    double resultRevenues = await getBalanceRevenues();
    double result = resultRevenues - resultExpenses;

    return result;
  }

  clearAll() async {
    final db = await database;
    //getAllExpenses();
    // await getBalance();
    await db!.rawDelete('DELETE FROM REVENUE');
    await db.rawDelete('DELETE FROM EXPENSE');
    return;
  }

  createAll() async {
    final db = await database;
    //getAllExpenses();
    //await getBalance();
    try {
      await db!.execute("CREATE TABLE USER("
          "ID INTEGER PRIMARY KEY AUTOINCREMENT,"
          "NAME TEXT,"
          "PHOTOURL TEXT,"
          "PASSWORD TEXT"
          ");");
    } catch (e) {}
    try {
      await db!.execute("CREATE TABLE REVENUE ("
          "ID INTEGER PRIMARY KEY AUTOINCREMENT,"
          "DESCRIPTION TEXT,"
          "TYPE TEXT,"
          "VALUE REAL,"
          "DATE TEXT,"
          "USER_ID INTEGER"
          ")");
    } catch (e) {}
    try {
      await db!.execute("CREATE TABLE EXPENSE ("
          "ID INTEGER PRIMARY KEY AUTOINCREMENT,"
          "DESCRIPTION TEXT,"
          "TYPE TEXT,"
          "VALUE REAL,"
          "DATE TEXT,"
          "DUE_DATE TEXT,"
          "USER_ID INTEGER"
          ")");
    } catch (e) {}
    return;
  }
}
