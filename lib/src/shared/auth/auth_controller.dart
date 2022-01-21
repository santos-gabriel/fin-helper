import 'dart:io';

import 'package:finhelper/src/modules/settings/settings_controller.dart';
import 'package:finhelper/src/shared/database/DBProvider.dart';
import 'package:finhelper/src/shared/models/settings_model.dart';
import 'package:finhelper/src/shared/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  UserModel? _user;

  UserModel get user => _user!;

  void setUser(BuildContext context, UserModel? user,
      {SettingsModel? settings}) {
    if (user != null) {
      saveUser(user);
      _user = user;
      if ((settings != null) &&
          ((settings.allowPasswordOnLogin) || (!settings.rememberLogin))) {
        Navigator.pushReplacementNamed(context, "/login-local-auth",
            arguments: user);
      } else {
        Navigator.pushReplacementNamed(context, "/home", arguments: user);
      }
    } else {
      Navigator.pushReplacementNamed(context, "/login");
    }
  }

  void setUserPhoto(BuildContext context, UserModel? user) {
    if (user != null) {
      saveUser(user);
      _user = user;
      Navigator.pushReplacementNamed(context, "/login-photo", arguments: user);
    } else {
      Navigator.pushReplacementNamed(context, "/login");
    }
  }

  Future<void> saveUser(UserModel user) async {
    final instance = await SharedPreferences.getInstance();
    await instance.setString("user", user.toJson());
  }

  Future<void> currentUser(BuildContext context, {bool? verifySettings}) async {
    final instance = await SharedPreferences.getInstance();
    await Future.delayed(Duration(seconds: 2));
    if (instance.containsKey("user")) {
      final json = instance.get("user") as String;
      if ((verifySettings != null) && (verifySettings == true)) {
        final SettingsController settingsController = SettingsController();
        await settingsController.currentSettings();
        setUser(context, UserModel.fromJson(json),
            settings: settingsController.settings);
      } else {
        setUser(context, UserModel.fromJson(json));
      }
      return;
    } else {
      setUser(context, null);
    }
  }

  Future<void> clearAllSavedPreferences(BuildContext context) async {
    final instance = await SharedPreferences.getInstance();
    await Future.delayed(Duration(seconds: 2));
    instance.clear();
  }

  Future<void> clearUser(BuildContext context) async {
    final instance = await SharedPreferences.getInstance();
    await DBProvider.db.clearAll();
    await Future.delayed(Duration(seconds: 2));
    instance.remove("user");
    instance.remove("settings");
    final Directory path = await getApplicationDocumentsDirectory();
    final String pathStr = path.path;
    final File file = File('$pathStr/user.png');
    if (await file.exists()) {
      await file.delete();
    }
    Navigator.pushReplacementNamed(context, "/login");
  }
}
