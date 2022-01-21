import 'dart:convert';

class SettingsModel {
  bool allowNotifications;
  bool allowPasswordOnLogin;
  bool rememberLogin;

  SettingsModel({
    required this.allowNotifications,
    required this.allowPasswordOnLogin,
    required this.rememberLogin,
  });

  SettingsModel copyWith({
    bool? allowNotifications,
    bool? allowPasswordOnLogin,
    bool? rememberLogin,
  }) {
    return SettingsModel(
      allowNotifications: allowNotifications ?? this.allowNotifications,
      allowPasswordOnLogin: allowPasswordOnLogin ?? this.allowPasswordOnLogin,
      rememberLogin: rememberLogin ?? this.rememberLogin,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'allowNotifications': allowNotifications,
      'allowPasswordOnLogin': allowPasswordOnLogin,
      'rememberLogin': rememberLogin,
    };
  }

  factory SettingsModel.fromMap(Map<String, dynamic> map) {
    return SettingsModel(
      allowNotifications: map['allowNotifications'] ?? false,
      allowPasswordOnLogin: map['allowPasswordOnLogin'] ?? false,
      rememberLogin: map['rememberLogin'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory SettingsModel.fromJson(String source) =>
      SettingsModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'SettingsModel(allowNotifications: $allowNotifications, allowPasswordOnLogin: $allowPasswordOnLogin, rememberLogin: $rememberLogin)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SettingsModel &&
        other.allowNotifications == allowNotifications &&
        other.allowPasswordOnLogin == allowPasswordOnLogin &&
        other.rememberLogin == rememberLogin;
  }

  @override
  int get hashCode =>
      allowNotifications.hashCode ^
      allowPasswordOnLogin.hashCode ^
      rememberLogin.hashCode;
}
