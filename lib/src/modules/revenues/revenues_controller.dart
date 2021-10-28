import 'package:finhelper/src/shared/database/DBProvider.dart';
import 'package:finhelper/src/shared/models/revenue_model.dart';

class RevenuesController {
  Future<List<RevenueModel>> getAll() async {
    return await DBProvider.db.getAll();
  }
}
