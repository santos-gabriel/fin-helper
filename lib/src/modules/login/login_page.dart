import 'package:finhelper/src/modules/login/login_controller.dart';
import 'package:finhelper/src/shared/components/custom_input_text/custom_input_text.dart';
import 'package:finhelper/src/shared/themes/app_colors.dart';
import 'package:finhelper/src/shared/themes/app_images.dart';
import 'package:finhelper/src/shared/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    final controller = LoginController();
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.whiteMedium,
      body: Stack(
        children: [
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Container(
              height: 150,
              width: 150,
              child: Image.asset(AppImages.logoFull),
            ),
          ),
          Positioned(
            top: 250,
            left: 20,
            right: 20,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text.rich(
                    TextSpan(
                        text: 'Olá... \n',
                        style: AppTextStyles.titlePagesBlack,
                        children: [
                          TextSpan(
                            text: 'Precisamos de apenas algumas informações \n',
                            style: AppTextStyles.buttonGray,
                          ),
                          TextSpan(
                            text: 'Para começarmos, infome seu nome ',
                            style: AppTextStyles.buttonGray,
                          ),
                        ]),
                  ),
                ]),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            left: 20,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 50),
                    child: CustomInputText(
                      label: 'Informe seu nome',
                      onChanged: (value) {
                        controller.onChange(prName: value);
                      },
                      style: TextStyle(),
                      labelStyle: TextStyle(),
                      validator: controller.validateName,
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(10),
                    ),
                    onPressed: () async {
                      controller.localSignIn(context);
                    },
                    child: Icon(
                      Icons.arrow_right_alt_sharp,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
