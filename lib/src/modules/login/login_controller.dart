import 'package:finhelper/src/shared/auth/auth_controller.dart';
import 'package:finhelper/src/shared/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController {
  final authController = AuthController();

  String name = '';

  void onChange({String? prName}) {
    name = prName!;
  }

  String? validateName(String? value) =>
      value?.isEmpty ?? true ? "Por favor, informe seu nome" : null;

  Future<void> localSignUp(
      BuildContext context, String name, String password) async {
    try {
      if (name.isNotEmpty && password.isNotEmpty) {
        final user = UserModel(name: name, photoURL: null, password: password);
        authController.setUser(context, user);
      }
    } catch (error) {
      print(error);
    }
  }

  bool validate() {
    bool bolName = name.isEmpty ? false : true;
    if (bolName) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> localSignIn(BuildContext context) async {
    try {
      if (validate()) {
        final user = UserModel(name: name, photoURL: null, password: null);
        authController.setUserPhoto(context, user);
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> googleSignIn(BuildContext context) async {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
      ],
    );
    try {
      final response = await _googleSignIn.signIn();
      final user =
          UserModel(name: response!.displayName!, photoURL: response.photoUrl);
      authController.setUser(context, user);
    } catch (error) {
      print(error);
    }
  }
}
