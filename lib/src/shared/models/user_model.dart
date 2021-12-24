import 'dart:convert';

class UserModel {
  final String name;
  final String? photoURL;
  final String? password;

  UserModel({required this.name, this.photoURL, this.password});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'],
      photoURL: map['photoURL'],
      password: map['password'],
    );
  }

  factory UserModel.fromJson(String json) =>
      UserModel.fromMap(jsonDecode(json));

  Map<String, dynamic> toMap() => {
        "name": name,
        "photoURL": photoURL,
        "password": password,
      };
  String toJson() => jsonEncode(toMap());
}
