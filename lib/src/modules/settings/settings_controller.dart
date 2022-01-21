import 'package:finhelper/src/shared/models/settings_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsController {
  SettingsModel? _settingsModel;

  SettingsModel get settings => _settingsModel!;

  Future<void> saveSettings(SettingsModel settings) async {
    final instance = await SharedPreferences.getInstance();
    await instance.setString("settings", settings.toJson());
  }

  setSettings(SettingsModel settings) {
    saveSettings(settings);
    _settingsModel = settings;
  }

  Future<SettingsModel?> currentSettings() async {
    final instance = await SharedPreferences.getInstance();
    // await Future.delayed(Duration(seconds: 2));
    if (instance.containsKey("settings")) {
      final json = instance.get("settings") as String;
      setSettings(SettingsModel.fromJson(json));
      return this.settings;
    } else {
      SettingsModel settings = SettingsModel(
          allowNotifications: false,
          allowPasswordOnLogin: false,
          rememberLogin: false);
      setSettings(settings);
      _settingsModel = settings;
    }
  }

  bool allowNotifications() {
    return _settingsModel!.allowNotifications;
  }

  bool allowPasswordOnLogin() {
    return _settingsModel!.allowPasswordOnLogin;
  }

  bool rememberLogin() {
    return _settingsModel!.rememberLogin;
  }

  void setAllowNotifications(bool value) {
    _settingsModel!.allowNotifications = value;
    saveSettings(settings);
  }

  void setAllowPasswordOnLogin(bool value) {
    _settingsModel!.allowPasswordOnLogin = value;
    saveSettings(settings);
  }

  void setRememberLogin(bool value) {
    _settingsModel!.rememberLogin = value;
    saveSettings(settings);
  }
}
