import 'package:finhelper/src/shared/auth/auth_controller.dart';
import 'package:finhelper/src/shared/themes/app_colors.dart';
import 'package:finhelper/src/shared/themes/app_images.dart';
import 'package:finhelper/src/shared/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authController = AuthController();
    authController.currentUser(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 80),
                child: Image.asset(
                  AppImages.logoFull,
                  width: 350,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 80),
                child: Text(
                  "Seu mais fiel ajudante de finanças",
                  style: AppTextStyles.titleSplash,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Text(
          "Lembre-se, FinHelper lhe ajuda a gerenciar suas finanças, mas o controle sempre será seu",
          style: AppTextStyles.textSplash,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
