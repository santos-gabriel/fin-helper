import 'package:finhelper/src/app_widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(AppFinHelper());
}

class AppFinHelper extends StatefulWidget {
  const AppFinHelper({Key? key}) : super(key: key);

  @override
  _AppFinHelperState createState() => _AppFinHelperState();
}

class _AppFinHelperState extends State<AppFinHelper> {
  @override
  Widget build(BuildContext context) {
    return AppWidget();
  }
}
