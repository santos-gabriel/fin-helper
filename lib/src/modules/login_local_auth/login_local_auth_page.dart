import 'package:finhelper/src/modules/settings/settings_controller.dart';
import 'package:finhelper/src/shared/models/user_model.dart';
import 'package:finhelper/src/shared/themes/app_colors.dart';
import 'package:finhelper/src/shared/themes/app_images.dart';
import 'package:finhelper/src/shared/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

enum _SupportState {
  unknown,
  supported,
  unsupported,
}

enum _AuthorizedState {
  notAuthorized,
  authenticating,
  error,
  authorized,
}

class LoginLocalAuthPage extends StatefulWidget {
  final UserModel user;
  const LoginLocalAuthPage({Key? key, required this.user}) : super(key: key);

  @override
  _LoginLocalAuthPageState createState() => _LoginLocalAuthPageState();
}

class _LoginLocalAuthPageState extends State<LoginLocalAuthPage> {
  final LocalAuthentication auth = LocalAuthentication();
  SettingsController settings = SettingsController();
  // ignore: unused_field
  _SupportState _supportState = _SupportState.unknown;
  _AuthorizedState _authorizedState = _AuthorizedState.notAuthorized;
  // ignore: unused_field
  bool _isAuthenticating = false;

  @override
  void initState() {
    super.initState();
    auth.isDeviceSupported().then(
          (bool isSupported) => setState(() => _supportState = isSupported
              ? _SupportState.supported
              : _SupportState.unsupported),
        );
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorizedState = _AuthorizedState.authenticating;
      });
      authenticated = await auth.authenticate(
        localizedReason: 'Let OS determine authentication method',
        useErrorDialogs: true,
        stickyAuth: true,
      );
      setState(() {
        _isAuthenticating = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorizedState = _AuthorizedState.error;
      });
      return;
    }
    if (!mounted) {
      return;
    }
    setState(() {
      _authorizedState = authenticated
          ? _AuthorizedState.authorized
          : _AuthorizedState.notAuthorized;
    });
  }

  // ignore: unused_element
  Future<void> _cancelAuthentication() async {
    await auth.stopAuthentication();
    setState(() {
      _isAuthenticating = false;
    });
  }

  redirectToHomePage() {
    Navigator.pushReplacementNamed(context, "/home", arguments: widget.user);
  }

  loginLocalAuth() async {
    await settings.currentSettings();
    if (settings.settings.allowPasswordOnLogin) {
      await _authenticate();
    }
    if (!settings.settings.rememberLogin) {
      _authorizedState = _AuthorizedState.authorized;
    }
    if (_authorizedState == _AuthorizedState.authorized) {
      redirectToHomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteMedium,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Container(
              height: 250,
              width: 250,
              child: Image.asset(AppImages.logoFull),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 20,
              left: 50,
              right: 50,
            ),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: InkWell(
                  onTap: loginLocalAuth,
                  child: Container(
                    height: 56,
                    decoration: BoxDecoration(
                      color: AppColors.whiteSoft,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.fromBorderSide(
                          BorderSide(color: AppColors.graySoft, width: 0.5)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text(
                                  "Acessar",
                                  style: AppTextStyles.titleGraySoftRegular,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 16,
                              ),
                              Icon(Icons.arrow_right_alt_sharp),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
