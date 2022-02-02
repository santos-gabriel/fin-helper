import 'package:finhelper/src/shared/themes/app_images.dart';
import 'package:finhelper/src/shared/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

class EmptyBalance extends StatelessWidget {
  const EmptyBalance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Image.asset(AppImages.emptyBalance),
          Divider(
            thickness: 1,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Text(
              'Nada por aqui',
              style: AppTextStyles.titleEmptyBalance,
            ),
          ),
        ],
      ),
    );
  }
}
