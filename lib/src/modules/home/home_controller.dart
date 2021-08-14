import 'package:flutter/cupertino.dart';

enum BodyHomePages { Extract, Revenues, Expanses, Settings }

class HomeController extends ChangeNotifier {
  var currentPage = BodyHomePages.Extract;

  Future<void> setCurrentPage(BodyHomePages page) async {
    currentPage = page;
    notifyListeners();
  }
}
