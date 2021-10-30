import 'package:animated_card/animated_card.dart';
import 'package:finhelper/src/modules/extract/extract_controller.dart';
import 'package:finhelper/src/shared/components/card_movement/card_movement.dart';
import 'package:finhelper/src/shared/components/daily_movement/daily_movement.dart';
import 'package:finhelper/src/shared/models/movement_model.dart';
import 'package:finhelper/src/shared/themes/app_colors.dart';
import 'package:finhelper/src/shared/utils/date-util.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExtractPage extends StatefulWidget {
  const ExtractPage({Key? key}) : super(key: key);

  @override
  _ExtractPageState createState() => _ExtractPageState();
}

class _ExtractPageState extends State<ExtractPage> {
  NumberFormat formater = NumberFormat("00.00");
  ExtractController controller = ExtractController();
  List<MovementModel> listMovements = List.empty(growable: true);
  Map<String, List<MovementModel>> listDay = Map();
  List<Widget> widgets = List.empty(growable: true);

  loadMovements() async {
    listMovements.clear();
    listDay.clear();
    listMovements = await controller.getAllMovements();
    listMovements.forEach((element) {
      if (listDay.containsKey(element.date)) {
        listDay[element.date]!.add(element);
      } else {
        List<MovementModel> listAux = List.empty(growable: true);
        listAux.add(element);
        listDay[element.date!] = listAux;
      }
    });
  }

  getFields() async {
    await loadMovements();
    double sum = 0;

    List<CardMovement> widgetsChilds = List.empty(growable: true);
    listDay.forEach((key, value) {
      widgetsChilds.clear();
      value.forEach((element) {
        widgetsChilds.add(CardMovement(
          cardColors: element.type!.toUpperCase().contains('DESPESA')
              ? AppColors.expense
              : AppColors.revenue,
          icon: Icon(
            element.type!.toUpperCase().contains('DESPESA')
                ? Icons.trending_down
                : Icons.trending_up,
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
