import 'package:finhelper/src/shared/database/DBProvider.dart';
import 'package:finhelper/src/shared/models/movement_model.dart';

class ExtractController {
  Future<List<MovementModel>> getAllMovements() async {
    return await DBProvider.db.getAllMovement();
  }
}
