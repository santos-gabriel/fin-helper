import 'package:finhelper/src/modules/login/login_controller.dart';
import 'package:finhelper/src/shared/components/social_login/social_login_button.dart';
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
      backgroundColor: AppColors.graySoft,
      body: Stack(
        children: [
          Positioned(
            top: 100,
            left: 20,
            right: 20,
            child: Image.asset(AppImages.logoFull),
          ),
          Positioned(
            bottom: 100,
            right: 20,
            left: 20,
            child: SocialLoginButton(
              onTap: () {
                controller.googleSignIn(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
