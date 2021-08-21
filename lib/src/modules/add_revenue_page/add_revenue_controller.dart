import 'package:finhelper/src/shared/models/revenue_model.dart';
import 'package:flutter/cupertino.dart';

class AddRevenueController {
  final formKey = GlobalKey<FormState>();
  RevenueModel model = RevenueModel();

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
    /*final instance = await SharedPreferences.getInstance();
    final revenue = instance.getStringList("revenue") ?? <String>[];
    revenue.add(model.toJson());
    await instance.setStringList("revenue", revenue);*/
    return;
  }

  Future<void> cadastrarRevenue() async {
    final form = formKey.currentState;
    if (form!.validate()) {
      return await saveRevenue();
    }
  }
}
