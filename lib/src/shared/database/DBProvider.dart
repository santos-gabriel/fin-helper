import 'dart:io';

import 'package:finhelper/src/shared/models/expense_model.dart';
import 'package:finhelper/src/shared/models/revenue_model.dart';
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
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE REVENUE ("
          "ID INTEGER PRIMARY KEY AUTOINCREMENT,"
          "DESCRIPTION TEXT,"
          "TYPE TEXT,"
          "VALUE REAL,"
          "DATE TEXT"
          ")");
    });
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
      print(modelList.length);
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
      print('***modelList.length: ${modelList.length}');
      return modelList;
    }
    return modelList;
  }

  clearAll() async {
    final db = await database;
    //getAllExpenses();
    await db!.rawDelete('DELETE FROM REVENUE');
    await db.rawDelete('DELETE FROM EXPENSE');
    return;
  }
}
