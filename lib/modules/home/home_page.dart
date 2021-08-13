import 'package:finhelper/modules/expanses/expanses_page.dart';
import 'package:finhelper/modules/extract/extract_page.dart';
import 'package:finhelper/modules/revenues/revenues_page.dart';
import 'package:finhelper/modules/settings/settings_page.dart';
import 'package:finhelper/shared/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

import 'package:finhelper/modules/home/home_controller.dart';
import 'package:finhelper/shared/components/custom_bnb/custom_bnb.dart';
import 'package:finhelper/shared/components/custom_fab/custom_fab.dart';
import 'package:finhelper/shared/models/user_model.dart';
import 'package:finhelper/shared/themes/app_colors.dart';

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
  final controller = HomeController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(200),
        child: Container(
          color: AppColors.blueSoft,
          child: RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(
                  Duration(seconds: 2),
                  () => {
                        setState(() {
                          controller.setCurrentPage(0);
                        })
                      });
            },
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 2.0),
                                child: Icon(
                                  Icons.remove_red_eye,
                                  color: AppColors.whiteSoft,
                                ),
                              ),
                            ),
                            TextSpan(
                              text: "\nR\$ ${100.00} ",
                              style: AppTextStyles.subTitleWhiteSoft,
                            ),
                          ],
                        )),
                      ),
                      Container(
                        child: Icon(
                          Icons.notifications,
                          color: AppColors.whiteSoft,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: [
        SettingsPage(
          key: UniqueKey(),
        ),
        RevenuesPage(
          key: UniqueKey(),
        ),
        ExpansesPage(
          key: UniqueKey(),
        ),
        ExtractPage(
          key: UniqueKey(),
        ),
      ][controller.currentPage],
      // bottomNavigationBar: CustomBnb(),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10.0,
        color: AppColors.blueSoft,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: IconButton(
                onPressed: () {
                  setState(() {
                    controller.setCurrentPage(0);
                  });
                },
                icon: Icon(
                  Icons.settings,
                  color: controller.currentPage == 0
                      ? AppColors.orangeMedium
                      : AppColors.whiteSoft,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: IconButton(
                onPressed: () {
                  setState(() {
                    controller.setCurrentPage(1);
                  });
                },
                icon: Icon(
                  Icons.trending_up,
                  color: controller.currentPage == 1
                      ? AppColors.orangeMedium
                      : AppColors.whiteSoft,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: IconButton(
                onPressed: () {
                  setState(() {
                    controller.setCurrentPage(2);
                  });
                },
                icon: Icon(
                  Icons.trending_down,
                  color: controller.currentPage == 2
                      ? AppColors.orangeMedium
                      : AppColors.whiteSoft,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: IconButton(
                onPressed: () {
                  setState(() {
                    controller.setCurrentPage(3);
                  });
                },
                icon: Icon(
                  Icons.toc,
                  color: controller.currentPage == 3
                      ? AppColors.orangeMedium
                      : AppColors.whiteSoft,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: CustomFab(),
    );
  }
}
