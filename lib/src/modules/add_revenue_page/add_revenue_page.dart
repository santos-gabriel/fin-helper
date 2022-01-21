import 'package:finhelper/src/modules/add_revenue_page/add_revenue_controller.dart';
import 'package:finhelper/src/shared/components/buttons_page_bottom/buttons_page_bottom.dart';
import 'package:finhelper/src/shared/components/custom_dropdown_button/custom_dropdown_button.dart';
import 'package:finhelper/src/shared/components/custom_input_text/custom_input_text.dart';
import 'package:finhelper/src/shared/models/user_model.dart';
import 'package:finhelper/src/shared/themes/app_colors.dart';
import 'package:finhelper/src/shared/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class AddRevenuePage extends StatefulWidget {
  final UserModel user;
  const AddRevenuePage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  AaddRevenuePageState createState() => AaddRevenuePageState();
}

class AaddRevenuePageState extends State<AddRevenuePage> {
  AddRevenueController? controller;
  final listTypes = ['Receitas fixas', 'Receitas não fixas'];
  final moneyInputTextController =
      MoneyMaskedTextController(leftSymbol: "R\$", decimalSeparator: ",");

  loadController() {
    controller = AddRevenueController(userId: widget.user.id!);
  }

  @override
  Widget build(BuildContext context) {
    loadController();
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: BackButton(
          color: AppColors.grayMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 25),
              child: Text(
                'Nova Receita',
                style: AppTextStyles.titlePagesBlack,
              ),
            ),
            Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: CustomInputText(
                      label: 'Descrição',
                      labelStyle: AppTextStyles.labelInputSecondary,
                      style: AppTextStyles.subTitleBlack,
                      validator: controller!.validateDescription,
                      onChanged: (value) {
                        controller!.onChange(description: value);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: CustomDropdownButton(
                      types: listTypes,
                      isExpanded: true,
                      validator: controller!.validateType,
                      onChanged: (value) {
                        controller!.onChange(type: value);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Container(
                      width: 100,
                      child: CustomInputText(
                        label: 'Valor',
                        labelStyle: AppTextStyles.labelInputSecondary,
                        style: AppTextStyles.subTitleBlack,
                        controller: moneyInputTextController,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          controller!.onChange(
                              value: moneyInputTextController.numberValue);
                        },
                        validator: (_) => controller!.validateValor(
                            moneyInputTextController.numberValue),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: ButtonsPageBottom(
        primaryLabel: "Cancelar",
        primaryOnPressed: () async {
          // await controller.getById(1);
          Navigator.pop(context);
        },
        secondaryLabel: "Confirmar",
        secondaryOnPressed: () async {
          if (controller!.model.type == null) {
            controller!.onChange(type: listTypes[0]);
          }
          await controller!.cadastrarRevenue();
          Navigator.pop(context);
        },
        enableSecondaryColor: true,
      ),
    );
  }
}
