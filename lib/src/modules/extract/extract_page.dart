import 'package:finhelper/src/shared/components/card_movement/card_movement.dart';
import 'package:finhelper/src/shared/components/daily_movement/daily_movement.dart';
import 'package:finhelper/src/shared/themes/app_colors.dart';
import 'package:flutter/material.dart';

class ExtractPage extends StatefulWidget {
  const ExtractPage({Key? key}) : super(key: key);

  @override
  _ExtractPageState createState() => _ExtractPageState();
}

class _ExtractPageState extends State<ExtractPage> {
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
                  Icons.trending_down,
                  color: AppColors.whiteSoft,
                ),
                description: 'Descrição da despesa',
                type: 'Tipo de despesa',
                value: 'R\$ 25,00',
              ),
              CardMovement(
                cardColors: AppColors.revenue,
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
          DailyMovement(
            title: '1 de Julho',
            subTitle: 'Saldo do dia R\$ 50,00',
            movements: [
              CardMovement(
                cardColors: AppColors.revenue,
                icon: Icon(
                  Icons.trending_up,
                  color: AppColors.whiteSoft,
                ),
                description: 'Descrição da receita',
                type: 'Tipo de receita',
                value: 'R\$ 50,00',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
