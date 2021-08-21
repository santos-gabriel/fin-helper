import 'package:flutter/material.dart';

import 'package:finhelper/src/shared/components/card_movement/card_movement.dart';
import 'package:finhelper/src/shared/themes/app_text_styles.dart';

class DailyMovement extends StatelessWidget {
  final List<CardMovement> movements;
  final String title;
  final String subTitle;

  const DailyMovement({
    Key? key,
    required this.movements,
    required this.title,
    required this.subTitle,
  }) : super(key: key);

  List<Widget> generateChildren() {
    List<Widget> list = List.empty(growable: true);
    list.add(
      Text.rich(
        TextSpan(
          style: AppTextStyles.titleBlack,
          text: title + '\n',
          children: [
            TextSpan(
              style: AppTextStyles.subTitleBlack,
              text: subTitle,
            ),
          ],
        ),
      ),
    );
    for (CardMovement c in movements) {
      list.add(c);
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: generateChildren(),
      ),
    );
  }
}
