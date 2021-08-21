import 'package:finhelper/src/shared/themes/app_colors.dart';
import 'package:flutter/material.dart';

class CustomVerticalDivider extends StatelessWidget {
  const CustomVerticalDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: double.maxFinite,
      color: AppColors.whiteDark,
    );
  }
}
