import 'package:finhelper/src/shared/models/user_model.dart';
import 'package:finhelper/src/shared/themes/app_colors.dart';
import 'package:finhelper/src/shared/themes/app_images.dart';
import 'package:finhelper/src/shared/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

class LoginLocalAuthPage extends StatefulWidget {
  final UserModel user;
  const LoginLocalAuthPage({Key? key, required this.user}) : super(key: key);

  @override
  _LoginLocalAuthPageState createState() => _LoginLocalAuthPageState();
}

class _LoginLocalAuthPageState extends State<LoginLocalAuthPage> {
  redirectToHomePage() {
    Navigator.pushReplacementNamed(context, "/home", arguments: widget.user);
  }

  loginLocalAuth() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteMedium,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Container(
              height: 250,
              width: 250,
              child: Image.asset(AppImages.logoFull),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 20,
              left: 50,
              right: 50,
            ),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: InkWell(
                  onTap: () async {
                    loginLocalAuth();
                  },
                  child: Container(
                    height: 56,
                    decoration: BoxDecoration(
                      color: AppColors.whiteSoft,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.fromBorderSide(
                          BorderSide(color: AppColors.graySoft)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text(
                                  "Acessar",
                                  style: AppTextStyles.titleGraySoftRegular,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 16,
                              ),
                              Icon(Icons.arrow_right_alt_sharp),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
