import 'package:animated_card/animated_card.dart';
import 'package:finhelper/src/modules/expenses/expenses_controller.dart';
import 'package:finhelper/src/shared/components/card_movement/card_movement.dart';
import 'package:finhelper/src/shared/components/daily_movement/daily_movement.dart';
import 'package:finhelper/src/shared/models/expense_model.dart';
import 'package:finhelper/src/shared/themes/app_colors.dart';
import 'package:finhelper/src/shared/utils/date-util.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpensesPage extends StatefulWidget {
  const ExpensesPage({Key? key}) : super(key: key);

  @override
  _ExpensesPageState createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  NumberFormat formater = NumberFormat("00.00");
  ExpensesController controller = ExpensesController();
  List<ExpenseModel> listExpenses = List.empty(growable: true);
  Map<String, List<ExpenseModel>> listDay = Map();
  List<Widget> widgets = List.empty(growable: true);

  loadExpenses() async {
    listExpenses.clear();
    listDay.clear();
    listExpenses = await controller.getAll();
    listExpenses.forEach((element) {
      if (listDay.containsKey(element.date)) {
        listDay[element.date]!.add(element);
      } else {
        List<ExpenseModel> listAux = List.empty(growable: true);
        listAux.add(element);
        listDay[element.date!] = listAux;
      }
    });
  }

  getFields() async {
    await loadExpenses();
    double sum = 0;

    List<CardMovement> widgetsChilds = List.empty(growable: true);
    listDay.forEach((key, value) {
      widgetsChilds.clear();
      value.forEach((element) {
        widgetsChilds.add(CardMovement(
          cardColors: AppColors.expense,
          icon: Icon(
            Icons.trending_down,
            color: AppColors.whiteSoft,
          ),
          description: element.description!,
          type: element.type!,
          value: 'R\$ ${formater.format(element.value)}',
        ));
        sum = sum + element.value!;
      });
      widgets.add(DailyMovement(
        movements: List.from(widgetsChilds),
        title: '${DateUtil.getDay(key)} de ${DateUtil.getMonthExtensive(key)}',
        subTitle: 'Saldo do dia R\$ ${formater.format(sum)}',
      ));
    });
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getFields(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 40,
            ),
            child: AnimatedCard(
              child: ListView(children: widgets),
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 40,
            ),
            child: ListView(
              children: [],
            ),
          );
        }
      },
    );
  }
}
