import 'package:finhelper/src/modules/home/home_controller.dart';
import 'package:finhelper/src/shared/database/DBProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:finhelper/src/shared/themes/app_text_styles.dart';

enum CardMovementTypeMovement { Revenues, Expenses }

class CardMovement extends StatelessWidget {
  final int id;
  final CardMovementTypeMovement typeMovement;
  final Icon icon;
  final String description;
  final String type;
  final String value;
  final Color cardColors;
  final TextStyle? descriptionTextStyle;
  final TextStyle? typeTextStyle;

  const CardMovement({
    Key? key,
    required this.id,
    required this.typeMovement,
    required this.icon,
    required this.description,
    required this.type,
    required this.value,
    required this.cardColors,
    this.descriptionTextStyle,
    this.typeTextStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<HomeController>();
    var _tapPosition;
    return GestureDetector(
      onTapDown: (details) {
        _tapPosition = details.globalPosition;
      },
      onLongPress: () {
        double left = _tapPosition.dx;
        double top = _tapPosition.dy;
        showMenu(
          context: context,
          position: RelativeRect.fromLTRB(left, top, 0, 0),
          items: <PopupMenuEntry>[
            PopupMenuItem(
                onTap: () async {
                  if (typeMovement == CardMovementTypeMovement.Expenses) {
                    await DBProvider.db.deleteExpenseById(id);
                    controller.setCurrentPage(controller.currentPage);
                  } else if (typeMovement ==
                      CardMovementTypeMovement.Revenues) {
                    await DBProvider.db.deleteRevenueById(id);
                    controller.setCurrentPage(controller.currentPage);
                  }
                },
                value: 1,
                child: Row(
                  children: [
                    Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    Text(
                      'Delete',
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                )),
          ],
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Container(
          width: double.infinity,
          height: 50,
          color: cardColors,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              icon,
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text.rich(
                    TextSpan(
                      style: descriptionTextStyle ??
                          AppTextStyles.titleMovementWhite,
                      text: description + '\n',
                      children: [
                        TextSpan(
                          style: typeTextStyle ??
                              AppTextStyles.subTitleMovementWhite,
                          text: type,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Text(
                value,
                style: AppTextStyles.subTitleMovementWhite,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
