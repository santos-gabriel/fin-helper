class SettingsModel {
  bool allowNotifications;
  bool allowPasswordOnLogin;
  bool rememberLogin;

  SettingsModel({
    required this.allowNotifications,
    required this.allowPasswordOnLogin,
    required this.rememberLogin,
  });
}
