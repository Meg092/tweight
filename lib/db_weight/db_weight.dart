import 'dart:convert';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:today_weight/db_weight/weight_entity.dart';

class DBWeight extends GetxService {
  late Database dbBase;

  Future<DBWeight> init() async {
    await createWeightDB();
    return this;
  }

  createWeightDB() async {
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, 'weight.db');

    dbBase = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await createDanceTable(db);
        });
  }

  createDanceTable(Database db) async {
    await db.execute(
        'CREATE TABLE IF NOT EXISTS weight (id INTEGER PRIMARY KEY, createdTime TEXT, currentWeight INTEGER, list TEXT)');
  }

  insertWeight(WeightEntity entity) async {
    final id = await dbBase.insert('weight', {
      'createdTime': entity.createdTime.toIso8601String(),
      'currentWeight': entity.currentWeight,
      'list': jsonEncode(entity.list),
    });
    return id;
  }

  updateWeight(WeightEntity entity) async {
    await dbBase.update('weight', {
      'currentWeight': entity.currentWeight,
      'list': jsonEncode(entity.list),
    }, where: 'id = ?', whereArgs: [entity.id]);
  }

  cleanAllData() async {
    await dbBase.delete('weight');
  }

  Future<List<WeightEntity>> getWeightAllData() async {
    var result = await dbBase.query('weight', orderBy: 'createdTime DESC');
    return result.map((e) => WeightEntity.fromJson(e)).toList();
  }

}
