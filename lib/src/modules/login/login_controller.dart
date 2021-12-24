import 'package:finhelper/src/shared/auth/auth_controller.dart';
import 'package:finhelper/src/shared/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController {
  final authController = AuthController();

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

  Future<void> localSignIn(
      BuildContext context, String name, String password) async {
    try {
      await authController.currentUser(context);
      if (authController.user != null) {
        if ((authController.user.name == name) &&
            (authController.user.password == password)) {
          final user =
              UserModel(name: name, photoURL: null, password: password);
          authController.setUser(context, user);
        }
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
