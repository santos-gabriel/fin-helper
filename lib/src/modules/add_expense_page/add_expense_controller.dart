import 'package:finhelper/src/shared/database/DBProvider.dart';
import 'package:finhelper/src/shared/models/expense_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class AddExpenseController {
  final formKey = GlobalKey<FormState>();

  ExpenseModel model = ExpenseModel();

  String? validateDescription(String? value) =>
      value?.isEmpty ?? true ? "A descrição não pode ser vazia" : null;
  String? validateType(String? value) =>
      value?.isEmpty ?? true ? "O tipo não pode ser vazio" : null;
  String? validateValor(double value) =>
      value == 0 ? "Insira um valor maior que R\$ 0,00" : null;
  String? validateDueDate(String? value) =>
      value?.isEmpty ?? true ? "A data de vencimento não pode ser vazia" : null;

  void onChange(
      {String? description, String? type, double? value, String? dueDate}) {
    model = model.copyWith(
        description: description, type: type, value: value, dueDate: dueDate);
  }

  bool validate() {
    bool descValidade = model.description?.isEmpty ?? true ? false : true;
    bool dueDateValidade = model.dueDate?.isEmpty ?? true ? false : true;
    bool typeValidade = model.type?.isEmpty ?? true ? false : true;
    bool valueValidade = model.value == 0 ? false : true;
    if (descValidade && typeValidade && valueValidade && dueDateValidade) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> saveExpense() async {
    DBProvider.db.newExpense(model);
    return;
  }

  Future<void> cadastrarExpense() async {
    model.date = DateFormat("yyyy-MM-dd").format(DateTime.now());
    if (validate()) {
      return await saveExpense();
    }
    return;
    // final form = formKey.currentState;
    // if (form!.validate()) {
    //   return await saveExpense();
    // }
  }
}
