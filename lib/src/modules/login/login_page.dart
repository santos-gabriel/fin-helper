import 'package:finhelper/src/modules/login/login_controller.dart';
import 'package:finhelper/src/shared/components/custom_input_text/custom_input_text.dart';
import 'package:finhelper/src/shared/components/social_login/social_login_button.dart';
import 'package:finhelper/src/shared/themes/app_colors.dart';
import 'package:finhelper/src/shared/themes/app_images.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isShowingPassword = false;
  String login = '';
  String password = '';
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
              bottom: 100,
              right: 20,
              left: 20,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: CustomInputText(
                        label: 'Login',
                        onChanged: (value) {
                          setState(() {
                            login = value;
                          });
                        },
                        style: TextStyle(),
                        labelStyle: TextStyle(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: CustomInputText(
                        label: 'Password',
                        onChanged: (value) {
                          setState(() {
                            password = value;
                          });
                        },
                        style: TextStyle(),
                        labelStyle: TextStyle(),
                        isObscure: isShowingPassword,
                        isEnableAutocorrect: false,
                        isEnableSuggestions: false,
                        sufixIconWidget: GestureDetector(
                          onTap: () {
                            setState(() {
                              isShowingPassword = !isShowingPassword;
                            });
                          },
                          child: Icon(
                            isShowingPassword
                                ? Icons.remove_red_eye
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (login.isNotEmpty && password.isNotEmpty) {
                              controller.localSignUp(context, login, password);
                            }
                          },
                          child: Text(
                            'Registre-se aqui',
                            style: TextStyle(
                              color: AppColors.graySoft,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(10),
                          ),
                          onPressed: () async {
                            if (login.isNotEmpty && password.isNotEmpty) {
                              controller.localSignIn(context, login, password);
                            }
                          },
                          child: Icon(
                            Icons.arrow_right_alt_sharp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
              // child: SocialLoginButton(
              //   onTap: () {
              //     controller.googleSignIn(context);
              //   },
              // ),
              ),
        ],
      ),
    );
  }
}
