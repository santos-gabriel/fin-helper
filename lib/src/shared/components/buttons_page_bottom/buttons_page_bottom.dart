import 'package:finhelper/src/shared/components/custom_vertical_divider/custom_vertical_divider.dart';
import 'package:finhelper/src/shared/components/label_button/label_button.dart';
import 'package:finhelper/src/shared/themes/app_colors.dart';
import 'package:finhelper/src/shared/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

class ButtonsPageBottom extends StatelessWidget {
  final String primaryLabel;
  final VoidCallback primaryOnPressed;
  final String secondaryLabel;
  final VoidCallback secondaryOnPressed;
  final bool enablePrimaryColor;
  final bool enableSecondaryColor;

  const ButtonsPageBottom({
    Key? key,
    required this.primaryLabel,
    required this.primaryOnPressed,
    required this.secondaryLabel,
    required this.secondaryOnPressed,
    this.enablePrimaryColor = false,
    this.enableSecondaryColor = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      height: 47,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(
            thickness: 1,
            height: 1,
            color: AppColors.whiteDark,
          ),
          Container(
            height: 46,
            child: Row(
              children: [
                Expanded(
                  child: LabelButton(
                    label: primaryLabel,
                    onPressed: primaryOnPressed,
                    style:
                        enablePrimaryColor ? AppTextStyles.buttonPrimary : null,
                  ),
                ),
                CustomVerticalDivider(),
                Expanded(
                  child: LabelButton(
                    label: secondaryLabel,
                    onPressed: secondaryOnPressed,
                    style: enableSecondaryColor
                        ? AppTextStyles.buttonPrimary
                        : null,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
