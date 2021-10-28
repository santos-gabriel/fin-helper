import 'package:finhelper/src/modules/expenses/expenses_page.dart';
import 'package:finhelper/src/modules/extract/extract_page.dart';
import 'package:finhelper/src/modules/revenues/revenues_page.dart';
import 'package:finhelper/src/modules/settings/settings_controller.dart';
import 'package:finhelper/src/shared/themes/app_text_styles.dart';
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

  bool seeBalance = true;
  @override
  Widget build(BuildContext context) {
    final controller = context.watch<HomeController>();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(200),
        child: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(
              Duration(seconds: 2),
              () => {
                setState(() {
                  controller.setCurrentPage(BodyHomePages.Extract);
                })
              },
            );
          },
          child: ListView(
            children: [
              Container(
                height: 200,
                color: AppColors.blueSoft,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 5,
                    right: 5,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text.rich(
                              TextSpan(
                                text: "Olá ${widget.user.name} \n",
                                style: AppTextStyles.titleWhiteBold,
                                children: [
                                  TextSpan(
                                    text: "Seja bem vindo",
                                    style: AppTextStyles.subTitleWhiteSoft,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 48,
                            width: 48,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                                  image: NetworkImage(
                                widget.user.photoURL!,
                              )),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text.rich(TextSpan(
                              text: "Saldo ",
                              style: AppTextStyles.subTitleWhiteSoft,
                              children: [
                                WidgetSpan(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 2.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          seeBalance = !seeBalance;
                                        });
                                      },
                                      child: seeBalance
                                          ? Icon(
                                              Icons.remove_red_eye,
                                              color: AppColors.whiteSoft,
                                            )
                                          : Icon(
                                              Icons.visibility_off,
                                              color: AppColors.whiteSoft,
                                            ),
                                    ),
                                  ),
                                ),
                                TextSpan(
                                  text: "\nR\$ ",
                                  style: AppTextStyles.subTitleWhiteSoft,
                                  children: [
                                    seeBalance
                                        ? TextSpan(
                                            text: "${formater.format(100.00)} ",
                                            style:
                                                AppTextStyles.subTitleWhiteSoft,
                                          )
                                        : TextSpan(
                                            text: "            ",
                                            style: TextStyle(
                                              backgroundColor:
                                                  AppColors.blueHardSoft,
                                            ),
                                          ),
                                  ],
                                ),
                              ],
                            )),
                          ),
                          Container(
                            child: GestureDetector(
                              child: Icon(
                                settingsController.allowNotifications()
                                    ? Icons.notifications
                                    : Icons.notifications_off,
                                color: AppColors.whiteSoft,
                              ),
                              onTap: () {
                                setState(() {
                                  settingsController.setAllowNotifications(
                                      !settingsController.allowNotifications());
                                });
                              },
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
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
      bottomNavigationBar: CustomBnb(),
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
                Navigator.of(context).pushNamed('/add-expense');
              }),
          SpeedDialChild(
              child: Icon(Icons.trending_up),
              label: "Receitas",
              backgroundColor: AppColors.secondary,
              foregroundColor: AppColors.whiteSoft,
              onTap: () {
                Navigator.of(context).pushNamed('/add-revenue');
              }),
        ],
      ),
    );
  }
}
