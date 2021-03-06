import 'dart:io';

import 'package:finhelper/src/shared/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:finhelper/src/modules/home/home_controller.dart';
import 'package:finhelper/src/modules/settings/settings_controller.dart';
import 'package:finhelper/src/shared/models/user_model.dart';
import 'package:finhelper/src/shared/themes/app_colors.dart';
import 'package:path_provider/path_provider.dart';

class CustomAppBar extends StatefulWidget {
  final HomeController controller;
  final SettingsController settingsController;
  final NumberFormat formater;
  final UserModel user;
  const CustomAppBar({
    Key? key,
    required this.controller,
    required this.settingsController,
    required this.formater,
    required this.user,
  }) : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  List<Widget> widgets = List.empty(growable: true);
  bool seeBalance = true;
  double balance = 0;
  File? imageUsr;

  getBalance() async {
    double balanceAux = await widget.controller.getBalance();
    setState(() {
      balance = balanceAux;
    });
  }

  getPhoto() async {
    final Directory path = await getApplicationDocumentsDirectory();
    final String pathStr = path.path;
    File? fileAux = File('$pathStr/user_${widget.user.id}.png');
    if (!await fileAux.exists()) {
      fileAux = null;
    }
    setState(() {
      imageUsr = fileAux;
    });
  }

  getSettings() async {
    return await widget.settingsController.currentSettings();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      getBalance();
      getPhoto();
      getSettings();
    });
  }

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(200),
      child: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(
            Duration(seconds: 2),
            () => {
              setState(() {
                widget.controller.setCurrentPage(BodyHomePages.Extract);
                getBalance();
                getPhoto();
              })
            },
          );
        },
        child: ListView(
          children: [
            FutureBuilder(
                future: dataCustomAppBar(),
                builder: (context, snaphot) {
                  if (snaphot.hasData) {
                    return Container(
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
                                      text: "Ol??, ${widget.user.name} \n",
                                      style: AppTextStyles.titleWhiteBold,
                                      children: [
                                        TextSpan(
                                          text: "Seja bem vindo",
                                          style:
                                              AppTextStyles.subTitleWhiteSoft,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                if (imageUsr != null)
                                  Container(
                                    height: 48,
                                    width: 48,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(5),
                                      image: DecorationImage(
                                        image: Image.file(imageUsr!).image,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text.rich(
                                    TextSpan(
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
                                                  if (seeBalance) {
                                                    widget.controller
                                                        .getBalance();
                                                  }
                                                });
                                              },
                                              child: seeBalance
                                                  ? Icon(
                                                      Icons.remove_red_eye,
                                                      color:
                                                          AppColors.whiteSoft,
                                                    )
                                                  : Icon(
                                                      Icons.visibility_off,
                                                      color:
                                                          AppColors.whiteSoft,
                                                    ),
                                            ),
                                          ),
                                        ),
                                        TextSpan(
                                          text: "\nR\$ ",
                                          style:
                                              AppTextStyles.subTitleWhiteSoft,
                                          children: [
                                            seeBalance
                                                ? TextSpan(
                                                    text:
                                                        "${widget.formater.format(balance)} ",
                                                    style: AppTextStyles
                                                        .subTitleWhiteSoft,
                                                  )
                                                : TextSpan(
                                                    text: "            ",
                                                    style: TextStyle(
                                                      backgroundColor: AppColors
                                                          .blueHardSoft,
                                                    ),
                                                  ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                buildNothifications(),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                }),
          ],
        ),
      ),
    );
  }

  dataCustomAppBar() async {
    await getBalance();
    await getPhoto();
    await getSettings();
    return 1;
  }

  buildNothifications() {
    return FutureBuilder(
        future: getSettings(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              child: GestureDetector(
                child: Icon(
                  widget.settingsController.allowNotifications()
                      ? Icons.notifications
                      : Icons.notifications_off,
                  color: AppColors.whiteSoft,
                ),
                onTap: () {
                  setState(() {
                    widget.settingsController.setAllowNotifications(
                        !widget.settingsController.allowNotifications());
                  });
                },
              ),
            );
          } else {
            return Container();
          }
        });
  }
}
