import 'package:finhelper/src/modules/add_expense_page/add_expense_page.dart';
import 'package:finhelper/src/modules/add_revenue_page/add_revenue_page.dart';
import 'package:finhelper/src/modules/home/home_controller.dart';
import 'package:finhelper/src/modules/home/home_page.dart';
import 'package:finhelper/src/modules/login/login_page.dart';
import 'package:finhelper/src/modules/login_local_auth/login_local_auth_page.dart';
import 'package:finhelper/src/modules/login_photo/login_photo_page.dart';
import 'package:finhelper/src/modules/settings/settings_page.dart';
import 'package:finhelper/src/modules/splash/splash_page.dart';
import 'package:finhelper/src/shared/models/user_model.dart';
import 'package:finhelper/src/shared/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AppWidget extends StatelessWidget {
  AppWidget() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Fin Helper",
        theme: ThemeData(
          primarySwatch: AppColors.primarySwatchColor,
          primaryColor: AppColors.primary,
        ),
        initialRoute: "/splash",
        routes: {
          "/splash": (context) => SplashPage(),
          "/settings": (context) => SettingsPage(),
          "/add-revenue": (context) => AddRevenuePage(
                user: ModalRoute.of(context)!.settings.arguments as UserModel,
              ),
          "/add-expense": (context) => AddExpensePage(
                user: ModalRoute.of(context)!.settings.arguments as UserModel,
              ),
          "/login": (context) => LoginPage(),
          "/login-local-auth": (context) => LoginLocalAuthPage(
                user: ModalRoute.of(context)!.settings.arguments as UserModel,
              ),
          "/login-photo": (context) => LoginPhotoPage(
                user: ModalRoute.of(context)!.settings.arguments as UserModel,
              ),
          "/home": (context) => HomePage(
                user: ModalRoute.of(context)!.settings.arguments as UserModel,
              ),
        },
      ),
    );
  }
}
