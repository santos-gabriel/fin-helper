import 'package:finhelper/src/shared/database/DBProvider.dart';
import 'package:finhelper/src/shared/models/expense_model.dart';

class ExpensesController {
  Future<List<ExpenseModel>> getAll() async {
    return await DBProvider.db.getAllExpenses();
  }
}
