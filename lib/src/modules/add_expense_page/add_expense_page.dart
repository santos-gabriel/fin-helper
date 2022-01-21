import 'package:finhelper/src/modules/add_expense_page/add_expense_controller.dart';
import 'package:finhelper/src/shared/components/buttons_page_bottom/buttons_page_bottom.dart';
import 'package:finhelper/src/shared/components/custom_dropdown_button/custom_dropdown_button.dart';
import 'package:finhelper/src/shared/components/custom_input_text/custom_input_text.dart';
import 'package:finhelper/src/shared/models/user_model.dart';
import 'package:finhelper/src/shared/themes/app_colors.dart';
import 'package:finhelper/src/shared/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class AddExpensePage extends StatefulWidget {
  final UserModel user;
  const AddExpensePage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  _AddExpensePageState createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  AddExpenseController? controller;
  final listTypes = ['Despesas fixas', 'Despesas não fixas'];

  final moneyInputTextController = MoneyMaskedTextController(
    leftSymbol: "R\$",
    decimalSeparator: ",",
  );

  final dueDateInputTextController = MaskedTextController(mask: "00/00/0000");

  loadController() {
    controller = AddExpenseController(userId: widget.user.id!);
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
                'Nova Despesa',
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 100,
                          child: CustomInputText(
                            label: 'Vencimento',
                            labelStyle: AppTextStyles.labelInputSecondary,
                            style: AppTextStyles.subTitleBlack,
                            controller: dueDateInputTextController,
                            keyboardType: TextInputType.datetime,
                            validator: controller!.validateDueDate,
                            onChanged: (value) {
                              controller!.onChange(dueDate: value);
                            },
                          ),
                        ),
                        Container(
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
                        )
                      ],
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
        primaryOnPressed: () {
          Navigator.pop(context);
        },
        secondaryLabel: "Confirmar",
        secondaryOnPressed: () async {
          if (controller!.model.type == null) {
            controller!.onChange(type: listTypes[0]);
          }
          await controller!.cadastrarExpense();
          Navigator.pop(context);
        },
        enableSecondaryColor: true,
      ),
    );
  }
}
