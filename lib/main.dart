import 'package:finhelper/src/app_widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(AppFirebase());
}

class AppFirebase extends StatefulWidget {
  const AppFirebase({Key? key}) : super(key: key);

  @override
  _AppFirebaseState createState() => _AppFirebaseState();
}

class _AppFirebaseState extends State<AppFirebase> {
  @override
  Widget build(BuildContext context) {
    return AppWidget();
  }
}
