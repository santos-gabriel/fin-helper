import 'package:finhelper/src/shared/database/DBProvider.dart';
import 'package:finhelper/src/shared/models/revenue_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class AddRevenueController {
  int userId;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RevenueModel model = RevenueModel();

  AddRevenueController({required this.userId}) {
    model = loadUserId();
  }

  loadUserId() {
    return this.model = this.model.copyWith(userId: this.userId);
  }

  String? validateDescription(String? value) =>
      value?.isEmpty ?? true ? "A descrição não pode ser vazia" : null;
  String? validateType(String? value) =>
      value?.isEmpty ?? true ? "O tipo não pode ser vazio" : null;
  String? validateValor(double value) =>
      value == 0 ? "Insira um valor maior que R\$ 0,00" : null;

  void onChange({String? description, String? type, double? value}) {
    model = model.copyWith(description: description, type: type, value: value);
  }

  Future<void> saveRevenue() async {
    DBProvider.db.newRevenue(model);
    return;
  }

  bool validate() {
    bool descValidade = model.description?.isEmpty ?? true ? false : true;
    bool typeValidade = model.type?.isEmpty ?? true ? false : true;
    bool valueValidade = model.value == 0 ? false : true;
    if (descValidade && typeValidade && valueValidade) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> cadastrarRevenue() async {
    model.date = DateFormat("yyyy-MM-dd").format(DateTime.now());
    if (validate()) {
      return await saveRevenue();
    }
  }

  Future<void> getById(int id) async {
    return await DBProvider.db.getById(id);
  }
}
