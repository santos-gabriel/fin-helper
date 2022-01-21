import 'package:animated_card/animated_card.dart';
import 'package:finhelper/src/modules/revenues/revenues_controller.dart';
import 'package:finhelper/src/shared/components/card_movement/card_movement.dart';
import 'package:finhelper/src/shared/components/daily_movement/daily_movement.dart';
import 'package:finhelper/src/shared/models/revenue_model.dart';
import 'package:finhelper/src/shared/themes/app_colors.dart';
import 'package:finhelper/src/shared/utils/date-util.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RevenuesPage extends StatefulWidget {
  const RevenuesPage({Key? key}) : super(key: key);

  @override
  _RevenuesPageState createState() => _RevenuesPageState();
}

class _RevenuesPageState extends State<RevenuesPage> {
  NumberFormat formater = NumberFormat("00.00");
  RevenuesController controller = RevenuesController();
  List<RevenueModel> listRevenues = List.empty(growable: true);
  Map<String, List<RevenueModel>> listDay = Map();
  List<Widget> widgets = List.empty(growable: true);

  loadRevenues() async {
    listRevenues.clear();
    listDay.clear();
    listRevenues = await controller.getAll();
    listRevenues.forEach((element) {
      if (listDay.containsKey(element.date)) {
        listDay[element.date]!.add(element);
      } else {
        List<RevenueModel> listAux = List.empty(growable: true);
        listAux.add(element);
        listDay[element.date!] = listAux;
      }
    });
  }

  getFields() async {
    await loadRevenues();
    double sum = 0;
    //widgets.clear();
    List<CardMovement> widgetsChilds = List.empty(growable: true);
    listDay.forEach((key, value) {
      widgetsChilds.clear();
      value.forEach((element) {
        widgetsChilds.add(CardMovement(
          id: element.id!,
          typeMovement: CardMovementTypeMovement.Revenues,
          cardColors: AppColors.revenue,
          icon: Icon(
            Icons.trending_up,
            color: AppColors.whiteSoft,
          ),
          description: element.description!,
          type: element.type!,
          value: 'R\$ ${formater.format(element.value)}',
        ));
        sum = sum + element.value!;
      });

      widgets.add(DailyMovement(
        title: '${DateUtil.getDay(key)} de ${DateUtil.getMonthExtensive(key)}',
        subTitle: 'Saldo do dia R\$ ${formater.format(sum)}',
        movements: List.from(widgetsChilds),
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
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
            child: AnimatedCard(
              child: ListView(children: widgets),
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
            child: ListView(children: []),
          );
        }
      },
    );
  }
}
