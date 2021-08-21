import 'package:finhelper/src/shared/components/card_movement/card_movement.dart';
import 'package:finhelper/src/shared/components/daily_movement/daily_movement.dart';
import 'package:finhelper/src/shared/themes/app_colors.dart';
import 'package:flutter/material.dart';

class ExpensesPage extends StatefulWidget {
  const ExpensesPage({Key? key}) : super(key: key);

  @override
  _ExpensesPageState createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
      child: ListView(
        children: [
          DailyMovement(
            title: '2 de Julho',
            subTitle: 'Saldo do dia R\$ 50,00',
            movements: [
              CardMovement(
                cardColors: AppColors.expense,
                icon: Icon(
                  Icons.trending_up,
                  color: AppColors.whiteSoft,
                ),
                description: 'Descrição da receita',
                type: 'Tipo de receita',
                value: 'R\$ 75,00',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
