import 'dart:convert';

class UserModel {
  final int? id;
  final String name;
  final String? photoURL;
  final String? password;

  UserModel({this.id, required this.name, this.photoURL, this.password});

  UserModel copyWith({
    int? id,
    String? name,
    String? photoURL,
    String? password,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      photoURL: photoURL ?? this.photoURL,
      password: password ?? this.password,
    );
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      photoURL: map['photoURL'],
      password: map['password'],
    );
  }

  factory UserModel.fromJson(String json) =>
      UserModel.fromMap(jsonDecode(json));

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "photoURL": photoURL,
        "password": password,
      };
  String toJson() => jsonEncode(toMap());
}
