import 'package:flutter/material.dart';

import 'package:finhelper/src/shared/themes/app_text_styles.dart';

class CardMovement extends StatelessWidget {
  final Icon icon;
  final String description;
  final String type;
  final String value;
  final Color cardColors;
  final TextStyle? descriptionTextStyle;
  final TextStyle? typeTextStyle;

  const CardMovement({
    Key? key,
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
    return Padding(
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
    );
  }
}
