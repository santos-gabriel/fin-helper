import 'package:finhelper/src/modules/expenses/expenses_page.dart';
import 'package:finhelper/src/modules/extract/extract_page.dart';
import 'package:finhelper/src/modules/revenues/revenues_page.dart';
import 'package:finhelper/src/modules/settings/settings_controller.dart';
import 'package:finhelper/src/shared/components/custom_app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:finhelper/src/modules/home/home_controller.dart';
import 'package:finhelper/src/shared/components/custom_bnb/custom_bnb.dart';
import 'package:finhelper/src/shared/models/user_model.dart';
import 'package:finhelper/src/shared/themes/app_colors.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class HomePage extends StatefulWidget {
  final UserModel user;
  const HomePage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  SettingsController settingsController = SettingsController();
  NumberFormat formater = NumberFormat("00.00");

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<HomeController>();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(200),
        child: CustomAppBar(
          controller: controller,
          formater: formater,
          settingsController: settingsController,
          user: widget.user,
        ),
      ),
      body: [
        ExtractPage(
          key: UniqueKey(),
        ),
        RevenuesPage(
          key: UniqueKey(),
        ),
        ExpensesPage(
          key: UniqueKey(),
        ),
      ][controller.currentPage.index],
      bottomNavigationBar: CustomBnb(user: widget.user),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: SpeedDial(
        backgroundColor: AppColors.secondary,
        foregroundColor: AppColors.whiteSoft,
        closeManually: false,
        animatedIcon: AnimatedIcons.menu_close,
        overlayColor: Colors.transparent,
        overlayOpacity: 0,
        children: [
          SpeedDialChild(
              child: Icon(Icons.trending_down),
              label: "Despesas",
              backgroundColor: AppColors.secondary,
              foregroundColor: AppColors.whiteSoft,
              onTap: () {
                Navigator.of(context)
                    .pushNamed('/add-expense', arguments: widget.user);
              }),
          SpeedDialChild(
              child: Icon(Icons.trending_up),
              label: "Receitas",
              backgroundColor: AppColors.secondary,
              foregroundColor: AppColors.whiteSoft,
              onTap: () {
                Navigator.of(context)
                    .pushNamed('/add-revenue', arguments: widget.user);
              }),
        ],
      ),
    );
  }
}
