import 'dart:convert';
import 'package:car_rental_app/feature/auth/models/auth_response_entity.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../resource/key_manger.dart';


abstract class HiveHelper {
  static Future<void> init() async {
    final directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    await openBoxes();
  }

  static void clear() {
    Hive.box(AppKeyManager.userBox).clear();
  }

  static Future<void> openBoxes() async {
    await Hive.openBox(AppKeyManager.userBox);
  }


  static void saveUser(
      {required String boxKey,
        required String saveKey,
        required AuthResponseEntity entity}) {
    var box = Hive.box(boxKey);
    box.put(saveKey, jsonEncode(entity));
  }


  static AuthResponseEntity getUser(
      {required String boxKey, required String saveKey}) {
    var box = Hive.box(boxKey);
    return authResponseEntityFromJson(box.get(saveKey));
  }

}
