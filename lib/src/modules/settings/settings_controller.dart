import 'package:finhelper/src/shared/models/settings_model.dart';

class SettingsController {
  SettingsModel? _settingsModel;

  SettingsModel get settings => _settingsModel!;

  bool allowNotifications() {
    if (_settingsModel == null) {
      _settingsModel = SettingsModel(
        allowNotifications: false,
        allowPasswordOnLogin: false,
        rememberLogin: false,
      );
    }
    return _settingsModel!.allowNotifications;
  }

  bool allowPasswordOnLogin() {
    if (_settingsModel == null) {
      _settingsModel = SettingsModel(
        allowNotifications: false,
        allowPasswordOnLogin: false,
        rememberLogin: false,
      );
    }
    return _settingsModel!.allowPasswordOnLogin;
  }

  bool rememberLogin() {
    if (_settingsModel == null) {
      _settingsModel = SettingsModel(
        allowNotifications: false,
        allowPasswordOnLogin: false,
        rememberLogin: false,
      );
    }
    return _settingsModel!.rememberLogin;
  }

  void setAllowNotifications(bool value) {
    if (_settingsModel == null) {
      _settingsModel = SettingsModel(
        allowNotifications: false,
        allowPasswordOnLogin: false,
        rememberLogin: false,
      );
    }
    _settingsModel!.allowNotifications = value;
  }

  void setAllowPasswordOnLogin(bool value) {
    if (_settingsModel == null) {
      _settingsModel = SettingsModel(
        allowNotifications: false,
        allowPasswordOnLogin: false,
        rememberLogin: false,
      );
    }
    _settingsModel!.allowPasswordOnLogin = value;
  }

  void setRememberLogin(bool value) {
    if (_settingsModel == null) {
      _settingsModel = SettingsModel(
        allowNotifications: false,
        allowPasswordOnLogin: false,
        rememberLogin: false,
      );
    }
    _settingsModel!.rememberLogin = value;
  }
}
