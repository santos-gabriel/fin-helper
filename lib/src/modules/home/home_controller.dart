import 'package:finhelper/src/shared/database/DBProvider.dart';
import 'package:flutter/cupertino.dart';

enum BodyHomePages { Extract, Revenues, Expenses }

class HomeController extends ChangeNotifier {
  var currentPage = BodyHomePages.Extract;

  Future<double> getBalance() async {
    return await DBProvider.db.getBalance();
  }

  Future<void> setCurrentPage(BodyHomePages page) async {
    currentPage = page;
    notifyListeners();
  }
}
