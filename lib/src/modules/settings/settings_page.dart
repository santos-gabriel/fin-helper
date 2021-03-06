import 'package:finhelper/src/modules/settings/settings_controller.dart';
import 'package:finhelper/src/shared/auth/auth_controller.dart';
import 'package:finhelper/src/shared/themes/app_colors.dart';
import 'package:finhelper/src/shared/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  SettingsController controller = SettingsController();
  final authController = AuthController();

  getSettings() async {
    return await controller.currentSettings();
  }

  @override
  Widget build(BuildContext context) {
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
        child: buildSettings(),
      ),
    );
  }

  buildSettings() {
    return FutureBuilder(
        future: getSettings(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: Text(
                    'Geral',
                    style: AppTextStyles.titlePagesBlack,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Notificações',
                      style: AppTextStyles.subTitleBlack,
                    ),
                    Switch(
                      value: controller.allowNotifications(),
                      onChanged: (value) {
                        setState(() {
                          controller.setAllowNotifications(value);
                        });
                      },
                      activeColor: AppColors.secondary,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Lembrar login',
                      style: AppTextStyles.subTitleBlack,
                    ),
                    Switch(
                      value: controller.rememberLogin(),
                      onChanged: (value) {
                        setState(() {
                          controller.setRememberLogin(value);
                        });
                      },
                      activeColor: AppColors.secondary,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Solicitar senha ao entrar',
                      style: AppTextStyles.subTitleBlack,
                    ),
                    Switch(
                      value: controller.allowPasswordOnLogin(),
                      onChanged: (value) {
                        setState(() {
                          controller.setAllowPasswordOnLogin(value);
                        });
                      },
                      activeColor: AppColors.secondary,
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return alert();
                        });
                  },
                  child: Text(
                    'Encerrar conta',
                    style: TextStyle(
                      color: AppColors.whiteSoft,
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Container();
          }
        });
  }

  alert() {
    return AlertDialog(
      title: Text('Atenção'),
      content: Text(
          'Ao encerrar sua conta todos os seus dados serão deletados\nDeseja prosseguir? '),
      actions: [
        TextButton(
          child: Text(
            'Cancelar',
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        TextButton(
            child: Text(
              'Continuar',
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () {
              authController.clearUser(context);
            }),
      ],
    );
  }
}
